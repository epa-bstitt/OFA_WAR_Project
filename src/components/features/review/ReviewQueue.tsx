"use client";

import Link from "next/link";
import { format } from "date-fns";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { PriorityBadge, calculatePriority, getDaysSince } from "./PriorityBadge";
import { StatusBadge } from "@/components/features/submissions/StatusBadge";
import type { SubmissionWithUser } from "@/app/actions/review";
import { MoreHorizontal, Eye, CheckCircle, XCircle, MessageSquare, ChevronRight } from "lucide-react";

interface ReviewQueueProps {
  submissions: SubmissionWithUser[];
  onQuickAction?: (id: string, action: "approve" | "reject" | "request-changes") => void;
}

type ReviewLane = "new" | "in-review" | "ready" | "blocked";

interface LaneAssignment {
  lane: ReviewLane;
  reason: string;
}

const laneConfig: Record<
  ReviewLane,
  { title: string; description: string; badgeClassName: string }
> = {
  new: {
    title: "New",
    description: "Fresh submissions that were just added and should be acknowledged first.",
    badgeClassName: "bg-sky-100 text-sky-800 border-sky-200",
  },
  "in-review": {
    title: "In Review",
    description: "Submissions with enough detail to review, but still waiting on a reviewer pass.",
    badgeClassName: "bg-amber-100 text-amber-800 border-amber-200",
  },
  ready: {
    title: "Ready to Approve",
    description: "Submissions that already have supporting terse text or AI assistance and look closer to decision-ready.",
    badgeClassName: "bg-emerald-100 text-emerald-800 border-emerald-200",
  },
  blocked: {
    title: "Blocked",
    description: "Submissions that likely need more contributor detail or a follow-up before approval.",
    badgeClassName: "bg-rose-100 text-rose-800 border-rose-200",
  },
};

function getLatestReviewStatus(submission: SubmissionWithUser) {
  return submission.reviews?.[0]?.status?.toUpperCase() ?? "";
}

function assignLane(submission: SubmissionWithUser): LaneAssignment {
  const daysSince = getDaysSince(submission.createdAt);
  const latestReviewStatus = getLatestReviewStatus(submission);
  const rawTextLength = submission.rawText.trim().length;

  if (latestReviewStatus.includes("CHANGE") || latestReviewStatus.includes("REJECT")) {
    return {
      lane: "blocked",
      reason: "Latest review requested revisions.",
    };
  }

  if (rawTextLength < 80) {
    return {
      lane: "blocked",
      reason: "Update looks too short and may need more detail.",
    };
  }

  if (submission.terseVersion || submission.isAiGenerated) {
    return {
      lane: "ready",
      reason: submission.terseVersion
        ? "Includes a terse version for faster approval review."
        : "Marked as AI-assisted and ready for a decision pass.",
    };
  }

  if (daysSince <= 1) {
    return {
      lane: "new",
      reason: "Submitted within the last day.",
    };
  }

  return {
    lane: "in-review",
    reason: "Pending standard reviewer triage.",
  };
}

