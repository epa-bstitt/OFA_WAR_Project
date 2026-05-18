"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { logAuditEvent, logAuditEvents } from "@/lib/audit/logger";
import { getStoredSettings, setStoredSettings } from "@/app/api/admin/settings/store";
import {
  type AggregatorAccessSettings,
  type ContributorAccessSettings,
  getOverseerSettings,
} from "@/lib/overseer-settings";

export type ManagedContributor = {
  id: string;
  email: string;
  name: string | null;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
};

function hasOverseerAccess(role: string | undefined) {
  return role === "PROGRAM_OVERSEER" || role === "ADMINISTRATOR";
}

async function requireOverseerAccess() {
  const session = await auth();
  if (!session?.user?.id || !hasOverseerAccess(session.user.role)) {
    throw new Error("Insufficient permissions");
  }

  return session.user;
}

export async function getOverseerSettingsData(): Promise<{
  success: true;
  contributorAccess: ContributorAccessSettings;
  aggregatorAccess: AggregatorAccessSettings;
  contributors: ManagedContributor[];
} | {
  success: false;
  error: string;
}> {
  try {
    await requireOverseerAccess();

    const [storedSettings, contributors] = await Promise.all([
      getStoredSettings(),
      prisma.user.findMany({
        where: { role: "CONTRIBUTOR" },
        orderBy: [{ isActive: "desc" }, { name: "asc" }],
        select: {
          id: true,
          email: true,
          name: true,
          isActive: true,
          createdAt: true,
          updatedAt: true,
        },
      }),
    ]);

    return {
      success: true,
      contributorAccess: getOverseerSettings(storedSettings).contributorAccess,
      aggregatorAccess: getOverseerSettings(storedSettings).aggregatorAccess,
      contributors,
    };
  } catch (error) {
    console.error("Error loading overseer settings:", error);
    return { success: false, error: "Failed to load overseer settings" };
  }
}

export async function updateContributorAccessSettings(
  nextSettings: ContributorAccessSettings
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const currentUser = await requireOverseerAccess();
    const storedSettings = await getStoredSettings();
    const currentSettings = getOverseerSettings(storedSettings).contributorAccess;
    const changedFields = Object.keys(nextSettings).filter((field) => {
      const key = field as keyof ContributorAccessSettings;
      return currentSettings[key] !== nextSettings[key];
    });

    await setStoredSettings({
      overseer: {
        contributorAccess: nextSettings,
      },
    });

    if (changedFields.length > 0) {
      await logAuditEvent({
        action: "CONTRIBUTOR_SETTINGS_UPDATED",
        userId: currentUser.id,
        resourceType: "system",
        metadata: {
          changedFields,
        },
      });
    }

    revalidatePath("/settings");
    revalidatePath("/analytics");
    revalidatePath("/dashboard");
    revalidatePath("/submit");

    return { success: true };
  } catch (error) {
    console.error("Error updating contributor access settings:", error);
    return { success: false, error: "Failed to save contributor settings" };
  }
}

export async function updateAggregatorAccessSettings(
  nextSettings: AggregatorAccessSettings
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const currentUser = await requireOverseerAccess();
    const storedSettings = await getStoredSettings();
    const currentSettings = getOverseerSettings(storedSettings).aggregatorAccess;
    const changedFields = Object.keys(nextSettings).filter((field) => {
      const key = field as keyof AggregatorAccessSettings;
      return currentSettings[key] !== nextSettings[key];
    });

    await setStoredSettings({
      overseer: {
        aggregatorAccess: nextSettings,
      },
    });

    if (changedFields.length > 0) {
      await logAuditEvent({
        action: "AGGREGATOR_SETTINGS_UPDATED",
        userId: currentUser.id,
        resourceType: "system",
        metadata: {
          changedFields,
        },
      });
    }

    revalidatePath("/settings");
    revalidatePath("/review");
    revalidatePath("/prompts");

    return { success: true };
  } catch (error) {
    console.error("Error updating aggregator access settings:", error);
    return { success: false, error: "Failed to save aggregator settings" };
  }
}

