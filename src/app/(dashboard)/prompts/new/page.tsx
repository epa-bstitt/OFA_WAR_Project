"use client";

export const dynamic = "force-dynamic";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { PromptForm } from "@/components/features/prompts/PromptForm";
import { createPrompt } from "@/app/actions/prompts";

export default function NewPromptPage() {
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
      const result = await createPrompt(data);
      if (!result.success) {
        throw new Error(result.error);
      }
      router.push("/prompts");
    } catch (error) {
      console.error("Failed to create prompt:", error);
      throw error;
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="max-w-3xl mx-auto">
      <PromptForm
        onSubmit={handleSubmit}
        onCancel={() => router.push("/prompts")}
        isSubmitting={isSubmitting}
      />
    </div>
  );
}
