"use server";

import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";

// Types matching Prisma schema
export interface PromptTemplate {
  id: string;
  name: string;
  description?: string | null;
  promptText: string;
  systemMsg?: string | null;
  version: string;
  isActive: boolean;
  isDeleted: boolean;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface CreatePromptInput {
  name: string;
  description?: string;
  promptText: string;
  systemMsg?: string;
}

export interface UpdatePromptInput {
  name?: string;
  description?: string;
  promptText?: string;
  systemMsg?: string;
}

/**
 * Server Action: Get all prompt templates
 */
export async function getPrompts(): Promise<
  | { success: true; prompts: PromptTemplate[] }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const prompts = await prisma.promptTemplate.findMany({
      where: { isDeleted: false },
      orderBy: [{ isActive: "desc" }, { updatedAt: "desc" }],
    });

    return { success: true, prompts };
  } catch (error) {
    console.error("Error fetching prompts:", error);
    return { success: false, error: "Failed to fetch prompts" };
  }
}

/**
 * Server Action: Get a single prompt template
 */
export async function getPromptById(
  id: string
): Promise<
  | { success: true; prompt: PromptTemplate }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const prompt = await prisma.promptTemplate.findFirst({
      where: { id, isDeleted: false },
    });

    if (!prompt) {
      return { success: false, error: "Prompt not found" };
    }

    return { success: true, prompt };
  } catch (error) {
    console.error("Error fetching prompt:", error);
    return { success: false, error: "Failed to fetch prompt" };
  }
}

/**
 * Server Action: Get the active prompt template
 */
export async function getActivePrompt(): Promise<
  | { success: true; prompt: PromptTemplate | null }
  | { success: false; error: string }
> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const prompt = await prisma.promptTemplate.findFirst({
      where: { isActive: true, isDeleted: false },
    });

    return { success: true, prompt };
  } catch (error) {
    console.error("Error fetching active prompt:", error);
    return { success: false, error: "Failed to fetch active prompt" };
  }
}

/**
 * Server Action: Create a new prompt template
 */
export async function createPrompt(
  data: CreatePromptInput
): Promise<{ success: true; prompt: PromptTemplate } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    // Check for duplicate name
    const existing = await prisma.promptTemplate.findFirst({
      where: { name: data.name, isDeleted: false },
    });

    if (existing) {
      return { success: false, error: "A prompt with this name already exists" };
    }

    const prompt = await prisma.promptTemplate.create({
      data: {
        name: data.name,
        description: data.description,
        promptText: data.promptText,
        systemMsg: data.systemMsg,
        version: "1.0.0",
        isActive: false,
        createdBy: session.user.id,
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "PROMPT_CREATED",
        userId: session.user.id,
        resourceType: "prompt",
        resourceId: prompt.id,
        metadata: { name: data.name, version: "1.0.0" },
      },
    });

    revalidatePath("/prompts");

    return { success: true, prompt };
  } catch (error) {
    console.error("Error creating prompt:", error);
    return { success: false, error: "Failed to create prompt" };
  }
}

/**
 * Server Action: Update a prompt template (creates new version)
 */
export async function updatePrompt(
  id: string,
  data: UpdatePromptInput
): Promise<{ success: true; prompt: PromptTemplate } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const existingPrompt = await prisma.promptTemplate.findFirst({
      where: { id, isDeleted: false },
    });

    if (!existingPrompt) {
      return { success: false, error: "Prompt not found" };
    }

    // Increment version (simple patch increment)
    const currentVersion = existingPrompt.version;
    const parts = currentVersion.split(".").map(Number);
    parts[2] = (parts[2] || 0) + 1;
    const newVersion = parts.join(".");

    // If name is changing, check for duplicates
    if (data.name && data.name !== existingPrompt.name) {
      const duplicate = await prisma.promptTemplate.findFirst({
        where: { name: data.name, isDeleted: false, id: { not: id } },
      });
      if (duplicate) {
        return { success: false, error: "A prompt with this name already exists" };
      }
    }

    const prompt = await prisma.promptTemplate.update({
      where: { id },
      data: {
        name: data.name ?? existingPrompt.name,
        description: data.description ?? existingPrompt.description,
        promptText: data.promptText ?? existingPrompt.promptText,
        systemMsg: data.systemMsg ?? existingPrompt.systemMsg,
        version: newVersion,
      },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "PROMPT_UPDATED",
        userId: session.user.id,
        resourceType: "prompt",
        resourceId: prompt.id,
        metadata: { version: newVersion, changedFields: Object.keys(data) },
      },
    });

    revalidatePath("/prompts");
    revalidatePath(`/prompts/${id}/edit`);

    return { success: true, prompt };
  } catch (error) {
    console.error("Error updating prompt:", error);
    return { success: false, error: "Failed to update prompt" };
  }
}

/**
 * Server Action: Soft delete a prompt template
 */
export async function deletePrompt(
  id: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const existingPrompt = await prisma.promptTemplate.findFirst({
      where: { id, isDeleted: false },
    });

    if (!existingPrompt) {
      return { success: false, error: "Prompt not found" };
    }

    // Cannot delete active prompt
    if (existingPrompt.isActive) {
      return { success: false, error: "Cannot delete the active prompt. Set another prompt as active first." };
    }

    await prisma.promptTemplate.update({
      where: { id },
      data: { isDeleted: true, isActive: false },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "PROMPT_DELETED",
        userId: session.user.id,
        resourceType: "prompt",
        resourceId: id,
        metadata: { name: existingPrompt.name },
      },
    });

    revalidatePath("/prompts");

    return { success: true };
  } catch (error) {
    console.error("Error deleting prompt:", error);
    return { success: false, error: "Failed to delete prompt" };
  }
}

/**
 * Server Action: Set a prompt as active
 */
export async function setActivePrompt(
  id: string
): Promise<{ success: true } | { success: false; error: string }> {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return { success: false, error: "Not authenticated" };
    }

    const prompt = await prisma.promptTemplate.findFirst({
      where: { id, isDeleted: false },
    });

    if (!prompt) {
      return { success: false, error: "Prompt not found" };
    }

    // Deactivate all other prompts
    await prisma.promptTemplate.updateMany({
      where: { isActive: true },
      data: { isActive: false },
    });

    // Activate this prompt
    await prisma.promptTemplate.update({
      where: { id },
      data: { isActive: true },
    });

    // Log audit event
    await prisma.auditLog.create({
      data: {
        action: "PROMPT_ACTIVATED",
        userId: session.user.id,
        resourceType: "prompt",
        resourceId: id,
        metadata: { name: prompt.name, version: prompt.version },
      },
    });

    revalidatePath("/prompts");

    return { success: true };
  } catch (error) {
    console.error("Error setting active prompt:", error);
    return { success: false, error: "Failed to set active prompt" };
  }
}
