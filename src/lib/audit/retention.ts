/**
 * Audit Log Retention Policy
 * Automatically enforces data retention rules for compliance
 */

import { prisma } from "@/lib/db";
import { logAdminEvent } from "./logger";

// Default retention periods (in days)
const RETENTION_PERIODS = {
  // Standard audit logs: 7 years (2555 days)
  STANDARD: 2555,
  // High-sensitivity logs: 3 years (1095 days)
  HIGH_SENSITIVITY: 1095,
  // System logs: 1 year (365 days)
  SYSTEM: 365,
  // Failed login attempts: 90 days
  FAILED_AUTH: 90,
};

// Actions that have shorter retention
const HIGH_SENSITIVITY_ACTIONS = new Set([
  "USER_SIGNIN",
  "USER_SIGNOUT",
  "FAILED_AUTH",
]);

// System-level actions
const SYSTEM_ACTIONS = new Set([
  "RETENTION_ENFORCED",
  "SYSTEM_MAINTENANCE",
  "BACKUP_CREATED",
]);

export interface RetentionResult {
  deletedCount: number;
  archivedCount: number;
  errors: string[];
}

/**
 * Calculate retention date based on action type
 */
function getRetentionDate(action: string): Date {
  const now = new Date();
  let days = RETENTION_PERIODS.STANDARD;

  if (HIGH_SENSITIVITY_ACTIONS.has(action)) {
    days = RETENTION_PERIODS.HIGH_SENSITIVITY;
  } else if (SYSTEM_ACTIONS.has(action)) {
    days = RETENTION_PERIODS.SYSTEM;
  }

  return new Date(now.getTime() - days * 24 * 60 * 60 * 1000);
}

/**
 * Enforce retention policy on audit logs
 * This should be run periodically (e.g., daily via cron job)
 */
export async function enforceRetentionPolicy(
  dryRun: boolean = false
): Promise<RetentionResult> {
  const result: RetentionResult = {
    deletedCount: 0,
    archivedCount: 0,
    errors: [],
  };

  try {
    // Get all unique actions
    const actions = await prisma.auditLog.groupBy({
      by: ["action"],
    });

    for (const { action } of actions) {
      const retentionDate = getRetentionDate(action);

      // Find logs to delete
      const logsToDelete = await prisma.auditLog.findMany({
        where: {
          action,
          createdAt: {
            lt: retentionDate,
          },
        },
        select: {
          id: true,
        },
      });

      if (logsToDelete.length === 0) {
        continue;
      }

      if (dryRun) {
        // Just count, don't delete
        result.deletedCount += logsToDelete.length;
        console.log(`[DRY RUN] Would delete ${logsToDelete.length} logs for action: ${action}`);
      } else {
        // Actually delete
        const deleteResult = await prisma.auditLog.deleteMany({
          where: {
            action,
            createdAt: {
              lt: retentionDate,
            },
          },
        });

        result.deletedCount += deleteResult.count;
        console.log(`Deleted ${deleteResult.count} logs for action: ${action}`);
      }
    }

    // Log retention enforcement
    if (!dryRun && result.deletedCount > 0) {
      await logAdminEvent(
        "RETENTION_ENFORCED",
        "system",
        {
          deletedCount: result.deletedCount,
          dryRun: false,
          timestamp: new Date().toISOString(),
        }
      );
    }

    return result;
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "Unknown error";
    result.errors.push(errorMessage);
    console.error("Error enforcing retention policy:", error);
    return result;
  }
}

/**
 * Archive old audit logs before deletion
 * Optional: Archive to external storage before deletion
 */
export async function archiveOldLogs(
  beforeDate: Date,
  archivePath?: string
): Promise<{ archived: number; error?: string }> {
  try {
    // Fetch logs to archive
    const logsToArchive = await prisma.auditLog.findMany({
      where: {
        createdAt: {
          lt: beforeDate,
        },
      },
    });

    if (logsToArchive.length === 0) {
      return { archived: 0 };
    }

    // In production, you would:
    // 1. Serialize logs to JSON/CSV
    // 2. Upload to S3/Azure Blob/etc
    // 3. Verify upload succeeded
    // 4. Then delete from database

    // For now, just simulate archiving
    console.log(`Would archive ${logsToArchive.length} logs to ${archivePath || "default location"}`);

    return { archived: logsToArchive.length };
  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : "Unknown error";
    return { archived: 0, error: errorMessage };
  }
}

/**
 * Get retention statistics
 */
export async function getRetentionStats(): Promise<{
  totalLogs: number;
  logsByAction: Record<string, number>;
  oldestLogDate: Date | null;
  newestLogDate: Date | null;
}> {
  const [totalLogs, logsByAction, dateRange] = await Promise.all([
    prisma.auditLog.count(),
    prisma.auditLog.groupBy({
      by: ["action"],
      _count: {
        action: true,
      },
    }),
    prisma.auditLog.aggregate({
      _min: {
        createdAt: true,
      },
      _max: {
        createdAt: true,
      },
    }),
  ]);

  const logsByActionRecord: Record<string, number> = {};
  for (const { action, _count } of logsByAction) {
    logsByActionRecord[action] = _count.action;
  }

  return {
    totalLogs,
    logsByAction: logsByActionRecord,
    oldestLogDate: dateRange._min.createdAt,
    newestLogDate: dateRange._max.createdAt,
  };
}

/**
 * Check if logs need retention enforcement
 */
export async function shouldEnforceRetention(): Promise<boolean> {
  const stats = await getRetentionStats();

  if (!stats.oldestLogDate) {
    return false;
  }

  const oldestAllowedDate = new Date();
  oldestAllowedDate.setDate(oldestAllowedDate.getDate() - RETENTION_PERIODS.STANDARD);

  return stats.oldestLogDate < oldestAllowedDate;
}

// Export retention periods for reference
export { RETENTION_PERIODS, HIGH_SENSITIVITY_ACTIONS, SYSTEM_ACTIONS };
