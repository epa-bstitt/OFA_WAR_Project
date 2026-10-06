"use server";

import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { hashPassword, validateNewPassword, verifyPassword } from "@/lib/password";

export async function changeOwnPassword(
  currentPassword: string,
  newPassword: string
): Promise<{ success: true } | { success: false; error: string }> {
  const session = await auth();

  if (!session?.user?.id || !session.user.isActive) {
    return { success: false, error: "Not authenticated." };
  }

  const validationError = validateNewPassword(newPassword);
  if (validationError) {
    return { success: false, error: validationError };
  }

  if (currentPassword === newPassword) {
    return { success: false, error: "Choose a password different from your temporary password." };
  }

  const user = await prisma.user.findUnique({
    where: { id: session.user.id },
    select: { passwordHash: true, isActive: true },
  });

  if (!user?.isActive || !user.passwordHash) {
    return { success: false, error: "Unable to change the password for this account." };
  }

  if (!(await verifyPassword(currentPassword, user.passwordHash))) {
    return { success: false, error: "The current password is incorrect." };
  }

  await prisma.user.update({
    where: { id: session.user.id },
    data: {
      passwordHash: await hashPassword(newPassword),
      mustChangePassword: false,
      passwordChangedAt: new Date(),
      sessionVersion: { increment: 1 },
    },
  });

  return { success: true };
}