export async function toggleContributorActive(
  userId: string,
  isActive: boolean
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const currentUser = await requireOverseerAccess();

    if (currentUser.id === userId) {
      return { success: false, error: "You cannot disable your own account." };
    }

    const contributor = await prisma.user.findUnique({
      where: { id: userId },
      select: { id: true, role: true, email: true, name: true },
    });

    if (!contributor || contributor.role !== "CONTRIBUTOR") {
      return { success: false, error: "Contributor not found" };
    }

    await prisma.user.update({
      where: { id: userId },
      data: {
        isActive,
        updatedAt: new Date(),
      },
    });

    await logAuditEvent({
      action: isActive ? "USER_ENABLED" : "USER_DISABLED",
      userId: currentUser.id,
      resourceType: "user",
      resourceId: userId,
      metadata: {
        targetUserEmail: contributor.email,
        targetUserName: contributor.name,
      },
    });

    revalidatePath("/settings");

    return { success: true };
  } catch (error) {
    console.error("Error toggling contributor state:", error);
    return { success: false, error: "Failed to update contributor status" };
  }
}

export async function bulkToggleContributorActive(
  userIds: string[],
  isActive: boolean
): Promise<{ success: true; updatedCount: number } | { success: false; error: string }> {
  try {
    const currentUser = await requireOverseerAccess();
    const uniqueUserIds = Array.from(new Set(userIds.filter(Boolean)));

    if (uniqueUserIds.length === 0) {
      return { success: false, error: "Select at least one contributor." };
    }

    if (uniqueUserIds.includes(currentUser.id)) {
      return { success: false, error: "You cannot change your own account with a bulk action." };
    }

    const contributors = await prisma.user.findMany({
      where: {
        id: { in: uniqueUserIds },
        role: "CONTRIBUTOR",
      },
      select: { id: true, email: true, name: true },
    });

    if (contributors.length === 0) {
      return { success: false, error: "No contributors found for the selected bulk action." };
    }

    await prisma.user.updateMany({
      where: {
        id: { in: contributors.map((contributor) => contributor.id) },
      },
      data: {
        isActive,
        updatedAt: new Date(),
      },
    });

    await logAuditEvents(
      contributors.map((contributor) => ({
        action: isActive ? "USER_ENABLED" : "USER_DISABLED",
        userId: currentUser.id,
        resourceType: "user" as const,
        resourceId: contributor.id,
        metadata: {
          targetUserEmail: contributor.email,
          targetUserName: contributor.name,
          bulkAction: true,
        },
      }))
    );

    revalidatePath("/settings");

    return { success: true, updatedCount: contributors.length };
  } catch (error) {
    console.error("Error bulk updating contributor state:", error);
    return { success: false, error: "Failed to update contributor statuses" };
  }
}

export async function addContributorUser(input: {
  name: string;
  email: string;
}): Promise<{ success: true; contributor: ManagedContributor } | { success: false; error: string }> {
  try {
    const currentUser = await requireOverseerAccess();

    const name = input.name.trim();
    const email = input.email.trim().toLowerCase();

    if (!name || !email) {
      return { success: false, error: "Name and email are required" };
    }

    const existingUser = await prisma.user.findUnique({
      where: { email },
      select: { id: true },
    });

    if (existingUser) {
      return { success: false, error: "A user with this email already exists" };
    }

    const contributor = await prisma.user.create({
      data: {
        name,
        email,
        role: "CONTRIBUTOR",
        isActive: true,
        azureAdId: `managed-${Date.now()}-${email.replace(/[^a-z0-9]/g, "-")}`,
      },
      select: {
        id: true,
        email: true,
        name: true,
        isActive: true,
        createdAt: true,
        updatedAt: true,
      },
    });

    await logAuditEvent({
      action: "USER_CREATED",
      userId: currentUser.id,
      resourceType: "user",
      resourceId: contributor.id,
      metadata: {
        targetUserEmail: contributor.email,
        targetUserName: contributor.name,
        role: "CONTRIBUTOR",
      },
    });

    revalidatePath("/settings");

    return { success: true, contributor };
  } catch (error) {
    console.error("Error adding contributor:", error);
    return { success: false, error: "Failed to add contributor" };
  }
}
