"use client";

import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

type SubmissionStatus = "SUBMITTED" | "IN_REVIEW" | "APPROVED" | "REJECTED" | "PUBLISHED";

interface StatusBadgeProps {
  status: SubmissionStatus;
  className?: string;
}

const statusConfig: Record<SubmissionStatus, { label: string; color: string }> = {
  SUBMITTED: {
    label: "Submitted",
    color: "bg-blue-100 text-blue-800",
  },
  IN_REVIEW: {
    label: "In Review",
    color: "bg-yellow-100 text-yellow-800",
  },
  APPROVED: {
    label: "Approved",
    color: "bg-green-100 text-green-800",
  },
  REJECTED: {
    label: "Rejected",
    color: "bg-red-100 text-red-800",
  },
  PUBLISHED: {
    label: "Published",
    color: "bg-purple-100 text-purple-800",
  },
};

export function StatusBadge({ status, className }: StatusBadgeProps) {
  const config = statusConfig[status] || statusConfig.SUBMITTED;

  return (
    <Badge className={cn(config.color, "font-medium", className)}>
      {config.label}
    </Badge>
  );
}
