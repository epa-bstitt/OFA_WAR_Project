"use client";

import Link from "next/link";
import { format } from "date-fns";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { StatusBadge } from "./StatusBadge";
import { MoreHorizontal, Edit, Trash2, Eye } from "lucide-react";
import type { SubmissionWithReviews } from "@/app/actions/submissions";

interface SubmissionCardProps {
  submission: SubmissionWithReviews;
  onDelete?: (id: string) => void;
}

export function SubmissionCard({ submission, onDelete }: SubmissionCardProps) {
  const canEdit = submission.status === "SUBMITTED";
  const canDelete = submission.status === "SUBMITTED" || submission.status === "REJECTED";

  return (
    <Card className="hover:shadow-md transition-shadow">
      <CardHeader className="pb-3">
        <div className="flex items-start justify-between">
          <div className="space-y-1">
            <div className="flex items-center gap-2">
              <StatusBadge status={submission.status} />
              <span className="text-sm text-muted-foreground">
                Week of {format(new Date(submission.weekOf), "MMM d, yyyy")}
              </span>
            </div>
            <p className="text-sm text-muted-foreground">
              Submitted {format(new Date(submission.createdAt), "MMM d, yyyy 'at' h:mm a")}
            </p>
          </div>
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="ghost" size="icon">
                <MoreHorizontal className="h-4 w-4" />
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end">
              <DropdownMenuItem asChild>
                <Link href={`/submissions/${submission.id}`}>
                  <Eye className="mr-2 h-4 w-4" />
                  View Details
                </Link>
              </DropdownMenuItem>
              {canEdit && (
                <DropdownMenuItem asChild>
                  <Link href={`/submissions/${submission.id}/edit`}>
                    <Edit className="mr-2 h-4 w-4" />
                    Edit
                  </Link>
                </DropdownMenuItem>
              )}
              {canDelete && (
                <DropdownMenuItem
                  className="text-red-600 focus:text-red-600"
                  onClick={() => onDelete?.(submission.id)}
                >
                  <Trash2 className="mr-2 h-4 w-4" />
                  Delete
                </DropdownMenuItem>
              )}
            </DropdownMenuContent>
          </DropdownMenu>
        </div>
      </CardHeader>
      <CardContent>
        <p className="text-sm line-clamp-3 text-slate-700">
          {submission.rawText}
        </p>
        {submission.isAiGenerated && (
          <p className="text-xs text-muted-foreground mt-2">
            AI-generated terse version included
          </p>
        )}
      </CardContent>
    </Card>
  );
}
