"use client";

import { Badge } from "@/components/ui/badge";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import { cn } from "@/lib/utils";
import { Sparkles } from "lucide-react";

interface ConfidenceBadgeProps {
  confidence: number;
  processingTime?: number;
  className?: string;
}

export function ConfidenceBadge({
  confidence,
  processingTime,
  className,
}: ConfidenceBadgeProps) {
  // Convert to percentage
  const percentage = Math.round(confidence * 100);

  // Determine color based on confidence level
  let variant: "default" | "secondary" | "destructive" | "outline" = "default";
  let colorClass = "";

  if (percentage >= 80) {
    colorClass = "bg-green-100 text-green-800 hover:bg-green-100";
  } else if (percentage >= 60) {
    colorClass = "bg-yellow-100 text-yellow-800 hover:bg-yellow-100";
  } else {
    variant = "destructive";
    colorClass = "bg-red-100 text-red-800 hover:bg-red-100";
  }

  return (
    <TooltipProvider>
      <Tooltip>
        <TooltipTrigger asChild>
          <div className={cn("flex items-center gap-2", className)}>
            <Badge variant={variant} className={cn("font-medium", colorClass)}>
              <Sparkles className="w-3 h-3 mr-1" />
              {percentage}% confidence
            </Badge>
            {processingTime !== undefined && (
              <span className="text-xs text-muted-foreground">
                Converted in {(processingTime / 1000).toFixed(1)}s
              </span>
            )}
          </div>
        </TooltipTrigger>
        <TooltipContent side="bottom" className="max-w-xs">
          <p className="text-sm">
            Based on pattern matching and semantic analysis of the text.
            Higher confidence indicates better alignment with EPA terse format
            guidelines.
          </p>
          {percentage < 70 && (
            <p className="text-sm text-yellow-600 mt-1">
              Low confidence - please review carefully before submitting.
            </p>
          )}
        </TooltipContent>
      </Tooltip>
    </TooltipProvider>
  );
}
