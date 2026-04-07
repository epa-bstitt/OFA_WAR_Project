"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";

// Manual type definitions to avoid Prisma import issues
type Submission = {
  id: string;
  rawText: string;
  terseText: string | null;
  weekOf: Date;
  year: number;
  weekNumber: number;
  status: string;
  userId: string;
  aiConfidence: number | null;
  createdAt: Date;
  updatedAt: Date;
  deletedAt: Date | null;
};

type Review = {
  id: string;
  submissionId: string;
  reviewerId: string;
  status: string;
  notes: string | null;
  aiTerseVersion: string | null;
  editedTerseVersion: string | null;
  createdAt: Date;
  updatedAt: Date;
  reviewer: User;
};

type User = {
  id: string;
  name: string | null;
  email: string;
  role: string;
};

export type SubmissionWithReviews = Submission & {
  reviews: Review[];
  user: User;
};

const ROLE_HIERARCHY: Record<string, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

/**
 * Server Action: Get submissions in IN_REVIEW status for approval
 * Only accessible by PROGRAM_OVERSEER and ADMINISTRATOR roles
 */
export async function getInReviewSubmissions(
  filters?: {
    week?: number;
    year?: number;
    contributorId?: string;
    reviewerId?: string;
    search?: string;
  }
): Promise<
  | { success: true; submissions: SubmissionWithReviews[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only PROGRAM_OVERSEER and ADMINISTRATOR can access
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    const where: Record<string, unknown> = {
      status: "IN_REVIEW",
      deletedAt: null,
    };

    // Apply filters
    if (filters?.week && filters?.year) {
      where.weekOf = {
        gte: new Date(filters.year, 0, 1),
        lte: new Date(filters.year, 11, 31),
      };
      where.weekNumber = filters.week;
    }

    if (filters?.contributorId) {
      where.userId = filters.contributorId;
    }

    if (filters?.search) {
      where.OR = [
        { rawText: { contains: filters.search, mode: "insensitive" } },
        { terseText: { contains: filters.search, mode: "insensitive" } },
      ];
    }

    // If filtering by reviewer, we need to join with reviews
    let reviewerFilter = {};
    if (filters?.reviewerId) {
      reviewerFilter = {
        reviews: {
          some: {
            reviewerId: filters.reviewerId,
          },
        },
      };
    }

    const submissions = await prisma.submission.findMany({
      where: { ...where, ...reviewerFilter },
      orderBy: { createdAt: "asc" }, // Oldest first
      include: {
        reviews: {
          orderBy: { createdAt: "desc" },
          include: {
            reviewer: {
              select: {
                id: true,
                name: true,
                email: true,
                role: true,
              },
            },
          },
        },
        user: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true,
          },
        },
      },
    });

    return { success: true, submissions: submissions as SubmissionWithReviews[] };
  } catch (error) {
    console.error("Error fetching in-review submissions:", error);
    return { success: false, error: "Failed to fetch submissions" };
  }
}

/**
 * Server Action: Get approval statistics
 */
export async function getApprovalStats(
  week?: number,
  year?: number
): Promise<
  | {
      success: true;
      stats: {
        totalInReview: number;
        approvedThisWeek: number;
        pendingCount: number;
        averageReviewTime: number;
      };
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    const currentYear = year || new Date().getFullYear();
    const currentWeek = week || getCurrentWeek();

    const [inReviewCount, approvedCount, pendingCount] = await Promise.all([
      prisma.submission.count({
        where: {
          status: "IN_REVIEW",
          deletedAt: null,
          year: currentYear,
          weekNumber: currentWeek,
        },
      }),
      prisma.submission.count({
        where: {
          status: "APPROVED",
          deletedAt: null,
          year: currentYear,
          weekNumber: currentWeek,
          updatedAt: {
            gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000), // Last 7 days
          },
        },
      }),
      prisma.submission.count({
        where: {
          status: { in: ["SUBMITTED", "REJECTED"] },
          deletedAt: null,
          year: currentYear,
          weekNumber: currentWeek,
        },
      }),
    ]);

    // Calculate average review time (from submission to IN_REVIEW status)
    const submissionsWithReviews = await prisma.submission.findMany({
      where: {
        status: "IN_REVIEW",
        deletedAt: null,
      },
      include: {
        reviews: {
          orderBy: { createdAt: "asc" },
          take: 1,
        },
      },
      take: 100,
    });

    let totalReviewTime = 0;
    let countWithReviews = 0;

    for (const sub of submissionsWithReviews) {
      if (sub.reviews.length > 0) {
        const reviewTime =
          sub.reviews[0].createdAt.getTime() - sub.createdAt.getTime();
        totalReviewTime += reviewTime;
        countWithReviews++;
      }
    }

    const averageReviewTime =
      countWithReviews > 0 ? Math.round(totalReviewTime / countWithReviews / (1000 * 60 * 60)) : 0; // In hours

    return {
      success: true,
      stats: {
        totalInReview: inReviewCount,
        approvedThisWeek: approvedCount,
        pendingCount: pendingCount,
        averageReviewTime,
      },
    };
  } catch (error) {
    console.error("Error fetching approval stats:", error);
    return { success: false, error: "Failed to fetch statistics" };
  }
}

