"use client";

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CardGrid } from "@/components/shared/CardGrid";
import { SubmissionCard } from "@/components/features/submissions/SubmissionCard";
import type { SubmissionWithReviews } from "@/app/actions/submissions";

interface SubmissionsTabsProps {
  submissions: SubmissionWithReviews[];
}

export function SubmissionsTabs({ submissions }: SubmissionsTabsProps) {
  const infoNeededSubmissions = submissions.filter(
    (submission) => submission.status === "INFO_NEEDED"
  );

  return (
    <Tabs defaultValue="all" className="space-y-4">
      <TabsList>
        <TabsTrigger value="all">All ({submissions.length})</TabsTrigger>
        <TabsTrigger value="info-needed">Info Needed ({infoNeededSubmissions.length})</TabsTrigger>
      </TabsList>

      <TabsContent value="all">
        <CardGrid columns={2}>
          {submissions.map((submission) => (
            <SubmissionCard key={submission.id} submission={submission} />
          ))}
        </CardGrid>
      </TabsContent>

      <TabsContent value="info-needed">
        {infoNeededSubmissions.length === 0 ? (
          <div className="rounded-md border border-slate-200 bg-slate-50 px-4 py-6 text-sm text-slate-600">
            No submissions are currently marked as Info Needed.
          </div>
        ) : (
          <CardGrid columns={2}>
            {infoNeededSubmissions.map((submission) => (
              <SubmissionCard key={submission.id} submission={submission} />
            ))}
          </CardGrid>
        )}
      </TabsContent>
    </Tabs>
  );
}
