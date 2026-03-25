// No unused imports

type UserRole = "CONTRIBUTOR" | "AGGREGATOR" | "PROGRAM_OVERSEER" | "ADMINISTRATOR";

declare module "next-auth" {
  interface Session {
    user: User & {
      id: string;
      role: string;
      azureAdId: string;
    };
  }

  interface User {
    role: string;
    azureAdId: string;
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    role: string;
    azureAdId: string;
  }
}
