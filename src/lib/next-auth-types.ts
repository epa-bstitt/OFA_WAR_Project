import type { Session, User } from "next-auth";

type UserRole = "CONTRIBUTOR" | "AGGREGATOR" | "PROGRAM_OVERSEER" | "ADMINISTRATOR";

declare module "next-auth" {
  interface Session {
    user: User & {
      id: string;
      role: UserRole;
      azureAdId: string;
    };
  }

  interface User {
    role: UserRole;
    azureAdId: string;
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    role: UserRole;
    azureAdId: string;
  }
}
