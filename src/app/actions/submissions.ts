"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { submissionSchema, SubmissionInput, sanitizeRawText } from "@/lib/validation/submission";
import { getBiWeekDate, getCurrentBiWeek } from "@/lib/date-utils";
import { cookies } from "next/headers";

// Types matching Prisma schema
export interface Review {
  id: string;
  submissionId: string;
  reviewerId: string;
  status: string;
  comment?: string | null;
  createdAt: Date;
  updatedAt: Date;
}

export interface Submission {
  id: string;
  userId: string;
  weekOf: Date;
  rawText: string;
  terseText?: string | null;
  terseVersion?: string | null;
  status: "SUBMITTED" | "IN_REVIEW" | "APPROVED" | "REJECTED" | "PUBLISHED";
  isAiGenerated: boolean;
  aiConfidence?: number | null;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date | null;
}

export type SubmissionWithReviews = Submission & {
  reviews?: Review[];
};

// Mock submissions for demo mode
const mockSubmissions: SubmissionWithReviews[] = [
  {
    id: "mock-sub-1",
    rawText: "Completed API integration and fixed authentication bugs.",
    terseText: "API integration complete; auth bugs fixed.",
    status: "APPROVED",
    createdAt: new Date("2024-02-19"),
    updatedAt: new Date("2024-02-19"),
    aiConfidence: 0.92,
    userId: "demo-contributor",
    weekOf: new Date("2024-02-19"),
    isAiGenerated: true,
    reviews: [],
    deletedAt: null,
  },
  {
    id: "mock-sub-2",
    rawText: "Attended team meeting and reviewed PRs.",
    terseText: "Team meeting attended; PRs reviewed.",
    status: "IN_REVIEW",
    createdAt: new Date("2024-02-18"),
    updatedAt: new Date("2024-02-18"),
    aiConfidence: 0.88,
    userId: "demo-contributor",
    weekOf: new Date("2024-02-18"),
    isAiGenerated: true,
    reviews: [],
    deletedAt: null,
  },
];

function isMockModeEnabled(): boolean {
  const cookieStore = cookies();
  return cookieStore.get("admin-mock-mode")?.value === "true";
}

/**
 * Server Action: Submit WAR
 * Creates a new submission record in the database
 */
export async function submitWAR(data: SubmissionInput) {
  try {
    // 1. Check authentication
    const session = await auth();
    if (!session?.user?.id) {
      return {
        success: false,
        error: "Authentication required. Please sign in.",
      };
    }

    // 2. Validate input
    const validated = submissionSchema.safeParse(data);
    if (!validated.success) {
      const errorMessages = validated.error.issues.map((issue) => issue.message);
      return {
        success: false,
        error: errorMessages.join(", "),
      };
    }

    const { weekOf, rawText } = validated.data;

    // 3. Check for existing submission for this week
    const existingSubmission = await prisma.submission.findFirst({
      where: {
        userId: session.user.id,
        weekOf: weekOf,
      },
    });

    if (existingSubmission) {
      return {
        success: false,
        error: "You have already submitted a WAR for this week. Please edit your existing submission.",
      };
    }

    // 4. Sanitize the raw text
    const sanitizedText = sanitizeRawText(rawText);

    // 5. Create submission record
    const submission = await prisma.submission.create({
      data: {
        userId: session.user.id,
        weekOf: weekOf,
        rawText: sanitizedText,
        status: "SUBMITTED",
        isAiGenerated: false,
      },
    });

    // 6. Log to audit trail
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_CREATED",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: submission.id,
        metadata: {
          weekOf: weekOf.toISOString(),
          status: "SUBMITTED",
        },
      },
    });

    // 7. Revalidate dashboard to show new submission
    revalidatePath("/dashboard");

    return {
      success: true,
      submissionId: submission.id,
      message: "WAR submitted successfully!",
    };
  } catch (error) {
    console.error("Submit WAR error:", error);

    // Log error to audit trail
    if (error instanceof Error) {
      await prisma.auditLog.create({
        data: {
          action: "SUBMISSION_CREATE_FAILED",
          userId: "unknown", // We don't have user context here
          resourceType: "submission",
          resourceId: "failed",
          metadata: {
            error: error.message,
          },
        },
      }).catch(() => {
        // Ignore audit log errors
      });
    }

    return {
      success: false,
      error: "Failed to save submission. Please try again.",
    };
  }
}

