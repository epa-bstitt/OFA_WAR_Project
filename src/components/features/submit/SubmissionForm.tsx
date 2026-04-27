"use client";

import { useEffect, useMemo, useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { Form } from "@/components/ui/form";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Loader2, AlertCircle, PlayCircle, Sparkles } from "lucide-react";
import { submissionWithTerseSchema, SubmissionWithTerseInput } from "@/lib/validation/submission";
import { getBiWeekDate, getCurrentBiWeek } from "@/lib/date-utils";
import { submitWAR } from "@/app/actions/submissions";
import { convertToTerseAction } from "@/app/actions/ai-convert";
import { WeekSelector } from "./WeekSelector";
import { RawTextInput } from "./RawTextInput";
import { AIPreview } from "./AIPreview";
import { TerseResult, AIError } from "@/lib/ai/types";
import { GuidedTourOverlay, GuidedTourStep, HintTooltip } from "./FormGuidance";
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip";

interface ConversionState {
  status: "idle" | "converting" | "success" | "error";
  result?: TerseResult;
  error?: AIError;
  useManual: boolean;
  manualText: string;
};

interface AISettings {
  serviceUrl?: string;
  apiKey?: string;
  model?: string;
}

export function SubmissionForm() {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);
  const [showAIPreview, setShowAIPreview] = useState(false);
  const [isTourOpen, setIsTourOpen] = useState(false);
  const [tourAutoPlay, setTourAutoPlay] = useState(false);
  const [aiSettings, setAiSettings] = useState<AISettings>({});
  const [conversionState, setConversionState] = useState<ConversionState>({
    status: "idle",
    useManual: false,
    manualText: "",
  });

  // Load AI settings on mount
  useEffect(() => {
    async function loadSettings() {
      try {
        const response = await fetch("/api/settings/ai");
        if (response.ok) {
          const data = await response.json();
          if (data.settings) {
            setAiSettings({
              serviceUrl: data.settings.serviceUrl,
              apiKey: undefined, // Don't expose API key to client
              model: data.settings.model,
            });
          }
        }
      } catch (err) {
        console.error("Failed to load AI settings:", err);
      }
    }
    loadSettings();
  }, []);

  // Initialize form with current bi-weekly period as default
  const currentBiWeek = getCurrentBiWeek();
  const defaultPeriodDate = getBiWeekDate(currentBiWeek);

  const form = useForm<SubmissionWithTerseInput>({
    resolver: zodResolver(submissionWithTerseSchema),
    defaultValues: {
      weekOf: defaultPeriodDate,
      rawText: "",
      terseVersion: "",
      isAiGenerated: false,
    },
  });

  const rawText = form.watch("rawText");

  const tourSteps = useMemo<GuidedTourStep[]>(() => {
    const aiStepSelector = showAIPreview ? "[data-tour='war-ai-preview']" : "[data-tour='war-ai-action']";

    return [
      {
        id: "period",
        selector: "[data-tour='war-period']",
        title: "Start with the reporting period",
        description:
          "Confirm the current bi-weekly period first. The form defaults to the active period so most users can keep moving without changing anything.",
      },
      {
        id: "details",
        selector: "[data-tour='war-raw-text']",
        title: "Paste your full working notes",
        description:
          "Drop in the detailed update you already have. Bullets and short sections are easiest to review, and the character counter shows when you have enough detail for the AI preview.",
      },
      {
        id: "ai",
        selector: aiStepSelector,
        title: showAIPreview ? "Review or refine the terse version" : "Preview the AI conversion",
        description: showAIPreview
          ? "Once the preview appears, scan the AI-converted version, edit anything that needs nuance, or switch to manual entry before submitting."
          : "Use this button to generate a leadership-ready terse version from your detailed notes. You still get a chance to review and edit it before the final submission.",
      },
      {
        id: "submit",
        selector: "[data-tour='war-submit-actions']",
        title: "Submit once the short version looks right",
        description:
          "After you verify the concise version, submit the form. The Cancel action stays beside it so you can back out without losing context if you need to return to the dashboard.",
      },
    ];
  }, [showAIPreview]);

  async function handleConvert() {
    if (!rawText || rawText.length < 10) {
      setSubmitError("Please enter at least 10 characters before converting.");
      return;
    }

    setConversionState({ status: "converting", useManual: false, manualText: "" });
    setShowAIPreview(true);

    try {
      const result = await convertToTerseAction(rawText, aiSettings);

      if (result.success) {
        setConversionState({
          status: "success",
          result: result.result,
          useManual: false,
          manualText: "",
        });
        form.setValue("terseVersion", result.result.terseText);
        form.setValue("isAiGenerated", true);
      } else {
        setConversionState({
          status: "error",
          error: result.error,
          useManual: false,
          manualText: "",
        });
        if (!result.fallback) {
          setSubmitError(result.error.message);
        }
      }
    } catch {
      setConversionState({
        status: "error",
        error: {
          code: "UNKNOWN_ERROR",
          message: "Failed to convert text. Please try again.",
          retryable: true,
        },
        useManual: false,
        manualText: "",
      });
    }
  }

  function openWalkthrough(autoPlay = false) {
    setTourAutoPlay(autoPlay);
    setIsTourOpen(true);
  }

  function closeWalkthrough() {
    setIsTourOpen(false);
    setTourAutoPlay(false);
  }

  function handleEditTerse(text: string) {
    if (conversionState.useManual) {
      setConversionState((prev) => ({ ...prev, manualText: text }));
      form.setValue("terseVersion", text);
      form.setValue("isAiGenerated", false);
    } else {
      setConversionState((prev) => ({
        ...prev,
        result: prev.result ? { ...prev.result, terseText: text } : undefined,
      }));
      form.setValue("terseVersion", text);
      form.setValue("isAiGenerated", true);
    }
  }

  function handleUseManual() {
    setConversionState((prev) => ({
      ...prev,
      useManual: true,
      manualText: prev.result?.terseText || "",
    }));
    form.setValue("isAiGenerated", false);
  }

  function handleRegenerate() {
    handleConvert();
  }

  async function onSubmit(data: SubmissionWithTerseInput) {
    setIsSubmitting(true);
    setSubmitError(null);

    try {
      const submitData = {
        weekOf: data.weekOf,
        rawText: data.rawText,
        terseVersion: conversionState.useManual
          ? conversionState.manualText
          : conversionState.result?.terseText,
        isAiGenerated: data.isAiGenerated,
      };

      const result = await submitWAR(submitData);

      if (result.success) {
        router.push("/submit/success");
      } else {
        setSubmitError(result.error || "Failed to submit BAR");
      }
    } catch {
      setSubmitError("An unexpected error occurred. Please try again.");
    } finally {
      setIsSubmitting(false);
    }
  }

  useEffect(() => {
    const timeoutId = window.setTimeout(() => {
      openWalkthrough(false);
    }, 450);

    return () => window.clearTimeout(timeoutId);
  }, []);

  return (
    <TooltipProvider>
      <>
        <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <CardTitle>Submit Bi-Weekly Activity Report</CardTitle>
            <CardDescription>
              Enter your bi-weekly status update below. Be concise but thorough.
            </CardDescription>
          </div>
          <div className="flex items-center gap-2">
            <Button type="button" variant="outline" size="sm" onClick={() => openWalkthrough(false)}>
              Show walkthrough
            </Button>
            <Button type="button" variant="secondary" size="sm" onClick={() => openWalkthrough(true)}>
              <PlayCircle className="mr-2 h-4 w-4" />
              Auto demo
            </Button>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        {submitError && (
          <Alert variant="destructive" className="mb-6">
            <AlertCircle className="h-4 w-4" />
            <AlertTitle>Error</AlertTitle>
            <AlertDescription>{submitError}</AlertDescription>
          </Alert>
        )}

        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
            <WeekSelector form={form} name="weekOf" />

            <RawTextInput form={form} name="rawText" />

            {!showAIPreview && (
              <div data-tour="war-ai-action">
                <div className="flex items-center gap-2">
                  <Tooltip>
                    <TooltipTrigger asChild>
                      <div className="flex-1">
                        <Button
                          type="button"
                          variant="outline"
                          onClick={handleConvert}
                          disabled={!rawText || rawText.length < 10}
                          className="w-full"
                        >
                          <Sparkles className="mr-2 h-4 w-4" />
                          Preview AI Conversion
                        </Button>
                      </div>
                    </TooltipTrigger>
                    <TooltipContent side="top" className="max-w-sm text-left text-sm leading-5">
                      Generate a concise draft from your detailed notes, then review or edit it before final submission.
                    </TooltipContent>
                  </Tooltip>
                  <HintTooltip content="Hover here any time you need a reminder: this step creates the shorter leadership-ready version from your full write-up, and you can still edit it before submitting." />
                </div>
              </div>
            )}

            {showAIPreview && (
              <div data-tour="war-ai-preview">
                <AIPreview
                  rawText={rawText}
                  conversionResult={conversionState.result || null}
                  isConverting={conversionState.status === "converting"}
                  error={conversionState.error || null}
                  onEdit={handleEditTerse}
                  onRegenerate={handleRegenerate}
                  onUseManual={handleUseManual}
                  manualText={conversionState.manualText}
                  isUsingManual={conversionState.useManual}
                />
              </div>
            )}

            <div data-tour="war-submit-actions" className="flex gap-3 pt-4">
              <Tooltip>
                <TooltipTrigger asChild>
                  <Button
                    type="submit"
                    disabled={isSubmitting || conversionState.status === "converting"}
                    className="flex-1"
                    size="lg"
                  >
                    {isSubmitting ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Submitting...
                      </>
                    ) : (
                      "Submit"
                    )}
                  </Button>
                </TooltipTrigger>
                <TooltipContent side="top" className="max-w-xs text-left text-sm leading-5">
                  Submit after you confirm the terse version reflects your update accurately.
                </TooltipContent>
              </Tooltip>
              <Button
                type="button"
                variant="outline"
                onClick={() => router.push("/dashboard")}
                disabled={isSubmitting}
              >
                Cancel
              </Button>
            </div>
          </form>
        </Form>
      </CardContent>
        </Card>

        <GuidedTourOverlay
          steps={tourSteps}
          open={isTourOpen}
          onClose={closeWalkthrough}
          autoPlay={tourAutoPlay}
        />
      </>
    </TooltipProvider>
  );
}
