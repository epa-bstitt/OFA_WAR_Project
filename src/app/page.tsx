import { redirect } from "next/navigation";
import { auth } from "@/lib/auth";

export default async function HomePage() {
  const session = await auth();
  
  // Redirect to dashboard if logged in, otherwise to login
  if (session?.user) {
    if (session.user.role === "PROGRAM_OVERSEER") {
      redirect("/approve");
    }

    if (session.user.role === "AGGREGATOR") {
      redirect("/review");
    }

    redirect("/dashboard");
  } else {
    redirect("/login");
  }
}
