"use client";

import { useState, useEffect, useCallback } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Check, RotateCcw, Save } from "lucide-react";

interface TerseEditorProps {
  initialTerseText: string;
  onChange?: (text: string) => void;
  submissionId: string;
}

const COMMENT_TEMPLATES = [
  "Fixed abbreviations",
  "Added missing detail",
  "Corrected formatting",
  "Improved clarity",
  "Removed unnecessary content",
];

export function TerseEditor({ initialTerseText, onChange, submissionId }: TerseEditorProps) {
  const [terseText, setTerseText] = useState(initialTerseText);
  const [originalText] = useState(initialTerseText);
  const [isSaving, setIsSaving] = useState(false);
  const [lastSaved, setLastSaved] = useState<Date | null>(null);
  const [charCount, setCharCount] = useState(initialTerseText.length);
  const [selectedTemplate, setSelectedTemplate] = useState<string | null>(null);

  // Update char count when text changes
  useEffect(() => {
    setCharCount(terseText.length);
    onChange?.(terseText);
  }, [terseText, onChange]);

  // Auto-save to localStorage (draft backup)
  useEffect(() => {
    const timer = setTimeout(() => {
      if (terseText !== originalText) {
        localStorage.setItem(`review-draft-${submissionId}`, terseText);
        setLastSaved(new Date());
        setIsSaving(false);
      }
    }, 3000);

    return () => clearTimeout(timer);
  }, [terseText, originalText, submissionId]);

  // Load draft on mount
  useEffect(() => {
    const draft = localStorage.getItem(`review-draft-${submissionId}`);
    if (draft && draft !== initialTerseText) {
      setTerseText(draft);
    }
  }, [submissionId, initialTerseText]);

  const handleReset = useCallback(() => {
    setTerseText(originalText);
    localStorage.removeItem(`review-draft-${submissionId}`);
    setLastSaved(null);
  }, [originalText, submissionId]);

  const hasChanges = terseText !== originalText;
  const isTooLong = charCount > 1000;

  return (
    <Card className="h-full flex flex-col">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <CardTitle className="text-base">Terse Version</CardTitle>
          <div className="flex items-center gap-2">
            {lastSaved && (
              <span className="text-xs text-green-600 flex items-center gap-1">
                <Check className="h-3 w-3" />
                Draft saved
              </span>
            )}
            <Badge 
              variant={isTooLong ? "destructive" : "secondary"}
              className="text-xs"
            >
              {charCount} chars
            </Badge>
          </div>
        </div>
        <p className="text-xs text-muted-foreground">
          Edit the AI-generated terse version below
        </p>
      </CardHeader>
      <CardContent className="flex-1 flex flex-col gap-3">
        <Textarea
          value={terseText}
          onChange={(e) => {
            setTerseText(e.target.value);
            setIsSaving(true);
          }}
          className="flex-1 min-h-[200px] resize-none font-mono text-sm leading-relaxed"
          placeholder="Enter terse version..."
        />
        
        {hasChanges && (
          <div className="flex items-center justify-between">
            <Button
              variant="ghost"
              size="sm"
              onClick={handleReset}
              className="text-muted-foreground"
            >
              <RotateCcw className="h-4 w-4 mr-1" />
              Reset to original
            </Button>
            <span className="text-xs text-muted-foreground">
              Auto-saving draft...
            </span>
          </div>
        )}

        {/* Comment templates */}
        <div className="pt-2 border-t">
          <p className="text-xs text-muted-foreground mb-2">Quick edit reasons:</p>
          <div className="flex flex-wrap gap-2">
            {COMMENT_TEMPLATES.map((template) => (
              <Button
                key={template}
                variant={selectedTemplate === template ? "default" : "outline"}
                size="sm"
                className="text-xs"
                onClick={() => setSelectedTemplate(
                  selectedTemplate === template ? null : template
                )}
              >
                {template}
              </Button>
            ))}
          </div>
        </div>
      </CardContent>
    </Card>
  );
}

export { COMMENT_TEMPLATES };
