"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";

// Types matching Prisma schema
export interface Submission {
  id: string;
  userId: string;
  weekOf: Date;
  rawText: string;
  terseVersion?: string | null;
  status: "SUBMITTED" | "IN_REVIEW" | "APPROVED" | "REJECTED" | "PUBLISHED";
  isAiGenerated: boolean;
  aiConfidence?: number | null;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date | null;
}

export interface Review {
  id: string;
  submissionId: string;
  reviewerId: string;
  status: string;
  comment?: string | null;
  createdAt: Date;
  updatedAt: Date;
}

export interface User {
  id: string;
  name: string | null;
  email: string | null;
}

export type SubmissionWithUser = Submission & {
  user: User;
  reviews?: Review[];
};

export interface ReviewFilters {
  contributorId?: string;
  weekOf?: Date;
  search?: string;
}

/**
 * Server Action: Get pending submissions for review (AGGREGATOR only)
 */
export async function getPendingSubmissions(
  filters?: ReviewFilters
): Promise<
  | { success: true; submissions: SubmissionWithUser[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }
    
    const ROLE_HIERARCHY: Record<string, number> = {
      ADMINISTRATOR: 4,
      PROGRAM_OVERSEER: 3,
      AGGREGATOR: 2,
      CONTRIBUTOR: 1,
    };
    
    const userLevel = ROLE_HIERARCHY[session.user.role] || 0;
    if (userLevel < ROLE_HIERARCHY["AGGREGATOR"]) {
      return { success: false, error: "Insufficient permissions" };
    }

    const where: Record<string, unknown> = {
      status: "SUBMITTED",
      deletedAt: null,
    };

    if (filters?.contributorId) {
      where.userId = filters.contributorId;
    }

    if (filters?.weekOf) {
      where.weekOf = filters.weekOf;
    }

    if (filters?.search) {
      where.user = {
        name: { contains: filters.search, mode: "insensitive" },
      };
    }

    const submissions = await prisma.submission.findMany({
      where,
      orderBy: { createdAt: "asc" },
      include: {
        user: true,
        reviews: {
          orderBy: { createdAt: "desc" },
          take: 1,
        },
      },
    });

    return { success: true, submissions };
  } catch (error) {
    console.error("Error fetching pending submissions:", error);
    return { success: false, error: "Failed to fetch submissions" };
  }
}

/**
 * Server Action: Get review statistics
 */
export async function getReviewStats(): Promise<
  | {
      success: true;
      stats: {
        pending: number;
        reviewedToday: number;
        overdue: number;
        totalThisWeek: number;
      };
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }
    
    const ROLE_HIERARCHY: Record<string, number> = {
      ADMINISTRATOR: 4,
      PROGRAM_OVERSEER: 3,
      AGGREGATOR: 2,
      CONTRIBUTOR: 1,
    };
    
    const userLevel = ROLE_HIERARCHY[session.user.role] || 0;
    if (userLevel < ROLE_HIERARCHY["AGGREGATOR"]) {
      return { success: false, error: "Insufficient permissions" };
    }

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const weekAgo = new Date(today);
    weekAgo.setDate(weekAgo.getDate() - 7);
    const twoWeeksAgo = new Date(today);
    twoWeeksAgo.setDate(twoWeeksAgo.getDate() - 14);

    const [pending, reviewedToday, overdue, totalThisWeek] = await Promise.all([
      // Pending submissions
      prisma.submission.count({
        where: {
          status: "SUBMITTED",
          deletedAt: null,
        },
      }),

      // Reviewed today by this user
      prisma.review.count({
        where: {
          reviewerId: session.user.id,
          createdAt: { gte: today },
        },
      }),

      // Overdue submissions (>7 days old, still pending)
      prisma.submission.count({
        where: {
          status: "SUBMITTED",
          deletedAt: null,
          createdAt: { lt: weekAgo },
        },
      }),

      // Total submissions this week
      prisma.submission.count({
        where: {
          createdAt: { gte: weekAgo },
          deletedAt: null,
        },
      }),
    ]);

    return {
      success: true,
      stats: {
        pending,
        reviewedToday,
        overdue,
        totalThisWeek,
      },
    };
  } catch (error) {
    console.error("Error fetching review stats:", error);
    return { success: false, error: "Failed to fetch stats" };
  }
}

/**
 * Server Action: Create a review for a submission
 */
