import { redirect } from "next/navigation";
import { auth } from "@/lib/auth";
import type { Role } from "@/config/navigation";
import { getServerWorkMode } from "@/lib/server-work-mode";
import { getWorkModeLandingPath } from "@/lib/work-modes";

export default async function HomePage() {
  const session = await auth();
  
  // Redirect to dashboard if logged in, otherwise to login
  if (session?.user) {
    const workMode = getServerWorkMode(session.user.role as Role, session.user.id, session.user.email);
    redirect(getWorkModeLandingPath(workMode));
  } else {
    redirect("/login");
  }
}
