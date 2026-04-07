"use client";

import { SessionProvider } from "next-auth/react";
import { AppShell } from "@/components/shared/AppShell";

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <SessionProvider>
      <AppShell>{children}</AppShell>
    </SessionProvider>
  );
}
