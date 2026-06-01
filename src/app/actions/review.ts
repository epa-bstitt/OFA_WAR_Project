"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
// import { getContractsOutlook, MOCK_CONTRACT_ASSIGNEES } from "@/lib/mock-contracts";
import { getCurrentSubmissionPeriod, getRecentSubmissionPeriods } from "@/lib/submission-periods";
// import { isMockModeEnabled } from "@/lib/admin/mock-mode-server";
import { logWorkflowEvent } from "@/lib/audit/logger";

function serializeAuditMetadata(metadata: Record<string, unknown>): string {
  try {
    return JSON.stringify(metadata);
  } catch {
    return "{}";
  }
}

// Types matching Prisma schema
export interface Submission {
  id: string;
  userId: string;
  projectId?: string | null;
  contractId?: string | null;
  weekOf: Date;
  rawText: string;
  terseVersion?: string | null;
  status: string;
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

// Update SubmissionWithUser type to enforce status as a specific enum
export type SubmissionWithUser = Submission & {
  user: {
    id: string;
    createdAt: Date;
    updatedAt: Date;
    name: string | null;
    email: string | null;
    azureAdId: string;
    role: string;
    isActive: boolean;
    teamsNotificationsEnabled: boolean;
    teamsConversationId: string | null;
    teamsConversationReference: string | null;
  };
  reviews: Review[];
};

// Ensure status property uses Prisma schema enum values
export type Status = "SUBMITTED" | "IN_REVIEW" | "APPROVED" | "PUBLISHED" | "INFO_NEEDED" | "REJECTED";

export interface ReviewFilters {
  contributorId?: string;
  weekOf?: Date;
  search?: string;
  statuses?: Array<"SUBMITTED" | "IN_REVIEW" | "INFO_NEEDED" | "APPROVED" | "REJECTED" | "PUBLISHED">;
}

type StaffSubmissionStatus = "NOT_STARTED" | "IN_PROGRESS" | "COMPLETED";

export interface BiWeeklyStaffSubmissionCard {
  userId: string;
  name: string;
  email: string;
  profileImageUrl: string;
  status: StaffSubmissionStatus;
  submittedProjects: string[];
  remainingProjects: string[];
  totalProjects: number;
  submittedCount: number;
}

export interface BiWeeklyStaffSubmissionPeriod {
  periodId: string;
  label: string;
  deadline: Date;
  cards: BiWeeklyStaffSubmissionCard[];
}

const PROFILE_IMAGE_POOL = [
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=320&q=80",
  "https://images.unsplash.com/photo-1521119989659-a83eee488004?auto=format&fit=crop&w=320&q=80",
  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=320",
  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=320",
];

function getProfileImageForUser(userId: string): string {
  let hash = 0;
  for (let i = 0; i < userId.length; i += 1) {
    hash = (hash + userId.charCodeAt(i) * (i + 1)) % PROFILE_IMAGE_POOL.length;
  }
  return PROFILE_IMAGE_POOL[hash];
}

function isLegacyContractProject(description: string | null | undefined): boolean {
  if (!description) {
    return false;
  }

  try {
    const parsed = JSON.parse(description) as { category?: string };
    return parsed.category === "Legacy Contracts";
  } catch {
    return false;
  }
}

function isLegacyProjectDescription(description: string | null | undefined): boolean {
  if (!description) {
    return false;
  }

  try {
    const parsed = JSON.parse(description) as { category?: string };
    return parsed.category === "Legacy Contracts";
  } catch {
    return false;
  }
}

// function getMockBiWeeklyPeriods(now: Date): BiWeeklyStaffSubmissionPeriod[] { /* removed for real workflow */ }

/**
 * Server Action: Get contributor submission status cards by bi-week period.
 */
export async function getBiWeeklyStaffSubmissionStatus(): Promise<
  | { success: true; periods: BiWeeklyStaffSubmissionPeriod[] }
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
    const currentPeriod = getCurrentSubmissionPeriod(now);
    const periodsToLoad = getRecentSubmissionPeriods(now, 8);

    const contributors = await prisma.user.findMany({
      where: {
        role: "CONTRIBUTOR",
        isActive: true,
      },
      select: {
        id: true,
        name: true,
        email: true,
      },
      orderBy: {
        name: "asc",
      },
    });

    const assignments = await prisma.projectAssignment.findMany({
      where: {
        userId: { in: contributors.map((user) => user.id) },
        project: {
          status: { not: "COMPLETED" },
        },
      },
      include: {
        project: {
          select: {
            id: true,
            name: true,
            description: true,
          },
        },
      },
    });

    if (contributors.length === 0 || assignments.length === 0) {
      return { success: false, error: "No contributors or assignments found." };
    }

    const assignmentMap = new Map<
      string,
      Array<{ projectId: string; projectName: string }>
    >();

    for (const assignment of assignments) {
      if (isLegacyContractProject(assignment.project.description)) {
        continue;
      }

      const current = assignmentMap.get(assignment.userId) || [];
      if (!current.some((item) => item.projectId === assignment.projectId)) {
        current.push({ projectId: assignment.projectId, projectName: assignment.project.name });
      }
      assignmentMap.set(assignment.userId, current);
    }

