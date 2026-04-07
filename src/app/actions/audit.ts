"use server";

import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { logAdminEvent } from "@/lib/audit/logger";

// Manual type definitions to avoid Prisma import issues
type AuditLog = {
  id: string;
  action: string;
  userId: string | null;
  resourceType: string;
  resourceId: string | null;
  metadata: unknown;
  ipAddress: string | null;
  userAgent: string | null;
  createdAt: Date;
  user: {
    id: string;
    name: string | null;
    email: string;
  } | null;
};

const ROLE_HIERARCHY: Record<string, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

/**
 * Server Action: Get audit logs with filtering
 * Only accessible by ADMINISTRATOR role
 */
export async function getAuditLogs(
  filters?: {
    userId?: string;
    action?: string;
    resourceType?: string;
    startDate?: Date;
    endDate?: Date;
    search?: string;
  },
  page: number = 1,
  pageSize: number = 50
): Promise<
  | {
      success: true;
      logs: AuditLog[];
      total: number;
      page: number;
      pageSize: number;
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can access audit logs
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    // Build where clause
    const where: Record<string, unknown> = {};

    if (filters?.userId) {
      where.userId = filters.userId;
    }

    if (filters?.action) {
      where.action = filters.action;
    }

    if (filters?.resourceType) {
      where.resourceType = filters.resourceType;
    }

    if (filters?.startDate || filters?.endDate) {
      where.createdAt = {};
      if (filters.startDate) {
        (where.createdAt as Record<string, Date>).gte = filters.startDate;
      }
      if (filters.endDate) {
        (where.createdAt as Record<string, Date>).lte = filters.endDate;
      }
    }

    if (filters?.search) {
      where.OR = [
        { action: { contains: filters.search, mode: "insensitive" } },
        { resourceType: { contains: filters.search, mode: "insensitive" } },
        { resourceId: { contains: filters.search, mode: "insensitive" } },
      ];
    }

    // Get total count
    const total = await prisma.auditLog.count({ where });

    // Get paginated logs
    const logs = await prisma.auditLog.findMany({
      where,
      orderBy: { createdAt: "desc" },
      skip: (page - 1) * pageSize,
      take: pageSize,
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });

    // Log that audit logs were viewed
    await logAdminEvent(
      "AUDIT_LOG_VIEWED",
      session.user.id,
      { filters, page, pageSize }
    );

    return {
      success: true,
      logs: logs as AuditLog[],
      total,
      page,
      pageSize,
    };
  } catch (error) {
    console.error("Error fetching audit logs:", error);
    return { success: false, error: "Failed to fetch audit logs" };
  }
}

/**
 * Server Action: Get unique actions for filtering
 */
export async function getAuditActions(): Promise<
  | { success: true; actions: string[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    const actions = await prisma.auditLog.groupBy({
      by: ["action"],
      orderBy: { action: "asc" },
    });

    return {
      success: true,
      actions: actions.map((a: { action: string }) => a.action),
    };
  } catch (error) {
    console.error("Error fetching audit actions:", error);
    return { success: false, error: "Failed to fetch actions" };
  }
}

/**
 * Server Action: Get unique resource types for filtering
 */
export async function getAuditResourceTypes(): Promise<
  | { success: true; resourceTypes: string[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    const types = await prisma.auditLog.groupBy({
      by: ["resourceType"],
      orderBy: { resourceType: "asc" },
    });

    return {
      success: true,
      resourceTypes: types.map((t: { resourceType: string }) => t.resourceType),
    };
  } catch (error) {
    console.error("Error fetching resource types:", error);
    return { success: false, error: "Failed to fetch resource types" };
  }
}

/**
 * Server Action: Export audit logs to CSV
 */
