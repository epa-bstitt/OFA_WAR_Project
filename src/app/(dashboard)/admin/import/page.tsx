import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { WarImportManager } from "@/components/features/admin/WarImportManager";

export const metadata: Metadata = {
  title: "WAR Import",
  description: "Import DOCX ZIP archives into WAR cards and baseline submissions",
};

export const dynamic = "force-dynamic";

export default async function AdminImportPage() {
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="WAR ZIP Import"
        description="Upload a ZIP of DOCX files to create cards, assignees, and baseline WAR submissions."
      />

      <WarImportManager />
    </div>
  );
}