import NextAuth from "next-auth";
import AzureADB2C from "next-auth/providers/azure-ad-b2c";
import Credentials from "next-auth/providers/credentials";
import type { Session } from "next-auth";
import { cookies } from "next/headers";

const authSecret =
  process.env.AUTH_SECRET ??
  process.env.NEXTAUTH_SECRET ??
  (process.env.NODE_ENV !== "production"
    ? "dev-only-auth-secret-change-me"
    : undefined);

export const isAzureAdB2CConfigured = Boolean(
  process.env.AZURE_AD_B2C_CLIENT_ID &&
    process.env.AZURE_AD_B2C_CLIENT_SECRET &&
    process.env.AZURE_AD_B2C_TENANT_NAME
);

const loginGovClientId = process.env.LOGIN_GOV_CLIENT_ID ?? process.env.LOGINGOV_CLIENT_ID;
const loginGovClientSecret = process.env.LOGIN_GOV_CLIENT_SECRET ?? process.env.LOGINGOV_CLIENT_SECRET;
const loginGovIssuer = process.env.LOGIN_GOV_ISSUER ?? process.env.LOGINGOV_ISSUER;

export const isLoginGovConfigured = Boolean(loginGovClientId && loginGovClientSecret && loginGovIssuer);

function buildLoginGovProvider() {
  return {
    id: "logingov",
    name: "Login.gov",
    type: "oidc",
    clientId: loginGovClientId!,
    clientSecret: loginGovClientSecret,
    issuer: loginGovIssuer,
    authorization: {
      params: {
        scope: process.env.LOGIN_GOV_SCOPE ?? "openid email profile",
        acr_values:
          process.env.LOGIN_GOV_ACR_VALUES ??
          "http://idmanagement.gov/ns/assurance/ial/1",
      },
    },
    profile(profile: Record<string, unknown>) {
      const firstName = (profile.given_name as string | undefined) ?? "";
      const lastName = (profile.family_name as string | undefined) ?? "";
      const fullName = `${firstName} ${lastName}`.trim();
      const subject = String(profile.sub ?? "");

      return {
        id: subject,
        name: fullName || null,
        email: String(profile.email ?? ""),
        image: null,
        role: "CONTRIBUTOR",
        azureAdId: subject,
      };
    },
  };
}

const demoUsers: Record<string, { id: string; name: string; email: string; role: string }> = {
  contributor: {
    id: "demo-contributor",
    name: "Demo Contributor",
    email: "contributor@demo.epa.gov",
    role: "CONTRIBUTOR",
  },
  aggregator: {
    id: "demo-aggregator",
    name: "Demo Aggregator",
    email: "aggregator@demo.epa.gov",
    role: "AGGREGATOR",
  },
  overseer: {
    id: "demo-overseer",
    name: "Demo Program Overseer",
    email: "overseer@demo.epa.gov",
    role: "PROGRAM_OVERSEER",
  },
  admin: {
    id: "demo-admin",
    name: "Demo Administrator",
    email: "admin@demo.epa.gov",
    role: "ADMINISTRATOR",
  },
};

function getDemoSession(roleKey: string): Session {
  const user = demoUsers[roleKey] ?? demoUsers.contributor;

  return {
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      azureAdId: user.id,
    },
    expires: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(),
  };
}

const {
  handlers,
  auth: baseAuth,
} = NextAuth({
  secret: authSecret,
  providers: [
    // Demo credentials provider for testing
    Credentials({
      id: "demo",
      name: "Demo Login",
      credentials: {
        role: { label: "Role", type: "text" },
      },
      async authorize(credentials) {
        const role = credentials?.role?.toLowerCase() || "contributor";
        const user = demoUsers[role];

        if (user) {
          return {
            id: user.id,
            name: user.name,
            email: user.email,
            role: user.role,
            azureAdId: user.id,
          };
        }

        return null;
      },
    }),
    ...(isLoginGovConfigured
      ? [
          buildLoginGovProvider(),
        ]
      : []),
    // Azure AD B2C (only if env vars are configured)
    ...(isAzureAdB2CConfigured ? [AzureADB2C({
      clientId: process.env.AZURE_AD_B2C_CLIENT_ID,
      clientSecret: process.env.AZURE_AD_B2C_CLIENT_SECRET!,
      issuer: `https://${process.env.AZURE_AD_B2C_TENANT_NAME}.b2clogin.com/${process.env.AZURE_AD_B2C_TENANT_NAME}.onmicrosoft.com/v2.0/`,
      authorization: {
        params: {
          policy: process.env.AZURE_AD_B2C_PRIMARY_USER_FLOW || "B2C_1_signupsignin1",
        },
      },
      profile(profile) {
        return {
          id: profile.oid,
          name: profile.name,
          email: profile.emails?.[0] ?? "",
          image: null,
          role: (profile as { extension_role?: string }).extension_role ?? "CONTRIBUTOR",
          azureAdId: profile.oid,
        };
      },
    })] : []),
  ],
  callbacks: {
    async jwt({ token, user }) {
      // For demo credentials provider, user is returned directly
      if (user) {
        token.sub = user.id;
        token.role = user.role ?? "CONTRIBUTOR";
        token.azureAdId = user.azureAdId ?? user.id;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.sub!;
        session.user.role = (token.role as string) ?? "CONTRIBUTOR";
        session.user.azureAdId = (token.azureAdId as string) ?? token.sub!;
      }
      return session;
    },
  },
  session: {
    strategy: "jwt",
    maxAge: parseInt(process.env.SESSION_MAX_AGE || "28800"), // 8 hours
  },
  pages: {
    signIn: "/login",
    error: "/auth/error",
  },
});

export const { GET, POST } = handlers;

export async function auth(...args: Parameters<typeof baseAuth>) {
  const session = await baseAuth(...args);

  if (args.length === 0) {
    const cookieStore = cookies();
    const isMockMode = cookieStore.get("admin-mock-mode")?.value === "true";

    if (isMockMode) {
      const selectedRole =
        cookieStore.get("admin-mock-role")?.value?.toLowerCase() || "contributor";
      return getDemoSession(selectedRole);
    }
  }

  if (session) {
    return session;
  }

  if (args.length > 0) {
    return null;
  }

  return getDemoSession("contributor");
}

// Role-based access control helper
export function hasRequiredRole(
  userRole: string | undefined,
  requiredRoles: string[]
): boolean {
  if (!userRole) return false;
  return requiredRoles.includes(userRole);
}

// Role hierarchy for permission checking
export const ROLE_HIERARCHY = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

export function hasMinimumRole(
  userRole: string | undefined,
  minimumRole: string
): boolean {
  if (!userRole) return false;
  const userLevel = ROLE_HIERARCHY[userRole as keyof typeof ROLE_HIERARCHY] || 0;
  const minLevel = ROLE_HIERARCHY[minimumRole as keyof typeof ROLE_HIERARCHY] || 0;
  return userLevel >= minLevel;
}
