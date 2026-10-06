import "server-only";

import { cookies } from "next/headers";
import type { Role } from "@/config/navigation";
import { getValidatedWorkMode, WORK_MODE_COOKIE } from "@/lib/work-modes";

export function getServerWorkMode(authorityRole: Role, userId?: string | null, email?: string | null): Role {
  return getValidatedWorkMode(authorityRole, cookies().get(WORK_MODE_COOKIE)?.value, userId, email);
}