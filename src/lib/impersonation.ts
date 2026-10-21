import { createHmac, timingSafeEqual } from "node:crypto";

export const IMPERSONATION_COOKIE = "admin-view-as";
export const IMPERSONATION_DURATION_SECONDS = 60 * 60;

function secret() {
  const value = process.env.AUTH_SECRET ?? process.env.NEXTAUTH_SECRET;
  if (!value && process.env.NODE_ENV === "production") {
    throw new Error("An auth secret is required for impersonation.");
  }
  return value ?? "dev-only-auth-secret-change-me";
}

export function createImpersonationToken(adminId: string, targetId: string, now = Date.now()): string {
  const payload = Buffer.from(JSON.stringify({ adminId, targetId, expiresAt: now + IMPERSONATION_DURATION_SECONDS * 1000 })).toString("base64url");
  const signature = createHmac("sha256", secret()).update(payload).digest("base64url");
  return `${payload}.${signature}`;
}

export function readImpersonationToken(value: string | undefined, adminId: string, now = Date.now()): string | null {
  if (!value) return null;
  const [payload, signature, extra] = value.split(".");
  if (!payload || !signature || extra) return null;
  const expected = createHmac("sha256", secret()).update(payload).digest();
  const received = Buffer.from(signature, "base64url");
  if (received.length !== expected.length || !timingSafeEqual(received, expected)) return null;

  try {
    const parsed: unknown = JSON.parse(Buffer.from(payload, "base64url").toString("utf8"));
    if (!parsed || typeof parsed !== "object") return null;
    const token = parsed as { adminId?: unknown; targetId?: unknown; expiresAt?: unknown };
    return token.adminId === adminId && typeof token.targetId === "string" &&
      token.targetId !== adminId && typeof token.expiresAt === "number" &&
      token.expiresAt > now ? token.targetId : null;
  } catch {
    return null;
  }
}