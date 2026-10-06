import type { Role } from "@/config/navigation";

export const WORK_MODE_COOKIE = "work-mode";
const JAKE_BEJA_USER_ID = "import-jake-beja";
const JAKE_BEJA_EMAIL = "beja.jake@epa.gov";
const BRIAN_STITT_EMAIL = "stitt.brian@epa.gov";

export const WORK_MODE_LABELS: Record<Role, string> = {
  CONTRIBUTOR: "Contributor",
  AGGREGATOR: "Aggregator",
  PROGRAM_OVERSEER: "Program Overseer",
  ADMINISTRATOR: "Administrator",
};

const ALLOWED_WORK_MODES: Record<Role, Role[]> = {
  CONTRIBUTOR: ["CONTRIBUTOR"],
  AGGREGATOR: ["CONTRIBUTOR", "AGGREGATOR"],
  PROGRAM_OVERSEER: ["AGGREGATOR", "PROGRAM_OVERSEER"],
  ADMINISTRATOR: ["ADMINISTRATOR"],
};

const LANDING_PATHS: Record<Role, string> = {
  CONTRIBUTOR: "/dashboard",
  AGGREGATOR: "/review",
  PROGRAM_OVERSEER: "/approve",
  ADMINISTRATOR: "/dashboard",
};

export function getAllowedWorkModes(role: Role, userId?: string | null, email?: string | null): Role[] {
  if (isJakeBejaUser(userId, email) || isBrianStittUser(userId, email)) {
    return ["CONTRIBUTOR", "AGGREGATOR", "PROGRAM_OVERSEER"];
  }

  return ALLOWED_WORK_MODES[role] ?? [role];
}

export function isJakeBejaUser(userId?: string | null, email?: string | null): boolean {
  return userId === JAKE_BEJA_USER_ID || email?.toLowerCase() === JAKE_BEJA_EMAIL;
}

export function isBrianStittUser(userId?: string | null, email?: string | null): boolean {
  return email?.toLowerCase() === BRIAN_STITT_EMAIL || false;
}

export function getDefaultWorkMode(role: Role, userId?: string | null, email?: string | null): Role {
  if (isJakeBejaUser(userId, email) || isBrianStittUser(userId, email)) {
    return "CONTRIBUTOR";
  }

  return role;
}

export function getValidatedWorkMode(
  role: Role,
  requestedMode?: string | null,
  userId?: string | null,
  email?: string | null
): Role {
  const allowedModes = getAllowedWorkModes(role, userId, email);
  if (allowedModes.includes(requestedMode as Role)) {
    return requestedMode as Role;
  }

  return getDefaultWorkMode(role, userId, email);
}

export function getWorkModeLandingPath(mode: Role): string {
  return LANDING_PATHS[mode];
}