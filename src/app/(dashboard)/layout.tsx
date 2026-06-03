import { SessionProvider } from "next-auth/react";
import { AppShell } from "@/components/shared/AppShell";
import { auth } from "@/lib/auth";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  return (
    <SessionProvider session={session as never}>
      <AppShell>{children}</AppShell>
    </SessionProvider>
  );
}
