import { SessionProvider } from "next-auth/react";
import { redirect } from "next/navigation";
import { AppShell } from "@/components/shared/AppShell";
import { auth } from "@/lib/auth";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  if (!session?.user?.isActive) {
    redirect("/login");
  }

  if (session.user.mustChangePassword) {
    redirect("/change-password");
  }

  return (
    <SessionProvider session={session as never}>
      <AppShell>{children}</AppShell>
    </SessionProvider>
  );
}
