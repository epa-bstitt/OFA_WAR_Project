import NextAuth from "next-auth";
import AzureADB2C from "next-auth/providers/azure-ad-b2c";
import Credentials from "next-auth/providers/credentials";
import { resolveSsoUser } from "@/lib/auth-users";
import { prisma } from "@/lib/db";
import { isEpaEmail, normalizeLoginEmail, verifyPassword } from "@/lib/password";

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
    type: "oidc" as const,
    clientId: loginGovClientId!,
    clientSecret: loginGovClientSecret!,
    issuer: loginGovIssuer!,
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
      };
    },
  };
}

const {
  handlers,
  auth: baseAuth,
} = NextAuth({
  secret: authSecret,
  providers: [
    Credentials({
      id: "credentials",
      name: "EPA Account",
      credentials: {
        email: { label: "EPA email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        const email = normalizeLoginEmail(String(credentials?.email ?? ""));
        const password = String(credentials?.password ?? "");

        if (!isEpaEmail(email) || !password) {
          return null;
        }

        const user = await prisma.user.findUnique({ where: { email } });

        if (!user?.isActive || !user.passwordHash) {
          return null;
        }

        const passwordMatches = await verifyPassword(password, user.passwordHash);
        if (!passwordMatches) return null;

        return {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          azureAdId: user.azureAdId,
          mustChangePassword: user.mustChangePassword,
          sessionVersion: user.sessionVersion,
          isActive: user.isActive,
        };
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
        };
      },
    })] : []),
  ],
  callbacks: {
    async signIn({ user, account }) {
      if (!account || account.provider === "credentials") return true;
      if (account.provider !== "logingov" && account.provider !== "azure-ad-b2c") {
        return false;
      }

      const databaseUser = await resolveSsoUser(
        account.provider,
        account.providerAccountId,
        user.email ?? "",
        user.name
      );

      if (!databaseUser) return false;

      user.id = databaseUser.id;
      user.role = databaseUser.role;
      user.azureAdId = databaseUser.azureAdId;
      user.mustChangePassword = databaseUser.mustChangePassword;
      user.sessionVersion = databaseUser.sessionVersion;
      user.isActive = databaseUser.isActive;
      return true;
    },
    async jwt({ token, user }) {
      if (user) {
        token.sub = user.id;
      }

      if (!token.sub) return token;

      const databaseUser = await prisma.user.findUnique({
        where: { id: token.sub },
        select: {
          role: true,
          azureAdId: true,
          mustChangePassword: true,
          sessionVersion: true,
          isActive: true,
        },
      });

      token.role = databaseUser?.role;
      token.azureAdId = databaseUser?.azureAdId;
      token.mustChangePassword = databaseUser?.mustChangePassword ?? false;
      token.sessionVersion = databaseUser?.sessionVersion ?? 0;
      token.isActive = databaseUser?.isActive ?? false;
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.sub!;
        session.user.role = (token.role as string) ?? "CONTRIBUTOR";
        session.user.azureAdId = (token.azureAdId as string | null) ?? null;
        session.user.mustChangePassword = Boolean(token.mustChangePassword);
        session.user.sessionVersion = Number(token.sessionVersion ?? 0);
        session.user.isActive = Boolean(token.isActive);
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
export const auth = baseAuth;

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
