import { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Button } from "@/components/ui/button";
import { CardGrid } from "@/components/shared/CardGrid";
import { PageHeader } from "@/components/shared/PageHeader";
import { getMySubmissions } from "@/app/actions/submissions";
import { SubmissionCard } from "@/components/features/submissions/SubmissionCard";
import { Plus } from "lucide-react";

export const metadata: Metadata = {
  title: "My Submissions",
  description: "View and manage your WAR submissions",
};

export const dynamic = "force-dynamic";

export default async function SubmissionsPage() {
  const result = await getMySubmissions();

  if (!result.success) {
    redirect("/login");
  }

  const submissions = result.submissions;

  return (
    <div className="space-y-6">
      <PageHeader
        title="My Submissions"
        description="View and manage your weekly activity report submissions"
      >
        <Link href="/submit">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            New Submission
          </Button>
        </Link>
      </PageHeader>

      {submissions.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-muted-foreground mb-4">
            No submissions yet. Create your first WAR submission.
          </p>
          <Link href="/submit">
            <Button>Submit WAR</Button>
          </Link>
        </div>
      ) : (
        <CardGrid columns={2}>
          {submissions.map((submission) => (
            <SubmissionCard key={submission.id} submission={submission} />
          ))}
        </CardGrid>
      )}
    </div>
  );
}