    const periods: BiWeeklyStaffSubmissionPeriod[] = [];

    for (const period of periodsToLoad) {
      const submissions = await prisma.submission.findMany({
        where: {
          deletedAt: null,
          weekOf: {
            gte: period.start,
            lte: period.end,
          },
          status: {
            in: ["SUBMITTED", "IN_REVIEW", "APPROVED", "PUBLISHED"],
          },
        },
        select: {
          userId: true,
          projectId: true,
        },
      });

      const submissionMap = new Map<string, { projectIds: Set<string>; hasGenericSubmission: boolean }>();

      for (const submission of submissions) {
        const current = submissionMap.get(submission.userId) || {
          projectIds: new Set<string>(),
          hasGenericSubmission: false,
        };

        if (submission.projectId) {
          current.projectIds.add(submission.projectId);
        } else {
          current.hasGenericSubmission = true;
        }

        submissionMap.set(submission.userId, current);
      }

      const cards: BiWeeklyStaffSubmissionCard[] = contributors.map((user) => {
        const assignedProjects = assignmentMap.get(user.id) || [];
        const submissionState = submissionMap.get(user.id) || {
          projectIds: new Set<string>(),
          hasGenericSubmission: false,
        };

        const submittedProjects = submissionState.hasGenericSubmission
          ? assignedProjects.map((project) => project.projectName)
          : assignedProjects
              .filter((project) => submissionState.projectIds.has(project.projectId))
              .map((project) => project.projectName);

        const remainingProjects = submissionState.hasGenericSubmission
          ? []
          : assignedProjects
              .filter((project) => !submissionState.projectIds.has(project.projectId))
              .map((project) => project.projectName);

        const submittedCount = submittedProjects.length;
        const totalProjects = assignedProjects.length;

        let status: StaffSubmissionStatus = "NOT_STARTED";
        if (submissionState.hasGenericSubmission) {
          status = "COMPLETED";
        } else if (totalProjects > 0 && remainingProjects.length === 0 && submittedCount > 0) {
          status = "COMPLETED";
        } else if (submittedCount > 0) {
          status = "IN_PROGRESS";
        }

        return {
          userId: user.id,
          name: user.name || user.email,
          email: user.email,
          profileImageUrl: getProfileImageForUser(user.id),
          status,
          submittedProjects,
          remainingProjects,
          totalProjects,
          submittedCount,
        };
      });

      periods.push({
        periodId: period.id,
        label: `Bi-Weekly ${period.label}${period.id === currentPeriod.id ? " (Current)" : ""}`,
        deadline: period.deadline,
        cards,
      });
    }

    return { success: true, periods };
  } catch (error) {
    console.error("Error fetching bi-weekly staff status:", error);
    return { success: false, error: "Error fetching bi-weekly staff status and no mock data fallback." };
  }
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
      status: {
        in: filters?.statuses && filters.statuses.length > 0 ? filters.statuses : ["SUBMITTED"],
      },
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
      orderBy: { updatedAt: "desc" },
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
          status: { in: ["SUBMITTED", "INFO_NEEDED"] },
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
          status: { in: ["SUBMITTED", "INFO_NEEDED"] },
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

    const submission = await prisma.submission.findFirst({
      where: {
        id: submissionId,
        deletedAt: null,
        status: { in: ["SUBMITTED", "IN_REVIEW", "INFO_NEEDED"] },
      },
      include: {
        project: {
          select: {
            description: true,
          },
        },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not in a reviewable state." };
    }

    if (isLegacyProjectDescription(submission.project?.description)) {
      return { success: false, error: "Legacy contracts are retired and cannot be reviewed or approved." };
    }

    // Update submission status
    await prisma.submission.update({
      where: { id: submissionId },
      data: { status },
    });

    // Update workflow state
    await prisma.workflowState.upsert({
      where: { submissionId },
      update: { currentStage: status },
      create: {
        submissionId,
        currentStage: status,
        updatedAt: new Date(),
      },
    });

    // Log workflow event
    await logWorkflowEvent(
      status === "APPROVED"
        ? "SUBMISSION_APPROVED"
        : status === "REJECTED"
        ? "SUBMISSION_REJECTED"
        : "SUBMISSION_PUBLISHED", // Adjusted to use a valid action type
      session.user.id,
      submissionId,
      { approverName: session.user.name, rejectionReason: comment }
    );

    return { success: true };
  } catch (error) {
    console.error("Error creating review:", error);
    return { success: false, error: "Failed to create review." };
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
      include: {
        project: {
          select: {
            description: true,
          },
        },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not reviewable" };
    }

    if (isLegacyProjectDescription(submission.project?.description)) {
      return { success: false, error: "Legacy contracts are retired and cannot be approved." };
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
        metadata: serializeAuditMetadata({ terseTextLength: terseText.length, comment }),
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
      include: {
        project: {
          select: {
            description: true,
          },
        },
      },
    });

    if (!submission) {
      return { success: false, error: "Submission not found or not reviewable" };
    }

    if (isLegacyProjectDescription(submission.project?.description)) {
      return { success: false, error: "Legacy contracts are retired and cannot be changed." };
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
        metadata: serializeAuditMetadata({ reason }),
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