export async function createReview(
  submissionId: string,
  status: "APPROVED" | "REJECTED" | "CHANGES_REQUESTED",
  comment?: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }
    
    const ROLE_HIERARCHY: Record<string, number> = {
      ADMINISTRATOR: 4,
      PROGRAM_OVERSEER: 3,
      AGGREGATOR: 2,
      CONTRIBUTOR: 1,
    };
    
    const userLevel = ROLE_HIERARCHY[session.user.role] || 0;
    if (userLevel < ROLE_HIERARCHY["AGGREGATOR"]) {
      return { success: false, error: "Insufficient permissions" };
    }

    // Verify submission exists and is in reviewable state
    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        deletedAt: null,
        status: { in: ["SUBMITTED", "IN_REVIEW"] },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not reviewable" };
    }

    // Create review record
    await prisma.review.create({
      data: {
        submissionId,
        reviewerId: session.user.id,
        status,
        comment,
      },
    });

    // Update submission status
    await prisma.submission.update({
      where: { id: submissionId },
      data: {
        status: status === "APPROVED" ? "APPROVED" : status === "REJECTED" ? "REJECTED" : "IN_REVIEW",
        updatedAt: new Date(),
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "REVIEW_CREATED",
        userId: session.user.id,
        resourceType: "review",
        resourceId: submissionId,
        metadata: { status, comment },
      },
    });

    revalidatePath("/review");
    revalidatePath("/submissions");

    return { success: true };
  } catch (error) {
    console.error("Error creating review:", error);
    return { success: false, error: "Failed to create review" };
  }
}

/**
 * Server Action: Approve a submission
 */
export async function approveSubmission(
  submissionId: string,
  terseText: string,
  comment?: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }
    
    const ROLE_HIERARCHY: Record<string, number> = {
      ADMINISTRATOR: 4,
      PROGRAM_OVERSEER: 3,
      AGGREGATOR: 2,
      CONTRIBUTOR: 1,
    };
    
    const userLevel = ROLE_HIERARCHY[session.user.role] || 0;
    if (userLevel < ROLE_HIERARCHY["AGGREGATOR"]) {
      return { success: false, error: "Insufficient permissions" };
    }

    // Verify submission exists and is in SUBMITTED status
    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        deletedAt: null,
        status: { in: ["SUBMITTED", "IN_REVIEW"] },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not reviewable" };
    }

    // Create review record
    await prisma.review.create({
      data: {
        submissionId,
        reviewerId: session.user.id,
        status: "APPROVED",
        comment,
      },
    });

    // Update submission status and terse version
    await prisma.submission.update({
      where: { id: submissionId },
      data: {
        status: "APPROVED",
        terseVersion: terseText,
        updatedAt: new Date(),
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_APPROVED",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: submissionId,
        metadata: { terseTextLength: terseText.length, comment },
      },
    });

    revalidatePath("/review");
    revalidatePath("/submissions");

    return { success: true };
  } catch (error) {
    console.error("Error approving submission:", error);
    return { success: false, error: "Failed to approve submission" };
  }
}

/**
 * Server Action: Reject a submission
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
    
    const ROLE_HIERARCHY: Record<string, number> = {
      ADMINISTRATOR: 4,
      PROGRAM_OVERSEER: 3,
      AGGREGATOR: 2,
      CONTRIBUTOR: 1,
    };
    
    const userLevel = ROLE_HIERARCHY[session.user.role] || 0;
    if (userLevel < ROLE_HIERARCHY["AGGREGATOR"]) {
      return { success: false, error: "Insufficient permissions" };
    }

    // Verify submission exists and is in SUBMITTED status
    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        deletedAt: null,
        status: { in: ["SUBMITTED", "IN_REVIEW"] },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not reviewable" };
    }

    // Create review record
    await prisma.review.create({
      data: {
        submissionId,
        reviewerId: session.user.id,
        status: "REJECTED",
        comment: reason,
      },
    });

    // Update submission status
    await prisma.submission.update({
      where: { id: submissionId },
      data: {
        status: "REJECTED",
        updatedAt: new Date(),
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "SUBMISSION_REJECTED",
        userId: session.user.id,
        resourceType: "submission",
        resourceId: submissionId,
        metadata: { reason },
      },
    });

    revalidatePath("/review");
    revalidatePath("/submissions");

    return { success: true };
  } catch (error) {
    console.error("Error rejecting submission:", error);
    return { success: false, error: "Failed to reject submission" };
  }
}
