import { Metadata } from "next";
import { notFound } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { PageHeader } from "@/components/shared/PageHeader";
import { getSubmissionById } from "@/app/actions/submissions";
import { SubmissionEditForm } from "@/components/features/submissions/SubmissionEditForm";

interface SubmissionEditPageProps {
  params: { id: string };
}

export async function generateMetadata(): Promise<Metadata> {
  return {
    title: "Edit Submission",
    description: "Update and resubmit your WAR submission",
  };
}

export default async function SubmissionEditPage({ params }: SubmissionEditPageProps) {
  const result = await getSubmissionById(params.id);

  if (!result.success) {
    notFound();
  }

  const submission = result.submission;
  const latestReviewStatus = submission.reviews?.[0]?.status;
  const canEdit = latestReviewStatus === "CHANGES_REQUESTED" || submission.status === "INFO_NEEDED";

  if (!canEdit) {
    notFound();
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Edit Submission"
        description="Update your content and resubmit after a reviewer comment has reopened the submission."
      />

      <Card>
        <CardHeader>
          <CardTitle>WAR Content</CardTitle>
        </CardHeader>
        <CardContent>
          <SubmissionEditForm submissionId={submission.id} initialText={submission.rawText} />
        </CardContent>
      </Card>
    </div>
  );
}
