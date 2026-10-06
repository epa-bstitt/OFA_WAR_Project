"use client";

import { signOut, useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { cn } from "@/lib/utils";
import type { Role } from "@/config/navigation";
import { WORK_MODE_COOKIE, WORK_MODE_LABELS, isJakeBejaUser } from "@/lib/work-modes";
import { useWorkMode } from "./WorkModeProvider";

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

export function UserMenu() {
  const router = useRouter();
  const { data: session, status } = useSession();
  const { workMode, allowedModes, selectWorkMode } = useWorkMode();

  async function handleSignOut() {
    if (isJakeBejaUser(user?.id, user?.email)) {
      document.cookie = `${WORK_MODE_COOKIE}=; Max-Age=0; path=/; SameSite=Lax`;
    }
    await signOut({ redirect: false });
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

  const user = session?.user;

  if (!user) {
    return null;
  }

  const role = workMode;
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
        {allowedModes.length > 1 && (
          <>
            <DropdownMenuSeparator />
            <DropdownMenuLabel className="text-xs text-muted-foreground">Work mode</DropdownMenuLabel>
            <DropdownMenuRadioGroup value={workMode} onValueChange={(value) => selectWorkMode(value as Role)}>
              {allowedModes.map((mode) => (
                <DropdownMenuRadioItem key={mode} value={mode}>
                  {WORK_MODE_LABELS[mode]}
                </DropdownMenuRadioItem>
              ))}
            </DropdownMenuRadioGroup>
          </>
        )}
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
          onClick={handleSignOut}
        >
          Sign out
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
