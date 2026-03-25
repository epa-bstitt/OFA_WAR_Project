"use client";

import { useSession } from "next-auth/react";
import { usePathname } from "next/navigation";
import Link from "next/link";
import { cn } from "@/lib/utils";
import { NAV_ITEMS, Role } from "@/config/navigation";

interface SidebarProps {
  className?: string;
}

export function Sidebar({ className }: SidebarProps) {
  const { data: session } = useSession();
  const pathname = usePathname();

  const userRole = (session?.user?.role as Role) || "CONTRIBUTOR";
  const navItems = NAV_ITEMS[userRole] || [];

  return (
    <aside
      className={cn(
        "w-60 bg-slate-50 border-r flex flex-col h-[calc(100vh-3.5rem)] sticky top-14",
        className
      )}
    >
      <nav className="flex-1 p-4 space-y-1 overflow-y-auto">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive =
            pathname === item.href || pathname?.startsWith(item.href + "/");

          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 px-3 py-2 rounded-md text-sm font-medium transition-colors",
                isActive
                  ? "bg-[#005ea2] text-white"
                  : "text-slate-600 hover:bg-slate-100 hover:text-slate-900"
              )}
            >
              <Icon className="h-4 w-4" />
              {item.label}
            </Link>
          );
        })}
      </nav>

      {/* Sidebar Footer */}
      <div className="p-4 border-t">
        <p className="text-xs text-slate-500">
          EPA Business Platform v1.0
        </p>
      </div>
    </aside>
  );
}
