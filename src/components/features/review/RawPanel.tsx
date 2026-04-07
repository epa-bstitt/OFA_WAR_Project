"use client";

import { useState } from "react";
import { format } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { PriorityBadge, calculatePriority, getDaysSince } from "./PriorityBadge";
import { StatusBadge } from "@/components/features/submissions/StatusBadge";
import { ConfidenceBadge } from "@/components/features/submit/ConfidenceBadge";
import type { SubmissionWithUser } from "@/app/actions/review";
import { ChevronDown, ChevronUp } from "lucide-react";

interface RawPanelProps {
  submission: SubmissionWithUser;
}

export function RawPanel({ submission }: RawPanelProps) {
  const [isExpanded, setIsExpanded] = useState(false);
  const priority = calculatePriority(submission.createdAt);
  const daysSince = getDaysSince(submission.createdAt);
  
  // Show first 500 chars if not expanded
  const shouldTruncate = submission.rawText.length > 500;
  const displayText = isExpanded || !shouldTruncate 
    ? submission.rawText 
    : submission.rawText.slice(0, 500) + "...";

  return (
    <Card className="h-full flex flex-col">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="space-y-1">
            <CardTitle className="text-base">Raw Text</CardTitle>
            <div className="flex items-center gap-2 text-sm">
              <PriorityBadge priority={priority} daysSince={daysSince} />
              <StatusBadge status={submission.status} />
            </div>
          </div>
          {submission.isAiGenerated && submission.aiConfidence !== undefined && submission.aiConfidence !== null && (
            <ConfidenceBadge 
              confidence={submission.aiConfidence} 
            />
          )}
        </div>
        <div className="text-sm text-muted-foreground pt-2">
          <p className="font-medium">{submission.user.name || submission.user.email || "Unknown User"}</p>
          <p className="text-xs">
            Week of {format(new Date(submission.weekOf), "MMMM d, yyyy")} • {" "}
            Submitted {format(new Date(submission.createdAt), "MMM d, yyyy 'at' h:mm a")}
          </p>
        </div>
      </CardHeader>
      <CardContent className="flex-1 flex flex-col">
        <div className="bg-slate-50 p-4 rounded-md flex-1 overflow-auto">
          <p className="whitespace-pre-wrap text-sm leading-relaxed">{displayText}</p>
        </div>
        {shouldTruncate && (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => setIsExpanded(!isExpanded)}
            className="mt-2 self-center"
          >
            {isExpanded ? (
              <>
                <ChevronUp className="h-4 w-4 mr-1" />
                Show Less
              </>
            ) : (
              <>
                <ChevronDown className="h-4 w-4 mr-1" />
                Show Full Text
              </>
            )}
          </Button>
        )}
      </CardContent>
    </Card>
  );
}
