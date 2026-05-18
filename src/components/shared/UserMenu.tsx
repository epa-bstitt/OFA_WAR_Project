"use client";

import { useEffect, useState } from "react";
import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { cn } from "@/lib/utils";

const roleColors: Record<string, string> = {
  CONTRIBUTOR: "bg-blue-100 text-blue-800",
  AGGREGATOR: "bg-yellow-100 text-yellow-800",
  PROGRAM_OVERSEER: "bg-green-100 text-green-800",
  ADMINISTRATOR: "bg-red-100 text-red-800",
};

const roleLabels: Record<string, string> = {
  CONTRIBUTOR: "Contributor",
  AGGREGATOR: "Aggregator",
  PROGRAM_OVERSEER: "Program Overseer",
  ADMINISTRATOR: "Administrator",
};

const demoUsers: Record<string, { name: string; email: string; role: string }> = {
  contributor: {
    name: "Demo Contributor",
    email: "contributor@demo.epa.gov",
    role: "CONTRIBUTOR",
  },
  aggregator: {
    name: "Demo Aggregator",
    email: "aggregator@demo.epa.gov",
    role: "AGGREGATOR",
  },
  overseer: {
    name: "Demo Program Overseer",
    email: "overseer@demo.epa.gov",
    role: "PROGRAM_OVERSEER",
  },
  admin: {
    name: "Demo Administrator",
    email: "admin@demo.epa.gov",
    role: "ADMINISTRATOR",
  },
};

function getCookie(name: string): string | null {
  if (typeof document === "undefined") {
    return null;
  }

  const match = document.cookie.match(new RegExp(`(?:^|; )${name}=([^;]*)`));
  return match ? decodeURIComponent(match[1]) : null;
}

export function UserMenu() {
  const router = useRouter();
  const { data: session, status } = useSession();
  const [demoRole, setDemoRole] = useState<string>("contributor");
  const [isMockMode, setIsMockMode] = useState(false);

  useEffect(() => {
    const cookieRole = getCookie("admin-mock-role")?.toLowerCase();
    setIsMockMode(getCookie("admin-mock-mode") === "true");
    if (cookieRole && demoUsers[cookieRole]) {
      setDemoRole(cookieRole);
    }
  }, []);

  function clearCookie(name: string) {
    document.cookie = `${name}=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/; SameSite=Lax`;
  }

  async function handleSwitchRole() {
    await signOut({ redirect: false });
    clearCookie("admin-mock-role");
    clearCookie("admin-mock-mode");
    router.push("/login");
    router.refresh();
  }

  if (status === "loading") {
    return (
      <div className="flex items-center gap-2">
        <Skeleton className="h-8 w-8 rounded-full" />
        <Skeleton className="h-4 w-24 hidden sm:block" />
      </div>
    );
  }

  const user = isMockMode ? demoUsers[demoRole] : (session?.user ?? demoUsers[demoRole]);

  if (!user) {
    return null;
  }

  const role = user.role as string;
  const initials = user.name
    ?.split(" ")
    .map((n) => n[0])
    .join("")
    .toUpperCase() || "U";

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" className="relative h-8 w-8 rounded-full">
          <Avatar className="h-8 w-8">
            <AvatarImage src={user.image || ""} alt={user.name || "User"} />
            <AvatarFallback className="bg-[#005ea2] text-white">
              {initials}
            </AvatarFallback>
          </Avatar>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent className="w-56" align="end" forceMount>
        <DropdownMenuLabel className="font-normal">
          <div className="flex flex-col space-y-1">
            <p className="text-sm font-medium leading-none">{user.name}</p>
            <p className="text-xs leading-none text-muted-foreground">
              {user.email}
            </p>
            <Badge
              variant="secondary"
              className={cn("mt-2 w-fit text-xs", roleColors[role])}
            >
              {roleLabels[role] || role}
            </Badge>
          </div>
        </DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuItem asChild>
          <a href="#profile" className="cursor-pointer">
            Profile
          </a>
        </DropdownMenuItem>
        <DropdownMenuItem asChild>
          <a href="#settings" className="cursor-pointer">
            Settings
          </a>
        </DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuItem
          className="text-red-600 focus:text-red-600 cursor-pointer"
          onClick={handleSwitchRole}
        >
          Switch Role
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
