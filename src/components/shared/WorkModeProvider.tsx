"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { useSession } from "next-auth/react";
import type { Role } from "@/config/navigation";
import {
  getAllowedWorkModes,
  getDefaultWorkMode,
  getValidatedWorkMode,
  getWorkModeLandingPath,
  WORK_MODE_COOKIE,
} from "@/lib/work-modes";

type WorkModeContextValue = {
  authorityRole: Role;
  workMode: Role;
  allowedModes: Role[];
  selectWorkMode: (mode: Role) => void;
};

const WorkModeContext = createContext<WorkModeContextValue | null>(null);

function readWorkModeCookie(): string | null {
  const prefix = `${WORK_MODE_COOKIE}=`;
  const cookie = document.cookie.split("; ").find((value) => value.startsWith(prefix));
  return cookie ? decodeURIComponent(cookie.slice(prefix.length)) : null;
}

export function WorkModeProvider({ children }: { children: React.ReactNode }) {
  const { data: session } = useSession();
  const authorityRole = (session?.user?.role as Role | undefined) ?? "CONTRIBUTOR";
  const [workMode, setWorkMode] = useState<Role>(
    getDefaultWorkMode(authorityRole, session?.user?.id, session?.user?.email)
  );
  const allowedModes = getAllowedWorkModes(authorityRole, session?.user?.id, session?.user?.email);

  useEffect(() => {
    setWorkMode(
      getValidatedWorkMode(authorityRole, readWorkModeCookie(), session?.user?.id, session?.user?.email)
    );
  }, [authorityRole, session?.user?.id, session?.user?.email]);

  function selectWorkMode(mode: Role) {
    const validatedMode = getValidatedWorkMode(authorityRole, mode, session?.user?.id, session?.user?.email);
    document.cookie = `${WORK_MODE_COOKIE}=${encodeURIComponent(validatedMode)}; path=/; SameSite=Lax`;
    setWorkMode(validatedMode);
    window.location.assign(getWorkModeLandingPath(validatedMode));
  }

  return (
    <WorkModeContext.Provider value={{ authorityRole, workMode, allowedModes, selectWorkMode }}>
      {children}
    </WorkModeContext.Provider>
  );
}

export function useWorkMode(): WorkModeContextValue {
  const context = useContext(WorkModeContext);
  if (!context) {
    throw new Error("useWorkMode must be used within WorkModeProvider");
  }
  return context;
}