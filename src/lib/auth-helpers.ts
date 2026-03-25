import { redirect } from "next/navigation";
import { auth } from "./auth";
import type { Session } from "next-auth";

/**
 * Get the current authenticated user from the session
 * For use in Server Components
 */
export async function getCurrentUser(): Promise<Session["user"] | null> {
  const session = await auth();
  return session?.user ?? null;
}

/**
 * Require authentication - redirects to login if not authenticated
 * For use in Server Components
 */
export async function requireAuth(): Promise<Session["user"]> {
  const user = await getCurrentUser();
  if (!user) {
    redirect("/login");
  }
  return user;
}

/**
 * Require specific role(s)
 * For use in Server Components
 */
export async function requireRole(
  requiredRoles: string[]
): Promise<Session["user"]> {
  const user = await requireAuth();
  
  if (!requiredRoles.includes(user.role)) {
    redirect("/unauthorized");
  }
  
  return user;
}

/**
 * Require minimum role level (based on ROLE_HIERARCHY)
 * For use in Server Components
 */
export async function requireMinimumRole(
  minimumRole: string
): Promise<Session["user"]> {
  const user = await requireAuth();
  
  const ROLE_HIERARCHY: Record<string, number> = {
    ADMINISTRATOR: 4,
    PROGRAM_OVERSEER: 3,
    AGGREGATOR: 2,
    CONTRIBUTOR: 1,
  };
  
  const userLevel = ROLE_HIERARCHY[user.role] || 0;
  const minLevel = ROLE_HIERARCHY[minimumRole] || 0;
  
  if (userLevel < minLevel) {
    redirect("/unauthorized");
  }
  
  return user;
}

/**
 * Check if user has required role (returns boolean, no redirect)
 * For use in Server Components
 */
export async function hasRole(requiredRoles: string[]): Promise<boolean> {
  const user = await getCurrentUser();
  if (!user) return false;
  return requiredRoles.includes(user.role);
}

/**
 * Check if user has minimum role level (returns boolean, no redirect)
 * For use in Server Components
 */
export async function hasMinimumRoleLevel(minimumRole: string): Promise<boolean> {
  const user = await getCurrentUser();
  if (!user) return false;
  
  const ROLE_HIERARCHY: Record<string, number> = {
    ADMINISTRATOR: 4,
    PROGRAM_OVERSEER: 3,
    AGGREGATOR: 2,
    CONTRIBUTOR: 1,
  };
  
  const userLevel = ROLE_HIERARCHY[user.role] || 0;
  const minLevel = ROLE_HIERARCHY[minimumRole] || 0;
  
  return userLevel >= minLevel;
}
