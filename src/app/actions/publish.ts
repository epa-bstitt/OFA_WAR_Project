"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { createPage, formatWARContent, isGraphConfigured, type OneNotePage } from "@/lib/graph/onenote";
import { withRetry, graphRetryOptions } from "@/lib/graph/retry";

const ROLE_HIERARCHY: Record<string, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

export interface PublicationResult {
  submissionId: string;
  success: boolean;
  oneNoteUrl?: string;
  error?: string;
}

/**
 * Server Action: Publish approved submissions to OneNote
 */
export async function publishToOneNote(
  submissionIds: string[],
  sectionId: string
): Promise<
  | {
      success: true;
      results: PublicationResult[];
      pageUrls: string[];
    }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check role - only PROGRAM_OVERSEER and ADMINISTRATOR can publish
    const userRole = session.user.role as string;
    const userLevel = ROLE_HIERARCHY[userRole] || 0;
    const minLevel = ROLE_HIERARCHY.PROGRAM_OVERSEER;

    if (userLevel < minLevel) {
      return { success: false, error: "Insufficient permissions" };
    }

    // Check if Microsoft Graph is configured
    if (!isGraphConfigured()) {
      return { success: false, error: "Microsoft Graph not configured" };
    }

    if (!submissionIds || submissionIds.length === 0) {
      return { success: false, error: "No submissions selected" };
    }

    // Fetch submissions with APPROVED status
    const submissions = await prisma.submission.findMany({
      where: {
        id: { in: submissionIds },
        status: "APPROVED",
        deletedAt: null,
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
      orderBy: [
        { year: "asc" },
        { weekNumber: "asc" },
        { user: { name: "asc" } },
      ],
    });

    if (submissions.length === 0) {
      return { success: false, error: "No approved submissions found" };
    }

    // Group submissions by week
    interface WeekGroup {
      year: number;
      weekNumber: number;
      weekOf: Date;
      submissions: typeof submissions;
    }
    
    const groupedByWeek: Record<string, WeekGroup> = submissions.reduce((acc: Record<string, WeekGroup>, sub: typeof submissions[0]) => {
      const key = `${sub.year}-W${sub.weekNumber}`;
      if (!acc[key]) {
        acc[key] = {
          year: sub.year,
          weekNumber: sub.weekNumber,
          weekOf: sub.weekOf,
          submissions: [],
        };
      }
      acc[key].submissions.push(sub);
      return acc;
    }, {} as Record<string, WeekGroup>);

    // Process each week group
    const results: PublicationResult[] = [];
    const pageUrls: string[] = [];

    for (const [, weekData] of Object.entries(groupedByWeek)) {
      const weekStart = weekData.weekOf.toLocaleDateString();
      const weekEnd = new Date(weekData.weekOf.getTime() + 6 * 24 * 60 * 60 * 1000).toLocaleDateString();

      // Format HTML content
      const htmlContent = formatWARContent(
        weekData.submissions.map((sub) => ({
          user: { name: sub.user.name, email: sub.user.email },
          terseText: sub.terseText,
          year: sub.year,
          weekNumber: sub.weekNumber,
          createdAt: sub.createdAt,
        })),
        weekStart,
        weekEnd
      );

      // Create page title
      const pageTitle = `EPA WAR - Week ${weekData.year}-W${weekData.weekNumber}`;

      // Publish to OneNote with retry
      const publishResult = await withRetry(
        () => createPage(pageTitle, htmlContent, sectionId),
        graphRetryOptions
      );

      if (publishResult.success) {
        const oneNotePage = publishResult.data;
        const oneNoteUrl = oneNotePage.links.oneNoteWebUrl?.href || oneNotePage.links.oneNoteClientUrl?.href;

        // Update all submissions in this week group
        for (const submission of weekData.submissions) {
          await prisma.submission.update({
            where: { id: submission.id },
            data: {
              status: "PUBLISHED",
              oneNoteUrl: oneNoteUrl || null,
              publishedAt: new Date(),
              updatedAt: new Date(),
            },
          });

          results.push({
            submissionId: submission.id,
            success: true,
            oneNoteUrl: oneNoteUrl || undefined,
          });
        }

        if (oneNoteUrl) {
          pageUrls.push(oneNoteUrl);
        }
      } else {
        // Mark all submissions in this week as failed
        for (const submission of weekData.submissions) {
          results.push({
            submissionId: submission.id,
            success: false,
            error: publishResult.error,
          });
        }
      }
    }

    // Log publication action
    const successCount = results.filter((r) => r.success).length;
    const failureCount = results.filter((r) => !r.success).length;

    await prisma.auditLog.create({
      data: {
        action: "PUBLISHED_TO_ONENOTE",
        userId: session.user.id,
        resourceType: "publication",
        resourceId: "batch",
        metadata: {
          submissionIds,
          sectionId,
          successCount,
          failureCount,
          pageUrls,
          publishedAt: new Date().toISOString(),
        },
      },
    });

    revalidatePath("/publish");
    revalidatePath("/approve");
    revalidatePath("/dashboard");

    return { success: true, results, pageUrls };
  } catch (error) {
    console.error("Error publishing to OneNote:", error);
    return { success: false, error: "Failed to publish to OneNote" };
  }
}

/**
 * Server Action: Get approved submissions ready for publication
 */
export async function getApprovedSubmissions(
  filters?: {
    week?: number;
    year?: number;
  }
): Promise<
  | {
      success: true;
      submissions: Array<{
        id: string;
        terseText: string | null;
        year: number;
        weekNumber: number;
        weekOf: Date;
        status: string;
        user: {
          id: string;
          name: string | null;
          email: string;
        };
        aiConfidence: number | null;
        oneNoteUrl: string | null;
        publishedAt: Date | null;
      }>;
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

    const where: Record<string, unknown> = {
      status: { in: ["APPROVED", "PUBLISHED"] },
      deletedAt: null,
    };

    if (filters?.year) {
      where.year = filters.year;
    }

    if (filters?.week) {
      where.weekNumber = filters.week;
    }

    const submissions = await prisma.submission.findMany({
      where,
      orderBy: [
        { year: "desc" },
        { weekNumber: "desc" },
        { user: { name: "asc" } },
      ],
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

    return { success: true, submissions };
  } catch (error) {
    console.error("Error fetching approved submissions:", error);
    return { success: false, error: "Failed to fetch submissions" };
  }
}

/**
 * Server Action: Get available OneNote sections
 */
export async function getOneNoteSections(): Promise<
  | {
      success: true;
      sections: Array<{ id: string; displayName: string }>;
      defaultSectionId: string | null;
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

    // Check if Microsoft Graph is configured
    if (!isGraphConfigured()) {
      return { success: false, error: "Microsoft Graph not configured" };
    }

    const { listSections } = await import("@/lib/graph/onenote");
    const sections = await listSections();

    const defaultSectionId = process.env.MS_GRAPH_ONENOTE_SECTION_ID || null;

    return {
      success: true,
      sections: sections.map((s) => ({ id: s.id, displayName: s.displayName })),
      defaultSectionId,
    };
  } catch (error) {
    console.error("Error fetching OneNote sections:", error);
    return { success: false, error: "Failed to fetch OneNote sections" };
  }
}
