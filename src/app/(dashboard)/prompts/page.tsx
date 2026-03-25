import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { PromptManager } from "@/components/features/prompts/PromptManager";
import { getPrompts, deletePrompt, setActivePrompt } from "@/app/actions/prompts";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";

export const metadata: Metadata = {
  title: "Publish to OneNote",
  description: "Publish approved WAR submissions to OneNote",
};

export const dynamic = "force-dynamic";

export default async function PromptsPage() {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (AGGREGATOR+)
  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  // Fetch prompts
  const result = await getPrompts();

  if (!result.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load prompts</p>
      </div>
    );
  }

  // Server actions for client component
  async function handleDelete(id: string) {
    "use server";
    const result = await deletePrompt(id);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleSetActive(id: string) {
    "use server";
    const result = await setActivePrompt(id);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="AI Prompt Templates"
        description="Customize the AI prompts used for converting raw WAR text to terse format. Create, edit, and manage prompt templates."
      />

      <PromptManager
        prompts={result.prompts}
        onDelete={handleDelete}
        onSetActive={handleSetActive}
      />
    </div>
  );
}
