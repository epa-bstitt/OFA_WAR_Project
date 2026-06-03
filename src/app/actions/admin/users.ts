"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { logAuditEvent } from "@/lib/audit/logger";

// Manual type definitions to avoid Prisma import issues
export type User = {
  id: string;
  email: string;
  name: string | null;
  role: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
  azureAdId: string;
};

type UserWithStats = User & {
  _count: {
    submissions: number;
  };
};

const ROLE_HIERARCHY: Record<string, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

/**
 * Server Action: Get all users with optional filtering
 * Only accessible by ADMINISTRATOR role
 */
export async function getUsers(
  filters?: {
    search?: string;
    role?: string;
    isActive?: boolean;
  }
): Promise<
  | { success: true; users: UserWithStats[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can access
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    const where: Record<string, unknown> = {};

    if (filters?.search) {
      where.OR = [
        { name: { contains: filters.search, mode: "insensitive" } },
        { email: { contains: filters.search, mode: "insensitive" } },
      ];
    }

    if (filters?.role) {
      where.role = filters.role;
    }

    if (filters?.isActive !== undefined) {
      where.isActive = filters.isActive;
    }

    const users = await prisma.user.findMany({
      where,
      orderBy: { createdAt: "desc" },
      include: {
        _count: {
          select: {
            submissions: true,
          },
        },
      },
    });

    return { success: true, users: users as UserWithStats[] };
  } catch (error) {
    console.error("Error fetching users:", error);
    return { success: false, error: "Failed to fetch users" };
  }
}

/**
 * Server Action: Update user role
 */
export async function updateUserRole(
  userId: string,
  newRole: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can change roles
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    // Validate role
    if (!ROLE_HIERARCHY[newRole]) {
      return { success: false, error: "Invalid role" };
    }

    // Get current user data for audit
    const currentUser = await prisma.user.findUnique({
      where: { id: userId },
      select: { role: true, email: true },
    });

    if (!currentUser) {
      return { success: false, error: "User not found" };
    }

    // Update user role
    await prisma.user.update({
      where: { id: userId },
      data: {
        role: newRole,
        updatedAt: new Date(),
      },
    });

    // Log to audit trail
    await logAuditEvent({
      action: "USER_ROLE_CHANGED",
      userId: session.user.id,
      resourceType: "user",
      resourceId: userId,
      metadata: {
        oldRole: currentUser.role,
        newRole,
        targetUserEmail: currentUser.email,
      },
    });

    revalidatePath("/admin/users");

    return { success: true };
  } catch (error) {
    console.error("Error updating user role:", error);
    return { success: false, error: "Failed to update user role" };
  }
}

/**
 * Server Action: Disable user account
 */
export async function disableUser(
  userId: string,
  reason?: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can disable users
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    // Prevent disabling yourself
    if (userId === session.user.id) {
      return { success: false, error: "Cannot disable your own account" };
    }

    // Get user data for audit
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { email: true, role: true },
    });

    if (!user) {
      return { success: false, error: "User not found" };
    }

    // Prevent disabling other admins
    if (user.role === "ADMINISTRATOR") {
      return { success: false, error: "Cannot disable administrator accounts" };
    }

    // Disable user
    await prisma.user.update({
      where: { id: userId },
      data: {
        isActive: false,
        updatedAt: new Date(),
      },
    });

    // Log to audit trail
    await logAuditEvent({
      action: "USER_DISABLED",
      userId: session.user.id,
      resourceType: "user",
      resourceId: userId,
      metadata: {
        targetUserEmail: user.email,
        reason,
      },
    });

    revalidatePath("/admin/users");

    return { success: true };
  } catch (error) {
    console.error("Error disabling user:", error);
    return { success: false, error: "Failed to disable user" };
  }
}

/**
 * Server Action: Enable user account
 */
export async function enableUser(
  userId: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can enable users
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    // Get user data for audit
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { email: true },
    });

    if (!user) {
      return { success: false, error: "User not found" };
    }

    // Enable user
    await prisma.user.update({
      where: { id: userId },
      data: {
        isActive: true,
        updatedAt: new Date(),
      },
    });

    // Log to audit trail
    await logAuditEvent({
      action: "USER_ENABLED",
      userId: session.user.id,
      resourceType: "user",
      resourceId: userId,
      metadata: {
        targetUserEmail: user.email,
      },
    });

    revalidatePath("/admin/users");

    return { success: true };
  } catch (error) {
    console.error("Error enabling user:", error);
    return { success: false, error: "Failed to enable user" };
  }
}

/**
 * Server Action: Get user statistics
 */
export async function getUserStats(): Promise<
  | {
      success: true;
      stats: {
        totalUsers: number;
        activeUsers: number;
        inactiveUsers: number;
        byRole: Record<string, number>;
      };
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only ADMINISTRATOR can access
    const userRole = session.user.role as string;
    if (userRole !== "ADMINISTRATOR") {
      return { success: false, error: "Insufficient permissions" };
    }

    const [totalUsers, activeUsers, inactiveUsers, byRole] = await Promise.all([
      prisma.user.count(),
      prisma.user.count({ where: { isActive: true } }),
      prisma.user.count({ where: { isActive: false } }),
      prisma.user.groupBy({
        by: ["role"],
        _count: {
          role: true,
        },
      }),
    ]);

    const byRoleRecord: Record<string, number> = {};
    for (const { role, _count } of byRole) {
      byRoleRecord[role] = _count.role;
    }

    return {
      success: true,
      stats: {
        totalUsers,
        activeUsers,
        inactiveUsers,
        byRole: byRoleRecord,
      },
    };
  } catch (error) {
    console.error("Error fetching user stats:", error);
    return { success: false, error: "Failed to fetch user statistics" };
  }
}
