"use client";

import { useEffect, useMemo, useState } from "react";
import { createPortal } from "react-dom";
import { ChevronLeft, ChevronRight, X } from "lucide-react";
import { Button } from "@/components/ui/button";

export interface CardWalkthroughStep {
  id: string;
  selector: string;
  title: string;
  description: string;
}

interface CardWalkthroughProps {
  steps: CardWalkthroughStep[];
  open: boolean;
  onClose: (rememberDismissal: boolean) => void;
}

interface HighlightRect {
  top: number;
  left: number;
  width: number;
  height: number;
}

export function CardWalkthrough({ steps, open, onClose }: CardWalkthroughProps) {
  const [mounted, setMounted] = useState(false);
  const [currentStepIndex, setCurrentStepIndex] = useState(0);
  const [rememberDismissal, setRememberDismissal] = useState(false);
  const [highlightRect, setHighlightRect] = useState<HighlightRect | null>(null);

  const currentStep = steps[currentStepIndex];

  useEffect(() => {
    setMounted(true);
  }, []);

  useEffect(() => {
    if (!open) {
      setCurrentStepIndex(0);
      setRememberDismissal(false);
      setHighlightRect(null);
      return;
    }

    setCurrentStepIndex(0);
  }, [open]);

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

  const bubbleStyle = useMemo(() => {
    if (typeof window === "undefined") {
      return { top: 24, left: 24, width: 380 };
    }

    const bubbleWidth = Math.min(420, window.innerWidth - 32);

    if (!highlightRect) {
      return {
        top: Math.max(24, window.innerHeight / 2 - 140),
        left: Math.max(16, window.innerWidth / 2 - bubbleWidth / 2),
        width: bubbleWidth,
      };
    }

    let top = highlightRect.top + highlightRect.height + 18;
    let left = highlightRect.left;

    if (left + bubbleWidth > window.innerWidth - 16) {
      left = window.innerWidth - bubbleWidth - 16;
    }

    if (top + 240 > window.innerHeight - 16) {
      top = Math.max(16, highlightRect.top - 256);
    }

    return {
      top,
      left: Math.max(16, left),
      width: bubbleWidth,
    };
  }, [highlightRect]);

  if (!mounted || !open || !currentStep || steps.length === 0) {
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
              Card walkthrough
            </p>
            <h3 className="mt-1 text-lg font-semibold text-slate-900">{currentStep.title}</h3>
          </div>
          <button
            type="button"
            onClick={() => onClose(rememberDismissal)}
            className="rounded-full p-1 text-slate-500 transition hover:bg-slate-100 hover:text-slate-900"
            aria-label="Close walkthrough"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        <p className="text-sm leading-6 text-slate-600">{currentStep.description}</p>

        <div className="mt-4 space-y-3">
          <label className="flex items-center gap-2 text-sm text-slate-600">
            <input
              type="checkbox"
              checked={rememberDismissal}
              onChange={(event) => setRememberDismissal(event.target.checked)}
              className="h-4 w-4 rounded border-slate-300 text-sky-600 focus:ring-sky-500"
            />
            Don&apos;t show this walkthrough again
          </label>

          <div className="flex items-center justify-between gap-3">
            <span className="text-xs font-medium text-slate-500">
              Step {currentStepIndex + 1} of {steps.length}
            </span>
            <div className="flex items-center gap-2">
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
                <Button type="button" size="sm" onClick={() => onClose(rememberDismissal)}>
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
      </div>
    </div>,
    document.body
  );
}