/**
 * Server Action: Approve a submission (final approval by Program Overseer)
 */
export async function approveSubmission(
  submissionId: string,
  notes?: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    // Verify submission is in IN_REVIEW status
    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        status: "IN_REVIEW",
        deletedAt: null,
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not in review" };
    }

    // Update submission status to APPROVED
    await prisma.submission.update({
      where: { id: submissionId },
      data: {
        status: "APPROVED",
        updatedAt: new Date(),
      },
    });

    // Create approval record
    await prisma.review.create({
      data: {
        submissionId,
        reviewerId: session.user.id,
        status: "APPROVED",
        notes: notes || "Final approval by Program Overseer",
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_APPROVED",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: submissionId,
        metadata: { notes, approvedAt: new Date().toISOString() },
      },
    });

    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true };
  } catch (error) {
    console.error("Error approving submission:", error);
    return { success: false, error: "Failed to approve submission" };
  }
}

/**
 * Server Action: Reject a submission back to aggregator
 */
export async function rejectSubmission(
  submissionId: string,
  reason: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    if (!reason || reason.trim().length === 0) {
      return { success: false, error: "Rejection reason is required" };
    }

    // Verify submission is in IN_REVIEW status
    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        status: "IN_REVIEW",
        deletedAt: null,
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not in review" };
    }

    // Update submission status back to SUBMITTED
    await prisma.submission.update({
      where: { id: submissionId },
      data: {
        status: "SUBMITTED",
        updatedAt: new Date(),
      },
    });

    // Create rejection record
    await prisma.review.create({
      data: {
        submissionId,
        reviewerId: session.user.id,
        status: "REJECTED",
        notes: reason,
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_REJECTED_BY_OVERSEER",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: submissionId,
        metadata: { reason, rejectedAt: new Date().toISOString() },
      },
    });

    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true };
  } catch (error) {
    console.error("Error rejecting submission:", error);
    return { success: false, error: "Failed to reject submission" };
  }
}

/**
 * Server Action: Export submissions to CSV
 */
export async function exportSubmissionsToCSV(
  submissionIds?: string[]
): Promise<
  | { success: true; csv: string; filename: string }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    const where: Record<string, unknown> = {
      deletedAt: null,
    };

    if (submissionIds && submissionIds.length > 0) {
      where.id = { in: submissionIds };
    } else {
      where.status = "IN_REVIEW";
    }

    const submissions = await prisma.submission.findMany({
      where,
      include: {
        user: {
          select: {
            name: true,
            email: true,
          },
        },
        reviews: {
          orderBy: { createdAt: "desc" },
          take: 1,
          include: {
            reviewer: {
              select: {
                name: true,
                email: true,
              },
            },
          },
        },
      },
    });

    // Generate CSV
    const headers = [
      "Week",
      "Contributor",
      "Email",
      "Raw Text",
      "Terse Version",
      "Status",
      "AI Confidence",
      "Reviewer",
      "Submitted At",
    ];

    const rows = submissions.map((sub: typeof submissions[0]) => [
      `${sub.year}-W${sub.weekNumber.toString().padStart(2, "0")}`,
      sub.user.name || sub.user.email,
      sub.user.email,
      `"${(sub.rawText || "").replace(/"/g, '""')}"`,
      `"${(sub.terseText || "").replace(/"/g, '""')}"`,
      sub.status,
      sub.aiConfidence ? `${(sub.aiConfidence * 100).toFixed(1)}%` : "N/A",
      sub.reviews[0]?.reviewer.name || sub.reviews[0]?.reviewer.email || "N/A",
      sub.createdAt.toISOString(),
    ]);

    const csv = [headers.join(","), ...rows.map((row: string[]) => row.join(","))].join(
      "\n"
    );

    const filename = `war-submissions-${new Date().toISOString().split("T")[0]}.csv`;

    // Log export
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSIONS_EXPORTED",
        userId: session.user.id,
        resourceType: "export",
        resourceId: "csv",
        metadata: {
          count: submissions.length,
          filename,
          exportedAt: new Date().toISOString(),
        },
      },
    });

    return { success: true, csv, filename };
  } catch (error) {
    console.error("Error exporting submissions:", error);
    return { success: false, error: "Failed to export submissions" };
  }
}

// Helper function to get current week
function getCurrentWeek(): number {
  const now = new Date();
  const start = new Date(now.getFullYear(), 0, 1);
  const diff = now.getTime() - start.getTime();
  const oneWeek = 1000 * 60 * 60 * 24 * 7;
  return Math.floor(diff / oneWeek) + 1;
}
