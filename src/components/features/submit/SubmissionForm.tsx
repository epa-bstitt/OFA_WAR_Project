"use client";

import { useState, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { Form } from "@/components/ui/form";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Loader2, AlertCircle, Sparkles } from "lucide-react";
import { submissionWithTerseSchema, SubmissionWithTerseInput } from "@/lib/validation/submission";
import { getBiWeekDate, getCurrentBiWeek } from "@/lib/date-utils";
import { submitWAR } from "@/app/actions/submissions";
import { convertToTerseAction } from "@/app/actions/ai-convert";
import { WeekSelector } from "./WeekSelector";
import { RawTextInput } from "./RawTextInput";
import { AIPreview } from "./AIPreview";
import { TerseResult, AIError } from "@/lib/ai/types";

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
    resolver: zodResolver(submissionWithTerseSchema as any),
    defaultValues: {
      weekOf: defaultPeriodDate,
      rawText: "",
      terseVersion: "",
      isAiGenerated: false,
    },
  });

  const rawText = form.watch("rawText");

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
    } catch (error) {
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
    } catch (error) {
      setSubmitError("An unexpected error occurred. Please try again.");
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <Card className="w-full max-w-2xl mx-auto">
      <CardHeader>
        <CardTitle>Submit Bi-Weekly Activity Report</CardTitle>
        <CardDescription>
          Enter your bi-weekly status update below. Be concise but thorough.
        </CardDescription>
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
            )}

            {showAIPreview && (
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
            )}

            <div className="flex gap-3 pt-4">
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
                  "Submit BAR"
                )}
              </Button>
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
  );
}
