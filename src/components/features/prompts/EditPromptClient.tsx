"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { notFound } from "next/navigation";
import { PromptForm } from "@/components/features/prompts/PromptForm";
import { updatePrompt, type PromptTemplate } from "@/app/actions/prompts";

interface EditPromptPageProps {
  prompt: PromptTemplate;
}

export default function EditPromptPage({ prompt }: EditPromptPageProps) {
  const router = useRouter();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (data: {
    name: string;
    description?: string;
    promptText: string;
    systemMsg?: string;
  }) => {
    setIsSubmitting(true);
    try {
      const result = await updatePrompt(prompt.id, data);
      if (!result.success) {
        throw new Error(result.error);
      }
      router.push("/prompts");
    } catch (error) {
      console.error("Failed to update prompt:", error);
      throw error;
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto">
      <PromptForm
        prompt={prompt}
        onSubmit={handleSubmit}
        onCancel={() => router.push("/prompts")}
        isSubmitting={isSubmitting}
      />
    </div>
  );
}
