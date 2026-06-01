"use client";

import { useMemo, useState } from "react";
import { History } from "lucide-react";
import type { ReactNode } from "react";
import { Card, CardContent } from "@/components/ui/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { ReviewStats } from "@/components/features/review/ReviewStats";
import { OverseerReviewDeck, type OverseerSubmission } from "@/components/features/review/OverseerReviewDeck";

export type BiWeeklySubmissionHistoryPeriod = {
  periodId: string;
  label: string;
  deadline: Date;
  submissions: OverseerSubmission[];
};

type BiWeeklySubmissionHistoryProps = {
  periods: BiWeeklySubmissionHistoryPeriod[];
  currentUserId: string;
  actionSlot?: ReactNode;
};

export function BiWeeklySubmissionHistory({ periods, currentUserId, actionSlot }: BiWeeklySubmissionHistoryProps) {
  const [selectedPeriodId, setSelectedPeriodId] = useState(periods[0]?.periodId || "");

  const selectedPeriod = useMemo(
    () => periods.find((period) => period.periodId === selectedPeriodId) || periods[0],
    [periods, selectedPeriodId]
  );

  if (!selectedPeriod) {
    return null;
  }

  const pendingSubmissions = selectedPeriod.submissions.filter(
    (submission) =>
      submission.status === "SUBMITTED" && submission.reviews?.[0]?.status !== "CHANGES_REQUESTED"
  );
  const updatedSubmissions = selectedPeriod.submissions.filter(
    (submission) =>
      submission.status === "SUBMITTED" && submission.reviews?.[0]?.status === "CHANGES_REQUESTED"
  );
  const approvedSubmissions = selectedPeriod.submissions.filter(
    (submission) => submission.status === "APPROVED" || submission.status === "PUBLISHED"
  );

  return (
    <section className="space-y-4">
      <div className="flex flex-wrap items-center justify-end gap-3">
        {actionSlot}
        <Card className="w-full max-w-md border-slate-200 shadow-sm">
          <CardContent className="flex items-center gap-3 p-3">
            <div className="flex min-w-0 items-center gap-2">
              <History className="h-4 w-4 shrink-0 text-slate-500" />
              <div className="min-w-0">
                <p className="text-[11px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                  Submission History
                </p>
                <p className="truncate text-sm font-medium text-slate-900">Bi-weekly log</p>
              </div>
            </div>

            <div className="ml-auto w-56 shrink-0">
              <Select value={selectedPeriod.periodId} onValueChange={setSelectedPeriodId}>
                <SelectTrigger className="h-9 text-xs">
                  <SelectValue placeholder="Select bi-week period" />
                </SelectTrigger>
                <SelectContent>
                  {periods.map((period) => (
                    <SelectItem key={period.periodId} value={period.periodId}>
                      {period.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </CardContent>
        </Card>
      </div>

      <ReviewStats
        pending={pendingSubmissions.length}
        updated={updatedSubmissions.length}
        approved={approvedSubmissions.length}
        compact
        pendingModalTitle={`${selectedPeriod.label} - Pending Review`}
        pendingModalDescription="Open the pending submissions for this bi-weekly period."
        pendingModalContent={
          <OverseerReviewDeck submissions={pendingSubmissions} currentUserId={currentUserId} />
        }
        updatedModalTitle={`${selectedPeriod.label} - Updated`}
        updatedModalDescription="Review submitted updates that were returned with comments."
        updatedModalContent={
          <OverseerReviewDeck submissions={updatedSubmissions} currentUserId={currentUserId} />
        }
        approvedModalTitle={`${selectedPeriod.label} - Approved`}
        approvedModalDescription="Browse approved submissions for this bi-weekly period."
        approvedModalContent={
          <OverseerReviewDeck
            submissions={approvedSubmissions}
            currentUserId={currentUserId}
            reviewMode="readonly"
          />
        }
      />
    </section>
  );
}
