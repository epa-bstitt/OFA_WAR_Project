import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { SettingsManager } from "@/components/features/admin/SettingsManager";
import { TeamsBotWizard } from "@/components/features/admin/TeamsBotWizard";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";

export const metadata: Metadata = {
  title: "System Settings",
  description: "Configure AI, Database, and API connections",
};

export const dynamic = "force-dynamic";

export default async function SettingsPage() {
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

  return (
    <div className="space-y-6">
      <PageHeader
        title="System Settings"
        description="Configure AI services, database connections, and API integrations."
      />

      <SettingsManager />

      <TeamsBotWizard />
    </div>
  );
}
