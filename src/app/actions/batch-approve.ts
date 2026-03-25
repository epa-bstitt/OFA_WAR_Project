"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";

const ROLE_HIERARCHY: Record<string, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

// In-memory cache for undoable actions (5 minute window)
const undoableActions = new Map<string, {
  action: "BATCH_APPROVED" | "BATCH_REJECTED";
  userId: string;
  submissionIds: string[];
  previousStatuses: Record<string, string>;
  notes?: string;
  timestamp: Date;
}>();

/**
 * Server Action: Batch approve multiple submissions
 */
export async function batchApprove(
  submissionIds: string[],
  notes?: string
): Promise<{ success: true; count: number; actionId: string } | { success: false; error: string }> {
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

    if (!submissionIds || submissionIds.length === 0) {
      return { success: false, error: "No submissions selected" };
    }

    // Verify all submissions are in IN_REVIEW status
    const submissions = await prisma.submission.findMany({
      where: {
        id: { in: submissionIds },
        deletedAt: null,
      },
    });

    const notInReview = submissions.filter((s: { status: string }) => s.status !== "IN_REVIEW");
    if (notInReview.length > 0) {
      return {
        success: false,
        error: `${notInReview.length} submission(s) are not in review status`,
      };
    }

    // Store previous statuses for undo
    const previousStatuses: Record<string, string> = {};
    submissions.forEach((s: { id: string; status: string }) => {
      previousStatuses[s.id] = s.status;
    });

    // Transactional update
    const result = await prisma.$transaction(async (tx: typeof prisma) => {
      // Update all submissions to APPROVED
      await tx.submission.updateMany({
        where: {
          id: { in: submissionIds },
          status: "IN_REVIEW",
        },
        data: {
          status: "APPROVED",
          updatedAt: new Date(),
        },
      });

      // Create review records for each approval
      for (const id of submissionIds) {
        await tx.review.create({
          data: {
            submissionId: id,
            reviewerId: session.user.id,
            status: "APPROVED",
            notes: notes || "Batch approved by Program Overseer",
          },
        });
      }

      // Log batch action
      await tx.auditLog.create({
        data: {
          action: "BATCH_APPROVED",
          userId: session.user.id,
          resourceType: "submission",
          resourceId: submissionIds[0],
          metadata: {
            submissionIds,
            count: submissionIds.length,
            notes,
            approvedAt: new Date().toISOString(),
          },
        },
      });

      return submissionIds.length;
    });

    // Store action for undo (5 minute window)
    const actionId = `batch-approve-${Date.now()}`;
    undoableActions.set(actionId, {
      action: "BATCH_APPROVED",
      userId: session.user.id,
      submissionIds,
      previousStatuses,
      notes,
      timestamp: new Date(),
    });

    // Clean up old actions (older than 5 minutes)
    const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
    const entries = Array.from(undoableActions.entries());
    for (const [key, action] of entries) {
      if (action.timestamp < fiveMinutesAgo) {
        undoableActions.delete(key);
      }
    }

    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true, count: result, actionId };
  } catch (error) {
    console.error("Error batch approving submissions:", error);
    return { success: false, error: "Failed to approve submissions" };
  }
}

/**
 * Server Action: Batch reject multiple submissions
 */
