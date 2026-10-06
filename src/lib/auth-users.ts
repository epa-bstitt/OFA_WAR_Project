import "server-only";

import { prisma } from "@/lib/db";
import { isEpaEmail, normalizeLoginEmail } from "@/lib/password";

type SupportedSsoProvider = "azure-ad-b2c" | "logingov";

export async function resolveSsoUser(
  provider: SupportedSsoProvider,
  providerAccountId: string,
  email: string,
  name?: string | null
) {
  const normalizedEmail = normalizeLoginEmail(email);

  if (!isEpaEmail(normalizedEmail)) {
    return null;
  }

  const user = await prisma.user.findUnique({
    where: { email: normalizedEmail },
  });

  if (!user?.isActive) {
    return null;
  }

  const providerField = provider === "logingov" ? "loginGovId" : "azureAdId";
  const existingProviderId = user[providerField];

  if (existingProviderId && existingProviderId !== providerAccountId) {
    return null;
  }

  if (!existingProviderId) {
    return prisma.user.update({
      where: { id: user.id },
      data: {
        [providerField]: providerAccountId,
        name: user.name ?? name ?? undefined,
        sessionVersion: { increment: 1 },
      },
    });
  }

  return user;
}