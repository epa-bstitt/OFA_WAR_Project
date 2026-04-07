"use client";

import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";
import { AlertCircle } from "lucide-react";

type Priority = "urgent" | "high" | "normal";

interface PriorityBadgeProps {
  priority: Priority;
  daysSince?: number;
  className?: string;
}

const priorityConfig: Record<Priority, { label: string; color: string; icon?: boolean }> = {
  urgent: {
    label: "Urgent",
    color: "bg-red-100 text-red-800 border-red-200",
    icon: true,
  },
  high: {
    label: "High",
    color: "bg-orange-100 text-orange-800 border-orange-200",
  },
  normal: {
    label: "Normal",
    color: "bg-green-100 text-green-800 border-green-200",
  },
};

export function PriorityBadge({ priority, daysSince, className }: PriorityBadgeProps) {
  const config = priorityConfig[priority];

  return (
    <Badge
      variant="outline"
      className={cn("font-medium", config.color, className)}
    >
      {config.icon && <AlertCircle className="w-3 h-3 mr-1" />}
      {config.label}
      {daysSince !== undefined && (
        <span className="ml-1 text-xs opacity-75">({daysSince}d)</span>
      )}
    </Badge>
  );
}

/**
 * Calculate priority based on submission age
 */
export function calculatePriority(createdAt: Date): Priority {
  const now = new Date();
  const daysSinceSubmission = Math.floor(
    (now.getTime() - createdAt.getTime()) / (1000 * 60 * 60 * 24)
  );

  if (daysSinceSubmission > 14) return "urgent";
  if (daysSinceSubmission > 7) return "high";
  return "normal";
}

/**
 * Get days since submission
 */
export function getDaysSince(createdAt: Date): number {
  const now = new Date();
  return Math.floor((now.getTime() - createdAt.getTime()) / (1000 * 60 * 60 * 24));
}
