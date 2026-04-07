import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { getStoredSettings } from "@/app/api/admin/settings/store";

/**
 * GET /api/settings/ai
 * Get AI service settings for authenticated users (public read-only)
 */
export async function GET() {
  try {
    // Check authentication (any logged-in user can read AI settings)
    const session = await auth();
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      );
    }

    // Get stored settings
    const storedSettings = await getStoredSettings();
    const storedAI = (storedSettings.ai as Record<string, unknown>) || {};

    // Return AI settings (only non-sensitive data)
    const settings = {
      serviceUrl: (storedAI.serviceUrl as string) || process.env.AI_SERVICE_URL || "",
      model: (storedAI.model as string) || "gpt-4o-mini",
      enabled: (storedAI.enabled as boolean) ?? true,
      timeout: (storedAI.timeout as number) || 5000,
    };

    return NextResponse.json({ settings });
  } catch (error) {
    console.error("Error fetching AI settings:", error);
    return NextResponse.json(
      { error: "Failed to fetch AI settings" },
      { status: 500 }
    );
  }
}
