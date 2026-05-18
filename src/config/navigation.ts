import {
  LayoutDashboard,
  Inbox,
  Settings,
  CheckCircle,
  Users,
  FileSearch,
} from "lucide-react";
import { LucideIcon } from "lucide-react";

export interface NavItem {
  label: string;
  href: string;
  icon: LucideIcon;
}

export type Role = "CONTRIBUTOR" | "AGGREGATOR" | "PROGRAM_OVERSEER" | "ADMINISTRATOR";

export const NAV_ITEMS: Record<Role, NavItem[]> = {
  CONTRIBUTOR: [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
  ],
  AGGREGATOR: [
    { label: "Dashboard", href: "/review", icon: Inbox },
    { label: "Prompts", href: "/prompts", icon: Settings },
  ],
  PROGRAM_OVERSEER: [
    { label: "WAR Review", href: "/approve", icon: CheckCircle },
    { label: "Settings", href: "/settings", icon: Settings },
  ],
  ADMINISTRATOR: [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { label: "Users", href: "/admin/users", icon: Users },
    { label: "Audit Log", href: "/admin/audit", icon: FileSearch },
    { label: "Settings", href: "/admin/settings", icon: Settings },
  ],
};

export const ROLE_HIERARCHY: Record<Role, number> = {
  ADMINISTRATOR: 4,
  PROGRAM_OVERSEER: 3,
  AGGREGATOR: 2,
  CONTRIBUTOR: 1,
};

export function hasMinimumRole(userRole: Role, minimumRole: Role): boolean {
  const userLevel = ROLE_HIERARCHY[userRole] || 0;
  const minLevel = ROLE_HIERARCHY[minimumRole] || 0;
  return userLevel >= minLevel;
}
