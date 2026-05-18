import { Metadata } from "next";
import { notFound, redirect } from "next/navigation";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getPromptById } from "@/app/actions/prompts";
import EditPromptClient from "@/components/features/prompts/EditPromptClient";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";

interface EditPromptPageProps {
  params: { id: string };
}

export async function generateMetadata({ params }: EditPromptPageProps): Promise<Metadata> {
  return {
    title: "Edit Prompt Template",
    description: "Edit AI prompt template",
  };
}

export default async function EditPromptPage({ params }: EditPromptPageProps) {
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

  const storedSettings = await getStoredSettings();
  const aggregatorAccess = getOverseerSettings(storedSettings).aggregatorAccess;
  if (session.user.role === "AGGREGATOR" && !aggregatorAccess.promptTemplateManagementEnabled) {
    redirect("/prompts");
  }

  // Fetch prompt
  const result = await getPromptById(params.id);

  if (!result.success) {
    notFound();
  }

  return <EditPromptClient prompt={result.prompt} />;
}
