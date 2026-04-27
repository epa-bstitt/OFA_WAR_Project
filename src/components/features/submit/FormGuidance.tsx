"use client";

import { useEffect, useMemo, useState } from "react";
import { createPortal } from "react-dom";
import { ChevronLeft, ChevronRight, HelpCircle, PauseCircle, PlayCircle, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip";
import { cn } from "@/lib/utils";

export interface GuidedTourStep {
  id: string;
  selector: string;
  title: string;
  description: string;
}

interface HintTooltipProps {
  content: string;
  className?: string;
}

interface GuidedTourOverlayProps {
  steps: GuidedTourStep[];
  open: boolean;
  onClose: () => void;
  autoPlay?: boolean;
}

interface HighlightRect {
  top: number;
  left: number;
  width: number;
  height: number;
}

export function HintTooltip({ content, className }: HintTooltipProps) {
  return (
    <TooltipProvider delayDuration={120}>
      <Tooltip>
        <TooltipTrigger asChild>
          <button
            type="button"
            aria-label="Show field guidance"
            className={cn(
              "inline-flex h-5 w-5 items-center justify-center rounded-full text-muted-foreground transition hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
              className
            )}
          >
            <HelpCircle className="h-4 w-4" />
          </button>
        </TooltipTrigger>
        <TooltipContent side="top" className="max-w-xs text-left text-sm leading-5">
          {content}
        </TooltipContent>
      </Tooltip>
    </TooltipProvider>
  );
}

export function GuidedTourOverlay({
  steps,
  open,
  onClose,
  autoPlay = false,
}: GuidedTourOverlayProps) {
  const [mounted, setMounted] = useState(false);
  const [currentStepIndex, setCurrentStepIndex] = useState(0);
  const [isAutoPlaying, setIsAutoPlaying] = useState(autoPlay);
  const [highlightRect, setHighlightRect] = useState<HighlightRect | null>(null);

  const currentStep = steps[currentStepIndex];

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!open) {
      setCurrentStepIndex(0);
      setIsAutoPlaying(false);
      setHighlightRect(null);
      return;
    }

    setCurrentStepIndex(0);
    setIsAutoPlaying(autoPlay);
  }, [autoPlay, open]);

  useEffect(() => {
    if (!open || !currentStep) {
      return;
    }

    const target = document.querySelector(currentStep.selector);

    if (target instanceof HTMLElement) {
      target.scrollIntoView({ block: "center", behavior: "smooth" });
    }
  }, [currentStep, open]);

  useEffect(() => {
    if (!open || !currentStep) {
      return;
    }

    const updateRect = () => {
      const target = document.querySelector(currentStep.selector);

      if (!(target instanceof HTMLElement)) {
        setHighlightRect(null);
        return;
      }

      const rect = target.getBoundingClientRect();
      const padding = 10;

      setHighlightRect({
        top: Math.max(12, rect.top - padding),
        left: Math.max(12, rect.left - padding),
        width: rect.width + padding * 2,
        height: rect.height + padding * 2,
      });
    };

    updateRect();

    window.addEventListener("resize", updateRect);
    window.addEventListener("scroll", updateRect, true);

    return () => {
      window.removeEventListener("resize", updateRect);
      window.removeEventListener("scroll", updateRect, true);
    };
  }, [currentStep, open]);

  useEffect(() => {
    if (!open || !isAutoPlaying || steps.length <= 1) {
      return;
    }

    const timeoutId = window.setTimeout(() => {
      setCurrentStepIndex((prev) => {
        if (prev >= steps.length - 1) {
          setIsAutoPlaying(false);
          return prev;
        }

        return prev + 1;
      });
    }, 2800);

    return () => window.clearTimeout(timeoutId);
  }, [currentStepIndex, isAutoPlaying, open, steps.length]);

  const bubbleStyle = useMemo(() => {
    if (typeof window === "undefined") {
      return { top: 24, left: 24, width: 360 };
    }

    const bubbleWidth = Math.min(360, window.innerWidth - 32);

    if (!highlightRect) {
      return {
        top: Math.max(24, window.innerHeight / 2 - 120),
        left: Math.max(16, window.innerWidth / 2 - bubbleWidth / 2),
        width: bubbleWidth,
      };
    }

    let top = highlightRect.top + highlightRect.height + 18;
    let left = highlightRect.left;

    if (left + bubbleWidth > window.innerWidth - 16) {
      left = window.innerWidth - bubbleWidth - 16;
    }

    if (top + 220 > window.innerHeight - 16) {
      top = Math.max(16, highlightRect.top - 236);
    }

    return {
      top,
      left: Math.max(16, left),
      width: bubbleWidth,
    };
  }, [highlightRect]);

  if (!mounted || !open || !currentStep) {
    return null;
  }

  return createPortal(
    <div className="fixed inset-0 z-[90]">
      <div className="absolute inset-0 bg-slate-950/55 backdrop-blur-[1px]" />

      {highlightRect && (
        <div
          className="pointer-events-none absolute rounded-2xl border-2 border-sky-300 bg-white/5 shadow-[0_0_0_9999px_rgba(15,23,42,0.55)] transition-all duration-300"
          style={{
            top: highlightRect.top,
            left: highlightRect.left,
            width: highlightRect.width,
            height: highlightRect.height,
          }}
        />
      )}

      <div
        className="absolute rounded-2xl border border-slate-200 bg-white p-5 shadow-2xl"
        style={bubbleStyle}
      >
        <div className="mb-3 flex items-start justify-between gap-3">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.18em] text-sky-700">
              Quick form guide
            </p>
            <h3 className="mt-1 text-lg font-semibold text-slate-900">{currentStep.title}</h3>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full p-1 text-slate-500 transition hover:bg-slate-100 hover:text-slate-900"
            aria-label="Close walkthrough"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        <p className="text-sm leading-6 text-slate-600">{currentStep.description}</p>

        <div className="mt-4 flex items-center justify-between gap-3">
          <span className="text-xs font-medium text-slate-500">
            Step {currentStepIndex + 1} of {steps.length}
          </span>
          <div className="flex items-center gap-2">
            <Button
              type="button"
              variant="ghost"
              size="sm"
              onClick={() => setIsAutoPlaying((prev) => !prev)}
            >
              {isAutoPlaying ? (
                <>
                  <PauseCircle className="mr-2 h-4 w-4" />
                  Pause demo
                </>
              ) : (
                <>
                  <PlayCircle className="mr-2 h-4 w-4" />
                  Auto demo
                </>
              )}
            </Button>
            <Button
              type="button"
              variant="outline"
              size="sm"
              onClick={() => setCurrentStepIndex((prev) => Math.max(0, prev - 1))}
              disabled={currentStepIndex === 0}
            >
              <ChevronLeft className="mr-1 h-4 w-4" />
              Back
            </Button>
            {currentStepIndex === steps.length - 1 ? (
              <Button type="button" size="sm" onClick={onClose}>
                Finish
              </Button>
            ) : (
              <Button
                type="button"
                size="sm"
                onClick={() => setCurrentStepIndex((prev) => Math.min(steps.length - 1, prev + 1))}
              >
                Next
                <ChevronRight className="ml-1 h-4 w-4" />
              </Button>
            )}
          </div>
        </div>
      </div>
    </div>,
    document.body
  );
}