export async function batchReject(
  submissionIds: string[],
  reason: string
): Promise<{ success: true; count: number; actionId: string } | { success: false; error: string }> {
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

    if (!submissionIds || submissionIds.length === 0) {
      return { success: false, error: "No submissions selected" };
    }

    if (!reason || reason.trim().length === 0) {
      return { success: false, error: "Rejection reason is required" };
    }

    // Verify all submissions are in IN_REVIEW status
    const submissions = await prisma.submission.findMany({
      where: {
        id: { in: submissionIds },
        deletedAt: null,
      },
    });

    const notInReview = submissions.filter((s: { status: string }) => s.status !== "IN_REVIEW");
    if (notInReview.length > 0) {
      return {
        success: false,
        error: `${notInReview.length} submission(s) are not in review status`,
      };
    }

    // Store previous statuses for undo
    const previousStatuses: Record<string, string> = {};
    submissions.forEach((s: { id: string; status: string }) => {
      previousStatuses[s.id] = s.status;
    });

    // Transactional update
    const result = await prisma.$transaction(async (tx: typeof prisma) => {
      // Update all submissions back to SUBMITTED
      await tx.submission.updateMany({
        where: {
          id: { in: submissionIds },
          status: "IN_REVIEW",
        },
        data: {
          status: "SUBMITTED",
          updatedAt: new Date(),
        },
      });

      // Create review records for each rejection
      for (const id of submissionIds) {
        await tx.review.create({
          data: {
            submissionId: id,
            reviewerId: session.user.id,
            status: "REJECTED",
            notes: reason,
          },
        });
      }

      // Log batch action
      await tx.auditLog.create({
        data: {
          action: "BATCH_REJECTED",
          userId: session.user.id,
          resourceType: "submission",
          resourceId: submissionIds[0],
          metadata: {
            submissionIds,
            count: submissionIds.length,
            reason,
            rejectedAt: new Date().toISOString(),
          },
        },
      });

      return submissionIds.length;
    });

    // Store action for undo (5 minute window)
    const actionId = `batch-reject-${Date.now()}`;
    undoableActions.set(actionId, {
      action: "BATCH_REJECTED",
      userId: session.user.id,
      submissionIds,
      previousStatuses,
      notes: reason,
      timestamp: new Date(),
    });

    // Clean up old actions
    const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
    const entries = Array.from(undoableActions.entries());
    for (const [key, action] of entries) {
      if (action.timestamp < fiveMinutesAgo) {
        undoableActions.delete(key);
      }
    }

    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true, count: result, actionId };
  } catch (error) {
    console.error("Error batch rejecting submissions:", error);
    return { success: false, error: "Failed to reject submissions" };
  }
}

/**
 * Server Action: Undo a batch action within 5 minutes
 */
export async function undoBatchAction(
  actionId: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const action = undoableActions.get(actionId);
    if (!action) {
      return { success: false, error: "Action not found or has expired (5 minute window)" };
    }

    // Verify the user is the one who performed the action
    if (action.userId !== session.user.id) {
      return { success: false, error: "Cannot undo action performed by another user" };
    }

    // Check if within 5 minute window
    const fiveMinutesAgo = new Date(Date.now() - 5 * 60 * 1000);
    if (action.timestamp < fiveMinutesAgo) {
      undoableActions.delete(actionId);
      return { success: false, error: "Undo window has expired (5 minutes)" };
    }

    // Undo the action
    await prisma.$transaction(async (tx: typeof prisma) => {
      for (const submissionId of action.submissionIds) {
        const previousStatus = action.previousStatuses[submissionId];
        
        await tx.submission.update({
          where: { id: submissionId },
          data: {
            status: previousStatus,
            updatedAt: new Date(),
          },
        });
      }

      // Log undo action
      await tx.auditLog.create({
        data: {
          action: `${action.action}_UNDONE`,
          userId: session.user.id,
          resourceType: "submission",
          resourceId: action.submissionIds[0],
          metadata: {
            originalAction: action.action,
            actionId,
            submissionIds: action.submissionIds,
            undoneAt: new Date().toISOString(),
          },
        },
      });
    });

    // Remove from undoable actions
    undoableActions.delete(actionId);

    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true };
  } catch (error) {
    console.error("Error undoing batch action:", error);
    return { success: false, error: "Failed to undo action" };
  }
}

/**
 * Server Action: Check if an action can be undone
 */
export async function canUndoAction(
  actionId: string
): Promise<{ canUndo: boolean; timeRemaining?: number }> {
  const action = undoableActions.get(actionId);
  if (!action) {
    return { canUndo: false };
  }

  const fiveMinutes = 5 * 60 * 1000;
  const elapsed = Date.now() - action.timestamp.getTime();
  const remaining = Math.max(0, fiveMinutes - elapsed);

  if (remaining === 0) {
    undoableActions.delete(actionId);
    return { canUndo: false };
  }

  return { canUndo: true, timeRemaining: Math.floor(remaining / 1000) };
}
