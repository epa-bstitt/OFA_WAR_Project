import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { OverseerSettingsManager } from "@/components/features/overseer/OverseerSettingsManager";
import { getOverseerSettingsData } from "@/app/actions/overseer/settings";
import { getProjects } from "@/app/actions/admin/projects";
import { auth } from "@/lib/auth";
import { defaultOverseerSettings } from "@/lib/overseer-settings";

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
  if (!allowedRoles.includes(session.user.role as string)) {
    redirect("/dashboard");
  }

  const settingsResult = await getOverseerSettingsData();
  const projectsResult = await getProjects();
  const contributorAccess = settingsResult.success
    ? settingsResult.contributorAccess
    : defaultOverseerSettings.contributorAccess;
  const aggregatorAccess = settingsResult.success
    ? settingsResult.aggregatorAccess
    : defaultOverseerSettings.aggregatorAccess;
  const contributors = settingsResult.success ? settingsResult.contributors : [];
  const projects = projectsResult.success ? projectsResult.projects : [];

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
