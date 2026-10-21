"use server";

import { cookies } from "next/headers";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { logAuditEvent } from "@/lib/audit/logger";
import {
  createImpersonationToken,
  IMPERSONATION_COOKIE,
  IMPERSONATION_DURATION_SECONDS,
} from "@/lib/impersonation";

export async function listImpersonationTargets() {
  const session = await auth();
  if (!session?.user?.isActive || session.user.role !== "ADMINISTRATOR" || session.user.impersonatedBy) {
    throw new Error("Only administrators can view impersonation targets.");
  }
  return prisma.user.findMany({
    where: { isActive: true, role: { not: "ADMINISTRATOR" }, id: { not: session.user.id } },
    select: { id: true, name: true, email: true, role: true },
    orderBy: { name: "asc" },
  });
}

export async function startImpersonation(targetId: string) {
  const session = await auth();
  if (!session?.user?.isActive || session.user.role !== "ADMINISTRATOR" || session.user.impersonatedBy) {
    throw new Error("Only administrators can start impersonation.");
  }
  const target = await prisma.user.findUnique({ where: { id: targetId }, select: { id: true, isActive: true, role: true } });
  if (!target?.isActive || target.role === "ADMINISTRATOR" || target.id === session.user.id) {
    throw new Error("That user is not available for impersonation.");
  }

  await logAuditEvent({ action: "USER_IMPERSONATION_STARTED", userId: session.user.id, resourceType: "user", resourceId: target.id });
  cookies().set(IMPERSONATION_COOKIE, createImpersonationToken(session.user.id, target.id), {
    httpOnly: true, secure: process.env.NODE_ENV === "production", sameSite: "lax", path: "/",
    maxAge: IMPERSONATION_DURATION_SECONDS,
  });
  return { success: true };
}

export async function stopImpersonation() {
  const session = await auth();
  if (session?.user?.impersonatedBy) {
    await logAuditEvent({
      action: "USER_IMPERSONATION_ENDED", userId: session.user.impersonatedBy.id,
      resourceType: "user", resourceId: session.user.id,
    });
  }
  cookies().delete(IMPERSONATION_COOKIE);
  return { success: true };
}