export function ReviewQueue({ submissions, onQuickAction }: ReviewQueueProps) {
  if (submissions.length === 0) {
    return (
      <Card>
        <CardContent className="py-12 text-center">
          <p className="text-muted-foreground">No pending submissions to review</p>
          <p className="text-sm text-muted-foreground mt-1">
            All caught up! Check back later for new submissions.
          </p>
        </CardContent>
      </Card>
    );
  }

  const groupedSubmissions = submissions.reduce(
    (accumulator, submission) => {
      const assignment = assignLane(submission);
      accumulator[assignment.lane].push({ submission, reason: assignment.reason });
      return accumulator;
    },
    {
      new: [] as Array<{ submission: SubmissionWithUser; reason: string }>,
      "in-review": [] as Array<{ submission: SubmissionWithUser; reason: string }>,
      ready: [] as Array<{ submission: SubmissionWithUser; reason: string }>,
      blocked: [] as Array<{ submission: SubmissionWithUser; reason: string }>,
    }
  );

  return (
    <div className="space-y-4">
      {(["new", "in-review", "ready", "blocked"] as ReviewLane[]).map((lane) => {
        const items = groupedSubmissions[lane];
        if (items.length === 0) {
          return null;
        }

        const config = laneConfig[lane];

        return (
          <section key={lane} className="space-y-3">
            <div className="rounded-xl border border-slate-200 bg-white px-4 py-3 shadow-sm">
              <div className="flex flex-wrap items-start justify-between gap-3">
                <div>
                  <div className="flex items-center gap-2">
                    <p className="text-sm font-semibold text-slate-900">{config.title}</p>
                    <Badge variant="outline" className={config.badgeClassName}>
                      {items.length}
                    </Badge>
                  </div>
                  <p className="mt-1 text-xs text-muted-foreground">{config.description}</p>
                </div>
              </div>
            </div>

            {items.map(({ submission, reason }) => {
              const priority = calculatePriority(submission.createdAt);
              const daysSince = getDaysSince(submission.createdAt);

              return (
                <Card key={submission.id} className="hover:shadow-md transition-shadow">
                  <CardHeader className="pb-3">
                    <div className="flex items-start justify-between">
                      <div className="space-y-1">
                        <div className="flex items-center gap-2 flex-wrap">
                          <PriorityBadge priority={priority} daysSince={daysSince} />
                          <StatusBadge status={submission.status} />
                          <Badge variant="outline" className={config.badgeClassName}>
                            {config.title}
                          </Badge>
                          <span className="text-sm text-muted-foreground">
                            Week of {format(new Date(submission.weekOf), "MMM d, yyyy")}
                          </span>
                        </div>
                        <p className="text-sm font-medium">
                          {submission.user.name || submission.user.email || "Unknown User"}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          Submitted {format(new Date(submission.createdAt), "MMM d, yyyy 'at' h:mm a")}
                        </p>
                      </div>
                      <div className="flex items-center gap-2">
                        {submission.isAiGenerated && (
                          <Badge variant="secondary" className="text-xs">
                            AI-assisted
                          </Badge>
                        )}
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="icon">
                              <MoreHorizontal className="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem asChild>
                              <Link href={`/review/${submission.id}`}>
                                <Eye className="mr-2 h-4 w-4" />
                                Review Details
                              </Link>
                            </DropdownMenuItem>
                            <DropdownMenuItem onClick={() => onQuickAction?.(submission.id, "approve")}>
                              <CheckCircle className="mr-2 h-4 w-4 text-green-600" />
                              Quick Approve
                            </DropdownMenuItem>
                            <DropdownMenuItem onClick={() => onQuickAction?.(submission.id, "request-changes")}>
                              <MessageSquare className="mr-2 h-4 w-4 text-yellow-600" />
                              Request Changes
                            </DropdownMenuItem>
                            <DropdownMenuItem onClick={() => onQuickAction?.(submission.id, "reject")}>
                              <XCircle className="mr-2 h-4 w-4 text-red-600" />
                              Reject
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent>
                    <div className="mb-3 rounded-md border border-dashed border-slate-200 bg-slate-50 px-3 py-2">
                      <p className="text-[11px] font-semibold uppercase tracking-[0.12em] text-slate-500">
                        Why this is here
                      </p>
                      <p className="mt-1 text-sm text-slate-700">{reason}</p>
                    </div>
                    <div className="bg-slate-50 p-3 rounded-md">
                      <p className="text-sm line-clamp-3">{submission.rawText}</p>
                    </div>
                    {submission.terseVersion && (
                      <div className="mt-3 bg-slate-50 p-3 rounded-md border-l-4 border-blue-400">
                        <p className="text-xs text-muted-foreground mb-1">Terse Version</p>
                        <p className="text-sm line-clamp-2">{submission.terseVersion}</p>
                      </div>
                    )}
                    <div className="mt-4 flex justify-end">
                      <Link href={`/review/${submission.id}`}>
                        <Button variant="outline" size="sm">
                          Review
                          <ChevronRight className="ml-1 h-4 w-4" />
                        </Button>
                      </Link>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </section>
        );
      })}
    </div>
  );
}
