import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { OverseerSettingsManager } from "@/components/features/overseer/OverseerSettingsManager";
import { getOverseerSettingsData } from "@/app/actions/overseer/settings";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { defaultOverseerSettings } from "@/lib/overseer-settings";
import { isJakeBejaUser } from "@/lib/work-modes";

export const metadata: Metadata = {
  title: "Settings",
  description: "Manage contributor visibility and contributor access.",
};

export const dynamic = "force-dynamic";

export default async function SettingsPage() {
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  const allowedRoles = ["PROGRAM_OVERSEER", "ADMINISTRATOR"];
  const canAccessSettings =
    allowedRoles.includes(session.user.role as string) || isJakeBejaUser(session.user.id, session.user.email);

  if (!canAccessSettings) {
    redirect("/dashboard");
  }

  const settingsResult = await getOverseerSettingsData();
  const contributorAccess = settingsResult.success
    ? settingsResult.contributorAccess
    : defaultOverseerSettings.contributorAccess;
  const aggregatorAccess = settingsResult.success
    ? settingsResult.aggregatorAccess
    : defaultOverseerSettings.aggregatorAccess;
  const contributors = settingsResult.success ? settingsResult.contributors : [];
  const projects = await prisma.project.findMany({
    include: {
      components: true,
      assignments: {
        include: {
          user: {
            select: {
              id: true,
              name: true,
              email: true,
            },
          },
          component: true,
        },
      },
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  return (
    <div className="space-y-6">
      <PageHeader
        title="Settings"
        description="Configure contributor visibility and manage contributor roster access."
      />

      <OverseerSettingsManager
        initialContributorAccess={contributorAccess}
        initialAggregatorAccess={aggregatorAccess}
        initialContributors={contributors}
        initialProjects={projects}
      />
    </div>
  );
}
