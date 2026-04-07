import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { PublishPanel } from "@/components/features/publish/PublishPanel";
import { getApprovedSubmissions, getOneNoteSections, publishToOneNote } from "@/app/actions/publish";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";

export const metadata: Metadata = {
  title: "Publish to OneNote",
  description: "Publish approved WAR submissions to OneNote",
};

export const dynamic = "force-dynamic";

export default async function PublishPage() {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (PROGRAM_OVERSEER+)
  const hasPermission = await hasMinimumRoleLevel("PROGRAM_OVERSEER");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  // Fetch data
  const [submissionsResult, sectionsResult] = await Promise.all([
    getApprovedSubmissions(),
    getOneNoteSections(),
  ]);

  if (!submissionsResult.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load submissions</p>
      </div>
    );
  }

  // Server action for publishing
  async function handlePublish(submissionIds: string[], sectionId: string) {
    "use server";
    const result = await publishToOneNote(submissionIds, sectionId);
    return result;
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Publish to OneNote"
        description="Publish approved WAR submissions to OneNote for archival and sharing."
      />

      <PublishPanel
        submissions={submissionsResult.submissions}
        sections={sectionsResult.success ? sectionsResult.sections : []}
        defaultSectionId={sectionsResult.success ? sectionsResult.defaultSectionId : null}
        onPublish={handlePublish}
      />
    </div>
  );
}