/**
 * Server Action: Get bi-week options for the form
 * Returns valid bi-week periods for submission (current and previous period)
 */
export async function getWeekOptions() {
  const currentBiWeek = getCurrentBiWeek();
  const currentYear = new Date().getFullYear();
  const options = [];

  // Current bi-week period
  options.push({
    value: currentBiWeek,
    year: currentYear,
    label: `Period ${currentYear}-BW${currentBiWeek.toString().padStart(2, "0")}`,
  });

  // Previous bi-week period
  if (currentBiWeek > 1) {
    options.push({
      value: currentBiWeek - 1,
      year: currentYear,
      label: `Period ${currentYear}-BW${(currentBiWeek - 1).toString().padStart(2, "0")}`,
    });
  }

  return options;
}

/**
 * Server Action: Get current user's submissions
 */
export async function getMySubmissions(
  status?: string
): Promise<{ success: true; submissions: SubmissionWithReviews[] } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const where: Record<string, unknown> = {
      userId: session.user.id,
      deletedAt: null,
    };

    if (status && status !== "ALL") {
      where.status = status;
    }

    const submissions = await prisma.submission.findMany({
      where,
      orderBy: { weekOf: "desc" },
      include: {
        reviews: {
          orderBy: { createdAt: "desc" },
          take: 1,
        },
      },
    });

    return { success: true, submissions };
  } catch (error) {
    console.error("Error fetching submissions:", error);
    return { success: false, error: "Failed to fetch submissions" };
  }
}

/**
 * Server Action: Get a single submission by ID
 * Supports mock mode for demo submissions
 */
export async function getSubmissionById(
  id: string
): Promise<
  | { success: true; submission: SubmissionWithReviews }
  | { success: false; error: string }
> {
  try {
    // Check for mock mode and mock submission IDs
    if (isMockModeEnabled() && id.startsWith("mock-sub-")) {
      const mockSubmission = mockSubmissions.find((sub) => sub.id === id);
      if (mockSubmission) {
        return { success: true, submission: mockSubmission };
      }
    }

    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const submission = await prisma.submission.findFirst({
      where: {
        id,
        userId: session.user.id,
        deletedAt: null,
      },
      include: {
        reviews: {
          orderBy: { createdAt: "desc" },
        },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found" };
    }

    return { success: true, submission };
  } catch (error) {
    console.error("Error fetching submission:", error);
    return { success: false, error: "Failed to fetch submission" };
  }
}

/**
 * Server Action: Soft delete a submission
 */
export async function deleteSubmission(
  id: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Verify ownership and status
    const submission = await prisma.submission.findFirst({
      where: {
        id,
        userId: session.user.id,
        deletedAt: null,
        status: { in: ["SUBMITTED", "REJECTED"] },
      },
    });

    if (!submission) {
      return {
        success: false,
        error: "Submission not found or cannot be deleted",
      };
    }

    // Soft delete
    await prisma.submission.update({
      where: { id },
      data: { deletedAt: new Date() },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_DELETED",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: id,
        metadata: { deletedAt: new Date().toISOString() },
      },
    });

    revalidatePath("/submissions");
    revalidatePath("/dashboard");

    return { success: true };
  } catch (error) {
    console.error("Error deleting submission:", error);
    return { success: false, error: "Failed to delete submission" };
  }
}

/**
 * Type for submitWAR response
 */
export type SubmitWARResponse = {
  success: boolean;
  submissionId?: string;
  message?: string;
  error?: string;
};
