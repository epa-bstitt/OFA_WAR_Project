import type { DefaultSession, DefaultUser } from "next-auth";

type UserRole = "CONTRIBUTOR" | "AGGREGATOR" | "PROGRAM_OVERSEER" | "ADMINISTRATOR";

declare module "next-auth" {
  interface Session {
    user: DefaultSession["user"] & {
      id: string;
      role: string;
      azureAdId: string | null;
      mustChangePassword: boolean;
      sessionVersion: number;
      isActive: boolean;
      impersonatedBy?: { id: string; name: string | null; email: string | null };
    };
  }

  interface User extends DefaultUser {
    role?: string;
    azureAdId?: string | null;
    mustChangePassword?: boolean;
    sessionVersion?: number;
    isActive?: boolean;
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    role?: string;
    azureAdId?: string | null;
    mustChangePassword?: boolean;
    sessionVersion?: number;
    isActive?: boolean;
  }
}
