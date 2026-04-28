import {
  LayoutDashboard,
  FileText,
  List,
  Inbox,
  Settings,
  CheckCircle,
  BarChart,
  Users,
  FileSearch,
  Contact,
  Table2,
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
    { label: "Submit WAR", href: "/submit", icon: FileText },
    { label: "My Submissions", href: "/submissions", icon: List },
  ],
  AGGREGATOR: [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { label: "WAR Review", href: "/review", icon: Inbox },
    { label: "Contracts", href: "/contracts", icon: Contact },
    {
      label: "Current and Active Contracts/Purchase Order Outlook",
      href: "/contracts/outlook",
      icon: Table2,
    },
    { label: "Prompts", href: "/prompts", icon: Settings },
  ],
  PROGRAM_OVERSEER: [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { label: "WAR Review", href: "/approve", icon: CheckCircle },
    { label: "Contracts", href: "/contracts", icon: Contact },
    {
      label: "Current and Active Contracts/Purchase Order Outlook",
      href: "/contracts/outlook",
      icon: Table2,
    },
    { label: "Analytics", href: "/analytics", icon: BarChart },
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
