"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { z } from "zod";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import type { PromptTemplate } from "@/app/actions/prompts";
import { ArrowLeft, Save, Loader2 } from "lucide-react";

const promptSchema = z.object({
  name: z.string().min(1, "Name is required").max(100, "Name must be less than 100 characters"),
  description: z.string().max(500, "Description must be less than 500 characters").optional(),
  promptText: z.string().min(1, "Prompt text is required"),
  systemMsg: z.string().optional(),
});

type PromptFormData = z.infer<typeof promptSchema>;

interface PromptFormProps {
  prompt?: PromptTemplate;
  onSubmit: (data: PromptFormData) => Promise<void>;
  onCancel: () => void;
  isSubmitting?: boolean;
}

export function PromptForm({ prompt, onSubmit, onCancel, isSubmitting }: PromptFormProps) {
  const isEditing = !!prompt;
  
  const {
    register,
    handleSubmit,
    formState: { errors },
    watch,
  } = useForm<PromptFormData>({
    resolver: zodResolver(promptSchema),
    defaultValues: {
      name: prompt?.name || "",
      description: prompt?.description || "",
      promptText: prompt?.promptText || "",
      systemMsg: prompt?.systemMsg || "",
    },
  });

  const promptText = watch("promptText");

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Button type="button" variant="ghost" size="sm" onClick={onCancel}>
            <ArrowLeft className="h-4 w-4 mr-1" />
            Back
          </Button>
          <div>
            <h1 className="text-xl font-semibold">
              {isEditing ? "Edit Prompt Template" : "New Prompt Template"}
            </h1>
            {isEditing && (
              <div className="flex items-center gap-2 text-sm text-muted-foreground">
                <Badge variant="secondary">v{prompt.version}</Badge>
                {prompt.isActive && (
                  <Badge className="bg-green-100 text-green-800">Active</Badge>
                )}
              </div>
            )}
          </div>
        </div>
        <Button type="submit" disabled={isSubmitting}>
          {isSubmitting ? (
            <>
              <Loader2 className="h-4 w-4 mr-2 animate-spin" />
              Saving...
            </>
          ) : (
            <>
              <Save className="h-4 w-4 mr-2" />
              {isEditing ? "Update" : "Create"}
            </>
          )}
        </Button>
      </div>

      {/* Form Fields */}
      <Card>
        <CardContent className="pt-6 space-y-4">
          <div className="space-y-2">
            <Label htmlFor="name">Name *</Label>
            <Input
              id="name"
              placeholder="e.g., EPA Standard Terse Format"
              {...register("name")}
            />
            {errors.name && (
              <p className="text-sm text-red-600">{errors.name.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="description">Description</Label>
            <Input
              id="description"
              placeholder="Brief description of this prompt's purpose..."
              {...register("description")}
            />
            {errors.description && (
              <p className="text-sm text-red-600">{errors.description.message}</p>
            )}
          </div>

          <div className="space-y-2">
            <Label htmlFor="promptText">Prompt Text *</Label>
            <Textarea
              id="promptText"
              placeholder="Enter the AI prompt template... Use {{rawText}} as placeholder for the input."
              className="min-h-[200px] font-mono text-sm"
              {...register("promptText")}
            />
            {errors.promptText && (
              <p className="text-sm text-red-600">{errors.promptText.message}</p>
            )}
            <p className="text-xs text-muted-foreground">
              Use {"{{rawText}}"} as a placeholder for the WAR text input
            </p>
          </div>

          <div className="space-y-2">
            <Label htmlFor="systemMsg">System Message (Optional)</Label>
            <Textarea
              id="systemMsg"
              placeholder="Optional system message for the AI..."
              className="min-h-[100px] font-mono text-sm"
              {...register("systemMsg")}
            />
            {errors.systemMsg && (
              <p className="text-sm text-red-600">{errors.systemMsg.message}</p>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Preview Card */}
      <Card>
        <CardContent className="pt-6">
          <h3 className="text-sm font-medium mb-2">Preview</h3>
          <div className="bg-slate-50 p-4 rounded-md">
            <p className="text-xs text-muted-foreground mb-2">Final prompt will look like:</p>
            <p className="text-sm font-mono whitespace-pre-wrap">
              {promptText?.replace(/\{\{rawText\}\}/g, "[USER_INPUT]") || "No prompt text yet..."}
            </p>
          </div>
        </CardContent>
      </Card>
    </form>
  );
}
