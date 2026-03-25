import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getStoredSettings, setStoredSettings } from "./store";

// In-memory settings store (replace with database in production)
let systemSettings: Record<string, unknown> = {};

/**
 * GET /api/admin/settings
 * Retrieve current system settings
 */
export async function GET() {
  try {
    // Check authentication
    const session = await auth();
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      );
    }

    // Check permissions (ADMINISTRATOR only)
    const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
    if (!hasPermission) {
      return NextResponse.json(
        { error: "Forbidden - Administrator access required" },
        { status: 403 }
      );
    }

    // Return settings from environment variables and stored config
    // Stored settings take precedence over env vars
    const envSettings = {
      ai: {
        serviceUrl: process.env.AI_SERVICE_URL || "",
        apiKey: maskSecret(process.env.AI_SERVICE_API_KEY || ""),
        timeout: parseInt(process.env.AI_SERVICE_TIMEOUT || "5000"),
        enabled: process.env.ENABLE_AI_CONVERSION !== "false",
      },
      database: {
        connectionString: maskConnectionString(process.env.DATABASE_URL || ""),
        poolSize: 20,
        sslEnabled: true,
      },
      microsoft: {
        graphClientId: process.env.MS_GRAPH_CLIENT_ID || "",
        graphClientSecret: maskSecret(process.env.MS_GRAPH_CLIENT_SECRET || ""),
        tenantId: process.env.MS_GRAPH_TENANT_ID || "",
        enabled: process.env.ENABLE_ONE_NOTE_PUBLISH !== "false",
      },
      teams: {
        botAppId: process.env.BOT_APP_ID || "",
        botAppPassword: maskSecret(process.env.BOT_APP_PASSWORD || ""),
        enabled: process.env.ENABLE_TEAMS_BOT === "true",
      },
      audit: {
        retentionDays: parseInt(process.env.AUDIT_LOG_RETENTION_DAYS || "2555"),
        detailedLogging: process.env.ENABLE_DETAILED_AUDIT === "true",
        piiMasking: process.env.PII_MASKING_ENABLED !== "false",
      },
      security: {
        sessionMaxAge: parseInt(process.env.SESSION_MAX_AGE || "28800"),
        maxLoginAttempts: 5,
        lockoutDuration: 30,
      },
    };

    // Merge: stored settings override env defaults
    const storedSettings = await getStoredSettings();
    const settings = {
      ...envSettings,
      ...storedSettings,
      ai: { ...envSettings.ai, ...(storedSettings.ai || {}) },
      database: { ...envSettings.database, ...(storedSettings.database || {}) },
      microsoft: { ...envSettings.microsoft, ...(storedSettings.microsoft || {}) },
      teams: { ...envSettings.teams, ...(storedSettings.teams || {}) },
      audit: { ...envSettings.audit, ...(storedSettings.audit || {}) },
      security: { ...envSettings.security, ...(storedSettings.security || {}) },
    };

    return NextResponse.json({ settings });
  } catch (error) {
    console.error("Error fetching settings:", error);
    return NextResponse.json(
      { error: "Failed to fetch settings" },
      { status: 500 }
    );
  }
}

/**
 * POST /api/admin/settings
 * Update system settings
 */
export async function POST(request: Request) {
  try {
    // Check authentication
    const session = await auth();
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      );
    }

    // Check permissions (ADMINISTRATOR only)
    const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
    if (!hasPermission) {
      return NextResponse.json(
        { error: "Forbidden - Administrator access required" },
        { status: 403 }
      );
    }

    const body = await request.json();
    
    // Validate settings structure
    if (!body || typeof body !== "object") {
      return NextResponse.json(
        { error: "Invalid settings format" },
        { status: 400 }
      );
    }

    // Store settings (in production, save to database)
    await setStoredSettings(body);

    // Note: Some settings require application restart to take effect
    // Database connection strings, API keys, etc.

    return NextResponse.json({ 
      success: true, 
      message: "Settings saved successfully",
      requiresRestart: checkRequiresRestart(body),
    });
  } catch (error) {
    console.error("Error saving settings:", error);
    return NextResponse.json(
      { error: "Failed to save settings" },
      { status: 500 }
    );
  }
}

/**
 * POST /api/admin/settings/test-connections
 * Test all service connections
 */
export async function PATCH(request: Request) {
  try {
    // Check authentication
    const session = await auth();
    if (!session?.user?.id) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      );
    }

    // Check permissions (ADMINISTRATOR only)
    const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
    if (!hasPermission) {
      return NextResponse.json(
        { error: "Forbidden - Administrator access required" },
        { status: 403 }
      );
    }

    const url = new URL(request.url);
    const action = url.searchParams.get("action");

    if (action === "test-connections") {
      // Test all service connections
      const status = {
        ai: await testAIConnection(),
        database: await testDatabaseConnection(),
        microsoft: await testMicrosoftConnection(),
        teams: await testTeamsConnection(),
      };

      return NextResponse.json({ status });
    }

    return NextResponse.json(
      { error: "Invalid action" },
      { status: 400 }
    );
  } catch (error) {
    console.error("Error testing connections:", error);
    return NextResponse.json(
      { error: "Failed to test connections" },
      { status: 500 }
    );
  }
}

// Helper functions
function maskSecret(secret: string): string {
  if (!secret || secret.length < 8) return "";
  return secret.slice(0, 4) + "****" + secret.slice(-4);
}

function maskConnectionString(connStr: string): string {
  if (!connStr) return "";
  // Mask password in connection string
  return connStr.replace(/:([^@]+)@/, ":****@");
}

function checkRequiresRestart(settings: Record<string, unknown>): boolean {
  // Check if any critical settings changed that require restart
  const criticalSections = ["database", "ai", "microsoft", "teams"];
  return criticalSections.some(section => section in settings);
}

// Connection test functions using stored settings
async function testAIConnection(): Promise<boolean> {
  try {
    const storedSettings = await getStoredSettings();
    const storedAI = (storedSettings.ai as Record<string, unknown>) || {};
    const url = (storedAI.serviceUrl as string) || process.env.AI_SERVICE_URL;
    const key = (storedAI.apiKey as string) || process.env.AI_SERVICE_API_KEY;
    
    if (!url) return false;
    
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 5000);
    
    const response = await fetch(`${url}/models`, {
      method: "GET",
      headers: {
        "Authorization": `Bearer ${key || ""}`,
        "Content-Type": "application/json",
      },
      signal: controller.signal,
    });
    
    clearTimeout(timeoutId);
    return response.ok;
  } catch {
    return false;
  }
}

async function testDatabaseConnection(): Promise<boolean> {
  try {
    // In production, use Prisma to check connection
    const url = process.env.DATABASE_URL;
    if (!url) return false;
    
    // Mock test - would be replaced with actual connection test
    return true;
  } catch {
    return false;
  }
}

async function testMicrosoftConnection(): Promise<boolean> {
  try {
    // In production, test Microsoft Graph API connection
    const clientId = process.env.MS_GRAPH_CLIENT_ID;
    const tenantId = process.env.MS_GRAPH_TENANT_ID;
    if (!clientId || !tenantId) return false;
    
    // Mock test - would be replaced with actual token acquisition
    return true;
  } catch {
    return false;
  }
}

async function testTeamsConnection(): Promise<boolean> {
  try {
    // In production, test Bot Framework connection
    const appId = process.env.BOT_APP_ID;
    if (!appId) return false;
    
    // Mock test - would be replaced with actual bot health check
    return true;
  } catch {
    return false;
  }
}
