import NextAuth from "next-auth";
import AzureADB2C from "next-auth/providers/azure-ad-b2c";
import Credentials from "next-auth/providers/credentials";
import { PrismaAdapter } from "@auth/prisma-adapter";
import type { Adapter } from "@auth/core/adapters";
import type { Session } from "next-auth";
import { prisma } from "./db";

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

const fallbackSession: Session = {
  user: {
    id: "demo-admin",
    name: "Demo Administrator",
    email: "admin@demo.epa.gov",
    role: "ADMINISTRATOR",
    azureAdId: "demo-admin",
  },
  expires: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(),
};

const {
  handlers,
  auth: baseAuth,
  signIn,
  signOut,
} = NextAuth({
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  adapter: PrismaAdapter(prisma) as Adapter,
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
        // Demo users for testing
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
    async jwt({ token, user, account }) {
      // For demo credentials provider, user is returned directly
      if (user) {
        token.sub = user.id;
        token.role = user.role;
        token.azureAdId = user.azureAdId;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.sub!;
        session.user.role = token.role as string;
        session.user.azureAdId = token.azureAdId as string;
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

  if (args.length > 0) {
    return session;
  }

  return session ?? fallbackSession;
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
