"use client";

import { useState } from "react";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Loader2, Edit2, Check, AlertTriangle, RefreshCw } from "lucide-react";
import { cn } from "@/lib/utils";
import { ConfidenceBadge } from "./ConfidenceBadge";
import { TerseResult, AIError } from "@/lib/ai/types";

interface AIPreviewProps {
  rawText: string;
  conversionResult: TerseResult | null;
  isConverting: boolean;
  error: AIError | null;
  onEdit: (text: string) => void;
  onRegenerate: () => void;
  onUseManual: () => void;
  manualText: string;
  isUsingManual: boolean;
}

export function AIPreview({
  rawText,
  conversionResult,
  isConverting,
  error,
  onEdit,
  onRegenerate,
  onUseManual,
  manualText,
  isUsingManual,
}: AIPreviewProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [editedText, setEditedText] = useState(conversionResult?.terseText || "");

  // Handle save edit
  const handleSaveEdit = () => {
    onEdit(editedText);
    setIsEditing(false);
  };

  // Show fallback UI if there's an error with fallback option
  if (error?.code === "SERVICE_UNAVAILABLE" || error?.code === "TIMEOUT") {
    return (
      <Alert className="mb-4 border-yellow-500 bg-yellow-50">
        <AlertTriangle className="h-4 w-4 text-yellow-600" />
        <AlertTitle className="text-yellow-800">AI conversion temporarily unavailable</AlertTitle>
        <AlertDescription className="space-y-3">
          <p>
            {error.message || "The AI service is not available right now. You can enter the terse version manually or try again."}
          </p>
          <div className="flex gap-2">
            <Button variant="outline" size="sm" onClick={onRegenerate}>
              <RefreshCw className="mr-2 h-4 w-4" />
              Try Again
            </Button>
            <Button variant="secondary" size="sm" onClick={onUseManual}>
              Enter Manually
            </Button>
          </div>
        </AlertDescription>
      </Alert>
    );
  }

  // Show error if conversion failed without fallback
  if (error && !conversionResult) {
    return (
      <Alert variant="destructive" className="mb-4">
        <AlertTriangle className="h-4 w-4" />
        <AlertTitle>Conversion failed</AlertTitle>
        <AlertDescription className="space-y-3">
          <p>{error.message}</p>
          <Button variant="outline" size="sm" onClick={onRegenerate}>
            <RefreshCw className="mr-2 h-4 w-4" />
            Retry
          </Button>
        </AlertDescription>
      </Alert>
    );
  }

  return (
    <div className="space-y-4">
      {/* Warning for low confidence */}
      {conversionResult && conversionResult.confidence < 0.7 && (
        <Alert className="mb-4 border-yellow-500 bg-yellow-50">
          <AlertTriangle className="h-4 w-4 text-yellow-600" />
          <AlertTitle className="text-yellow-800">Please review AI conversion carefully</AlertTitle>
          <AlertDescription>
            The AI has low confidence in this conversion. Please review and edit
            as needed before submitting.
          </AlertDescription>
        </Alert>
      )}

      {/* Side-by-side view */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        {/* Raw text panel */}
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Original
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="bg-slate-50 p-4 rounded-md min-h-[200px] max-h-[400px] overflow-y-auto">
              <pre className="whitespace-pre-wrap font-sans text-sm">
                {rawText}
              </pre>
            </div>
          </CardContent>
        </Card>

        {/* Terse text panel */}
        <Card className={cn(isUsingManual && "border-yellow-400 border-2")}>
          <CardHeader className="pb-3 flex flex-row items-center justify-between">
            <div className="flex items-center gap-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">
                {isUsingManual ? "Manual Entry" : "AI Converted"}
              </CardTitle>
              {isUsingManual && (
                <span className="text-xs bg-yellow-100 text-yellow-800 px-2 py-0.5 rounded">
                  Manual
                </span>
              )}
            </div>
            {conversionResult && !isUsingManual && (
              <ConfidenceBadge
                confidence={conversionResult.confidence}
                processingTime={conversionResult.processingTime}
              />
            )}
          </CardHeader>
          <CardContent>
            {isEditing ? (
              <div className="space-y-3">
                <Textarea
                  value={editedText}
                  onChange={(e) => setEditedText(e.target.value)}
                  className="min-h-[200px]"
                  placeholder="Enter terse version..."
                />
                <div className="flex gap-2">
                  <Button size="sm" onClick={handleSaveEdit}>
                    <Check className="mr-2 h-4 w-4" />
                    Save
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    onClick={() => {
                      setIsEditing(false);
                      setEditedText(conversionResult?.terseText || "");
                    }}
                  >
                    Cancel
                  </Button>
                </div>
              </div>
            ) : isUsingManual ? (
              <div className="space-y-3">
                <Textarea
                  value={manualText}
                  onChange={(e) => onEdit(e.target.value)}
                  className="min-h-[200px]"
                  placeholder="Enter terse version manually..."
                />
              </div>
            ) : (
              <div className="space-y-3">
                <div className="bg-slate-50 p-4 rounded-md min-h-[200px] max-h-[400px] overflow-y-auto">
                  <pre className="whitespace-pre-wrap font-sans text-sm">
                    {conversionResult?.terseText || (
                      <span className="text-muted-foreground italic">
                        {isConverting ? "Converting..." : "Click Preview Conversion to see result"}
                      </span>
                    )}
                  </pre>
                </div>
                {conversionResult && (
                  <div className="flex gap-2">
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={() => setIsEditing(true)}
                    >
                      <Edit2 className="mr-2 h-4 w-4" />
                      Edit
                    </Button>
                    <Button
                      size="sm"
                      variant="outline"
                      onClick={onRegenerate}
                      disabled={isConverting}
                    >
                      {isConverting ? (
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                      ) : (
                        <RefreshCw className="mr-2 h-4 w-4" />
                      )}
                      Regenerate
                    </Button>
                    <Button
                      size="sm"
                      variant="secondary"
                      onClick={onUseManual}
                    >
                      Use Manual Entry
                    </Button>
                  </div>
                )}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
