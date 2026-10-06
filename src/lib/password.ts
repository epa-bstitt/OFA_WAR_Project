import "server-only";

import { compare, hash } from "bcryptjs";

const BCRYPT_COST = 12;
const MINIMUM_PASSWORD_LENGTH = 12;
const MAXIMUM_PASSWORD_BYTES = 72;

export function normalizeLoginEmail(email: string): string {
  return email.trim().toLowerCase();
}

export function isEpaEmail(email: string): boolean {
  return /^[^\s@]+@epa\.gov$/i.test(normalizeLoginEmail(email));
}

export function validateNewPassword(password: string): string | null {
  if (password.length < MINIMUM_PASSWORD_LENGTH) {
    return `Password must be at least ${MINIMUM_PASSWORD_LENGTH} characters.`;
  }

  if (Buffer.byteLength(password, "utf8") > MAXIMUM_PASSWORD_BYTES) {
    return "Password is too long.";
  }

  return null;
}

export async function hashPassword(password: string): Promise<string> {
  return hash(password, BCRYPT_COST);
}

export async function verifyPassword(
  password: string,
  passwordHash: string
): Promise<boolean> {
  return compare(password, passwordHash);
}