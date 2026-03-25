import { ConfidentialClientApplication, Configuration } from "@azure/msal-node";

// MSAL configuration for Microsoft Graph
const msalConfig: Configuration = {
  auth: {
    clientId: process.env.MS_GRAPH_CLIENT_ID || "",
    clientSecret: process.env.MS_GRAPH_CLIENT_SECRET || "",
    authority: `https://login.microsoftonline.com/${process.env.MS_GRAPH_TENANT_ID}`,
  },
  system: {
    loggerOptions: {
      loggerCallback(loglevel: unknown, message: string) {
        if (process.env.NODE_ENV === "development") {
          console.log(message);
        }
      },
      piiLoggingEnabled: false,
    },
  },
};

// Cache for access token
let cachedToken: string | null = null;
let tokenExpiry: Date | null = null;

/**
 * Get Microsoft Graph access token using client credentials flow
 */
export async function getGraphAccessToken(): Promise<string> {
  // Check if we have a valid cached token
  if (cachedToken && tokenExpiry && tokenExpiry > new Date()) {
    return cachedToken;
  }

  // Check if environment variables are configured
  if (!process.env.MS_GRAPH_CLIENT_ID || !process.env.MS_GRAPH_CLIENT_SECRET || !process.env.MS_GRAPH_TENANT_ID) {
    throw new Error("Microsoft Graph credentials not configured");
  }

  const client = new ConfidentialClientApplication(msalConfig);

  const result = await client.acquireTokenByClientCredential({
    scopes: ["https://graph.microsoft.com/.default"],
  });

  if (!result?.accessToken) {
    throw new Error("Failed to acquire access token for Microsoft Graph");
  }

  // Cache token with 5-minute buffer before expiry
  cachedToken = result.accessToken;
  tokenExpiry = result.expiresOn ?? null;
  
  if (tokenExpiry) {
    // Subtract 5 minutes for safety buffer
    tokenExpiry = new Date(tokenExpiry.getTime() - 5 * 60 * 1000);
  }

  return cachedToken;
}

/**
 * Clear cached token (useful for testing or after errors)
 */
export function clearCachedToken(): void {
  cachedToken = null;
  tokenExpiry = null;
}

/**
 * Check if Microsoft Graph is configured
 */
export function isGraphConfigured(): boolean {
  return !!(
    process.env.MS_GRAPH_CLIENT_ID &&
    process.env.MS_GRAPH_CLIENT_SECRET &&
    process.env.MS_GRAPH_TENANT_ID
  );
}
