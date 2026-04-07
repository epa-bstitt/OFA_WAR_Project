import { NextResponse } from "next/server";
import { prisma } from "@/lib/db";

/**
 * POST /api/admin/settings/test-connections
 * Test all service connections using provided settings
 */
export async function POST(request: Request) {
  const results = {
    ai: false,
    database: false,
    microsoft: false,
    teams: false,
  };

  try {
    // Get settings from request body
    const body = await request.json();
    
    // Get AI settings from request or fallback to env vars
    const aiSettings = body?.ai || {};
    const aiUrl = aiSettings.serviceUrl || process.env.AI_SERVICE_URL;
    const aiKey = aiSettings.apiKey || process.env.AI_SERVICE_API_KEY;

    // Test Database Connection
    try {
      await prisma.$queryRaw`SELECT 1`;
      results.database = true;
    } catch (error) {
      console.error("Database connection test failed:", error);
      results.database = false;
    }

    // Test AI Service Connection
    try {
      if (aiUrl) {
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 5000);
        
        // Try to reach the base URL - any response means the service is up
        const response = await fetch(aiUrl, {
          method: "HEAD",
          headers: {
            "Authorization": `Bearer ${aiKey || ""}`,
          },
          signal: controller.signal,
        });
        
        clearTimeout(timeoutId);
        // Consider connected if we got ANY response (including 404)
        results.ai = true;
      }
    } catch (error) {
      // Only set to false on actual connection errors
      console.log("AI service not reachable:", error instanceof Error ? error.name : "failed");
      results.ai = false;
    }

    // Test Microsoft Graph Connection
    try {
      const msSettings = body?.microsoft || {};
      const clientId = msSettings.graphClientId || process.env.MICROSOFT_GRAPH_CLIENT_ID;
      const tenantId = msSettings.tenantId || process.env.MICROSOFT_GRAPH_TENANT_ID;
      const clientSecret = msSettings.graphClientSecret || process.env.MICROSOFT_GRAPH_CLIENT_SECRET;
      
      if (clientId && tenantId) {
        const tokenResponse = await fetch(`https://login.microsoftonline.com/${tenantId}/oauth2/v2.0/token`, {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: new URLSearchParams({
            client_id: clientId,
            client_secret: clientSecret || "",
            scope: "https://graph.microsoft.com/.default",
            grant_type: "client_credentials",
          }),
        });
        
        results.microsoft = tokenResponse.ok;
      }
    } catch (error) {
      console.error("Microsoft Graph connection test failed:", error);
      results.microsoft = false;
    }

    // Test Teams Bot Connection
    try {
      const teamsSettings = body?.teams || {};
      const botAppId = teamsSettings.botAppId || process.env.TEAMS_BOT_APP_ID;
      const botPassword = teamsSettings.botAppPassword || process.env.TEAMS_BOT_APP_PASSWORD;
      
      results.teams = !!(botAppId && botPassword);
    } catch (error) {
      console.error("Teams bot connection test failed:", error);
      results.teams = false;
    }

    return NextResponse.json({ status: results });
  } catch (error) {
    console.error("Error testing connections:", error);
    return NextResponse.json(
      { error: "Failed to test connections", status: results },
      { status: 500 }
    );
  }
}
