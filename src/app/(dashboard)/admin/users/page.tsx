import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { UserManager } from "@/components/features/admin/UserManager";
import { getUsers, getUserStats, updateUserRole, disableUser, enableUser } from "@/app/actions/admin/users";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { MockModeToggle } from "@/components/features/admin/MockModeToggle";
import { isMockModeEnabled } from "@/lib/admin/mock-mode-server";
import { mockUsers, mockUserStats } from "@/lib/admin/mock-data";

export const metadata: Metadata = {
  title: "User Management",
  description: "Manage users and their roles",
};

export const dynamic = "force-dynamic";

export default async function AdminUsersPage() {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (ADMINISTRATOR only)
  const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  // Check if mock mode is enabled
  const useMockData = isMockModeEnabled();

  let usersResult, statsResult;

  if (useMockData) {
    // Use mock data
    usersResult = { success: true, users: mockUsers };
    statsResult = { success: true, stats: mockUserStats };
  } else {
    // Fetch from real database
    [usersResult, statsResult] = await Promise.all([
      getUsers(),
      getUserStats(),
    ]);
  }

  if (!usersResult.success || !statsResult.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load user data</p>
      </div>
    );
  }

  // Server actions for client component (disabled in mock mode)
  async function handleUpdateRole(userId: string, newRole: string) {
    "use server";
    if (useMockData) {
      throw new Error("User management is disabled in mock mode");
    }
    const result = await updateUserRole(userId, newRole);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleDisableUser(userId: string, reason?: string) {
    "use server";
    if (useMockData) {
      throw new Error("User management is disabled in mock mode");
    }
    const result = await disableUser(userId, reason);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleEnableUser(userId: string) {
    "use server";
    if (useMockData) {
      throw new Error("User management is disabled in mock mode");
    }
    const result = await enableUser(userId);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="User Management"
        description="View and manage users, their roles, and account status."
      />

      {/* Mock Mode Toggle */}
      <MockModeToggle />

      <UserManager
        users={usersResult.users.map((user) => ({
          ...user,
          createdAt: user.createdAt.toISOString(),
          updatedAt: user.updatedAt.toISOString(),
        }))}
        stats={statsResult.stats}
        onUpdateRole={handleUpdateRole}
        onDisableUser={handleDisableUser}
        onEnableUser={handleEnableUser}
      />
    </div>
  );
}
