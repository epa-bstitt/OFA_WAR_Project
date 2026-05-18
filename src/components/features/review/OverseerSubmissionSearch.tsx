"use client";

import { useMemo, useState } from "react";
import { Search, UserRound, Briefcase } from "lucide-react";
import { Input } from "@/components/ui/input";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { OverseerReviewDeck, type OverseerSubmission } from "@/components/features/review/OverseerReviewDeck";

type OverseerSubmissionSearchProps = {
  submissions: OverseerSubmission[];
  currentUserId: string;
};

function buildSearchText(submission: OverseerSubmission): string {
  return [
    submission.contractName,
    submission.assigneeLabel,
    submission.user.name || "",
    submission.user.email || "",
    submission.contractDetails.contractNumber,
    submission.contractDetails.office,
    submission.contractDetails.cor,
  ]
    .join(" ")
    .toLowerCase();
}

export function OverseerSubmissionSearch({
  submissions,
  currentUserId,
}: OverseerSubmissionSearchProps) {
  const [query, setQuery] = useState("");
  const [selectedSubmission, setSelectedSubmission] = useState<OverseerSubmission | null>(null);
  const normalizedQuery = query.trim().toLowerCase();

  const matchingSubmissions = useMemo(() => {
    if (!normalizedQuery) {
      return [];
    }

    return submissions
      .filter((submission) => buildSearchText(submission).includes(normalizedQuery))
      .slice(0, 8);
  }, [normalizedQuery, submissions]);

  return (
    <>
      <section className="rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
        <div className="mb-3 flex items-center gap-2">
          <Search className="h-4 w-4 text-slate-500" />
          <h2 className="text-sm font-semibold text-slate-900">Search Contract or Person</h2>
        </div>

        <div className="relative">
          <Input
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder="Type a contract name, person name, or email"
            aria-label="Search contracts or people"
          />
        </div>

        {normalizedQuery ? (
          <div className="mt-3 max-h-72 overflow-auto rounded-lg border border-slate-200">
            {matchingSubmissions.length > 0 ? (
              <ul className="divide-y divide-slate-100">
                {matchingSubmissions.map((submission) => (
                  <li key={submission.id}>
                    <button
                      type="button"
                      onClick={() => setSelectedSubmission(submission)}
                      className="w-full px-3 py-2 text-left transition hover:bg-slate-50"
                    >
                      <div className="flex flex-wrap items-center gap-3">
                        <span className="inline-flex items-center gap-1 text-xs text-slate-600">
                          <Briefcase className="h-3.5 w-3.5" />
                          {submission.contractName}
                        </span>
                        <span className="inline-flex items-center gap-1 text-xs text-slate-600">
                          <UserRound className="h-3.5 w-3.5" />
                          {submission.user.name || submission.user.email || "Unknown Contributor"}
                        </span>
                      </div>
                      <p className="mt-1 text-xs text-slate-500">
                        {submission.contractDetails.contractNumber || "No Contract Number"} | {submission.contractDetails.office || "No Office"}
                      </p>
                    </button>
                  </li>
                ))}
              </ul>
            ) : (
              <p className="px-3 py-4 text-sm text-slate-500">No matching contracts or people found.</p>
            )}
          </div>
        ) : null}
      </section>

      <Dialog
        open={Boolean(selectedSubmission)}
        onOpenChange={(open) => {
          if (!open) {
            setSelectedSubmission(null);
          }
        }}
      >
        <DialogContent className="max-w-5xl">
          <DialogHeader>
            <DialogTitle>Submission Card Preview</DialogTitle>
            <DialogDescription>
              Review this selected contract/person entry in the same card format.
            </DialogDescription>
          </DialogHeader>

          <div className="max-h-[72vh] overflow-auto pr-1">
            {selectedSubmission ? (
              <OverseerReviewDeck
                submissions={[selectedSubmission]}
                currentUserId={currentUserId}
                reviewMode="readonly"
              />
            ) : null}
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
