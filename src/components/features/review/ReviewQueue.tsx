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

  return (
    <div className="space-y-4">
      {submissions.map((submission) => {
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
    </div>
  );
}
