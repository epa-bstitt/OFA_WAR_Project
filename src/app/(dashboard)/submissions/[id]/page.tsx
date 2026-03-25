import { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { format } from "date-fns";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { PageHeader } from "@/components/shared/PageHeader";
import { StatusBadge } from "@/components/features/submissions/StatusBadge";
import { getSubmissionById } from "@/app/actions/submissions";
import { Edit, ArrowLeft } from "lucide-react";

interface SubmissionDetailPageProps {
  params: { id: string };
}

export async function generateMetadata({ params }: SubmissionDetailPageProps): Promise<Metadata> {
  return {
    title: "Submission Details",
    description: "View WAR submission details",
  };
}

export default async function SubmissionDetailPage({ params }: SubmissionDetailPageProps) {
  const result = await getSubmissionById(params.id);

  if (!result.success) {
    notFound();
  }

  const submission = result.submission;
  const canEdit = submission.status === "SUBMITTED";

  return (
    <div className="space-y-6">
      <PageHeader title="Submission Details">
        <div className="flex gap-2">
          {canEdit && (
            <Link href={`/submissions/${submission.id}/edit`}>
              <Button variant="outline">
                <Edit className="mr-2 h-4 w-4" />
                Edit
              </Button>
            </Link>
          )}
          <Link href="/submissions">
            <Button variant="outline">
              <ArrowLeft className="mr-2 h-4 w-4" />
              Back
            </Button>
          </Link>
        </div>
      </PageHeader>

      <div className="grid gap-6">
        <Card>
          <CardHeader>
            <div className="flex items-center justify-between">
              <div className="space-y-1">
                <CardTitle className="text-lg">
                  Week of {format(new Date(submission.weekOf), "MMMM d, yyyy")}
                </CardTitle>
                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                  <StatusBadge status={submission.status} />
                  <span>Submitted {format(new Date(submission.createdAt), "MMM d, yyyy 'at' h:mm a")}</span>
                </div>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-6">
            <div>
              <h3 className="text-sm font-medium text-muted-foreground mb-2">Raw Text</h3>
              <div className="bg-slate-50 p-4 rounded-md">
                <p className="whitespace-pre-wrap text-sm">{submission.rawText}</p>
              </div>
            </div>

            {submission.terseVersion && (
              <div>
                <h3 className="text-sm font-medium text-muted-foreground mb-2">
                  Terse Version
                  {submission.isAiGenerated && (
                    <span className="ml-2 text-xs text-blue-600">(AI-generated)</span>
                  )}
                </h3>
                <div className="bg-slate-50 p-4 rounded-md">
                  <p className="whitespace-pre-wrap text-sm">{submission.terseVersion}</p>
                </div>
              </div>
            )}

            {submission.reviews && submission.reviews.length > 0 && (
              <div>
                <h3 className="text-sm font-medium text-muted-foreground mb-2">Review History</h3>
                <div className="space-y-2">
                  {submission.reviews.map((review) => (
                    <div key={review.id} className="bg-slate-50 p-3 rounded-md">
                      <div className="flex items-center gap-2 mb-1">
                        <StatusBadge status={review.status as any} />
                        <span className="text-xs text-muted-foreground">
                          {format(new Date(review.createdAt), "MMM d, yyyy")}
                        </span>
                      </div>
                      {review.comment && (
                        <p className="text-sm text-slate-700">{review.comment}</p>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