export async function exportAuditLogs(
  format: "csv" | "json" = "csv",
  filters?: {
    userId?: string;
    action?: string;
    resourceType?: string;
    startDate?: Date;
    endDate?: Date;
  }
): Promise<
  | { success: true; data: string; filename: string }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    // Build where clause
    const where: Record<string, unknown> = {};

    if (filters?.userId) {
      where.userId = filters.userId;
    }

    if (filters?.action) {
      where.action = filters.action;
    }

    if (filters?.resourceType) {
      where.resourceType = filters.resourceType;
    }

    if (filters?.startDate || filters?.endDate) {
      where.createdAt = {};
      if (filters.startDate) {
        (where.createdAt as Record<string, Date>).gte = filters.startDate;
      }
      if (filters.endDate) {
        (where.createdAt as Record<string, Date>).lte = filters.endDate;
      }
    }

    // Get all matching logs (limited to 10000 for safety)
    const logs = await prisma.auditLog.findMany({
      where,
      orderBy: { createdAt: "desc" },
      take: 10000,
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    });

    let data: string;
    let filename: string;
    const timestamp = new Date().toISOString().split("T")[0];

    if (format === "csv") {
      // Generate CSV
      const headers = ["timestamp", "action", "userId", "userEmail", "resourceType", "resourceId", "ipAddress"];
      const rows = logs.map((log: typeof logs[0]) => [
        log.createdAt.toISOString(),
        log.action,
        log.userId || "",
        log.user?.email || "",
        log.resourceType,
        log.resourceId || "",
        log.ipAddress || "",
      ]);

      data = [headers.join(","), ...rows.map((row: string[]) => row.join(","))].join("\n");
      filename = `audit-logs-${timestamp}.csv`;
    } else {
      // Generate JSON
      data = JSON.stringify(logs, null, 2);
      filename = `audit-logs-${timestamp}.json`;
    }

    // Log export action
    await logAdminEvent(
      "DATA_EXPORTED",
      session.user.id,
      { format, count: logs.length, filters }
    );

    return { success: true, data, filename };
  } catch (error) {
    console.error("Error exporting audit logs:", error);
    return { success: false, error: "Failed to export audit logs" };
  }
}

/**
 * Server Action: Get audit statistics
 */
export async function getAuditStats(
  days: number = 30
): Promise<
  | {
      success: true;
      stats: {
        totalEvents: number;
        eventsByAction: Record<string, number>;
        eventsByDay: Array<{ date: string; count: number }>;
        topUsers: Array<{ userId: string; count: number }>;
      };
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    const startDate = new Date();
    startDate.setDate(startDate.getDate() - days);

    // Get total events
    const totalEvents = await prisma.auditLog.count({
      where: {
        createdAt: {
          gte: startDate,
        },
      },
    });

    // Get events by action
    const eventsByActionRaw = await prisma.auditLog.groupBy({
      by: ["action"],
      where: {
        createdAt: {
          gte: startDate,
        },
      },
      _count: {
        action: true,
      },
    });

    const eventsByAction: Record<string, number> = {};
    for (const item of eventsByActionRaw) {
      eventsByAction[item.action] = item._count.action;
    }

    // Get events by day
    const eventsByDayRaw = await prisma.$queryRaw<Array<{ date: Date; count: bigint }>>`
      SELECT DATE("createdAt") as date, COUNT(*) as count
      FROM "audit_logs"
      WHERE "createdAt" >= ${startDate}
      GROUP BY DATE("createdAt")
      ORDER BY date DESC
    `;

    const eventsByDay = eventsByDayRaw.map((item: { date: Date; count: bigint }) => ({
      date: item.date.toISOString().split("T")[0],
      count: Number(item.count),
    }));

    // Get top users
    const topUsersRaw = await prisma.auditLog.groupBy({
      by: ["userId"],
      where: {
        createdAt: {
          gte: startDate,
        },
        userId: {
          not: null,
        },
      },
      _count: {
        userId: true,
      },
      orderBy: {
        _count: {
          userId: "desc",
        },
      },
      take: 10,
    });

    const topUsers = topUsersRaw.map((item: { userId: string | null; _count: { userId: number } }) => ({
      userId: item.userId || "unknown",
      count: item._count.userId,
    }));

    return {
      success: true,
      stats: {
        totalEvents,
        eventsByAction,
        eventsByDay,
        topUsers,
      },
    };
  } catch (error) {
    console.error("Error fetching audit stats:", error);
    return { success: false, error: "Failed to fetch audit statistics" };
  }
}
