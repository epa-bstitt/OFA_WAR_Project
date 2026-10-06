import { redirect } from "next/navigation";
import { auth } from "@/lib/auth";

export default async function ChangePasswordLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const session = await auth();

  if (!session?.user?.isActive) {
    redirect("/login");
  }

  if (!session.user.mustChangePassword) {
    redirect("/dashboard");
  }

  return children;
}