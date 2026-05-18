"use client";

import { FormEvent, useEffect, useMemo, useState } from "react";
import { useSession } from "next-auth/react";
import { usePathname, useRouter } from "next/navigation";
import Link from "next/link";
import { Search } from "lucide-react";
import { cn } from "@/lib/utils";
import { NAV_ITEMS, Role } from "@/config/navigation";
import type { MockContract } from "@/lib/mock-contracts";

interface SidebarProps {
  className?: string;
}

export function Sidebar({ className }: SidebarProps) {
  const { data: session } = useSession();
  const pathname = usePathname();
  const router = useRouter();
  const [searchQuery, setSearchQuery] = useState("");
  const [contracts, setContracts] = useState<MockContract[]>([]);
  const [isLoadingContracts, setIsLoadingContracts] = useState(false);

  const userRole = (session?.user?.role as Role) || "CONTRIBUTOR";
  const navItems = NAV_ITEMS[userRole] || [];
  const canSearchContracts = navItems.some((item) => item.href.startsWith("/contracts"));

  useEffect(() => {
    if (!canSearchContracts) {
      return;
    }

    let isMounted = true;

    async function loadContracts() {
      setIsLoadingContracts(true);

      try {
        const response = await fetch("/api/contracts", { cache: "no-store" });
        if (!response.ok) {
          return;
        }

        const payload = await response.json();
        const fetchedContracts = Array.isArray(payload?.contracts) ? payload.contracts : [];

        if (isMounted) {
          setContracts(fetchedContracts);
        }
      } finally {
        if (isMounted) {
          setIsLoadingContracts(false);
        }
      }
    }

    void loadContracts();

    return () => {
      isMounted = false;
    };
  }, [canSearchContracts]);

  const normalizedSearch = searchQuery.trim().toLowerCase();
  const filteredContracts = useMemo(() => {
    if (!normalizedSearch) {
      return [];
    }

    return contracts
      .filter((contract) => {
        const haystack = [
          contract.contractName,
          contract.category,
          contract.activeContract.cor,
          contract.activeContract.contractNumber,
          contract.activeContract.office,
        ]
          .join(" ")
          .toLowerCase();

        return haystack.includes(normalizedSearch);
      })
      .slice(0, 6);
  }, [contracts, normalizedSearch]);

  function handleSearchSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    if (!normalizedSearch) {
      return;
    }

    if (filteredContracts.length > 0) {
      router.push(`/contracts/${filteredContracts[0].id}/wars`);
      setSearchQuery("");
      return;
    }

    router.push("/contracts");
  }

  return (
    <aside
      className={cn(
        "w-60 bg-slate-50 border-r flex flex-col h-[calc(100vh-3.5rem)] sticky top-14",
        className
      )}
    >
      <nav className="flex-1 p-4 space-y-1 overflow-y-auto">
        {canSearchContracts && (
          <div className="mb-3">
            <p className="mb-2 text-xs font-semibold uppercase tracking-wide text-slate-500">
              Global Contract Search
            </p>

            <form onSubmit={handleSearchSubmit} className="relative">
              <Search className="pointer-events-none absolute left-2.5 top-2.5 h-4 w-4 text-slate-400" />
              <input
                type="search"
                value={searchQuery}
                onChange={(event) => setSearchQuery(event.target.value)}
                placeholder="Search contracts, COR, office..."
                className="h-9 w-full rounded-md border border-slate-200 bg-white pl-8 pr-3 text-sm text-slate-700 shadow-sm outline-none transition focus:border-[#005ea2] focus:ring-2 focus:ring-[#005ea2]/20"
              />
            </form>

            {normalizedSearch && (
              <div className="mt-2 space-y-1 rounded-md border border-slate-200 bg-white p-2 shadow-sm">
                {isLoadingContracts && (
                  <p className="px-1 py-1 text-xs text-slate-500">Searching contracts...</p>
                )}

                {!isLoadingContracts && filteredContracts.length === 0 && (
                  <p className="px-1 py-1 text-xs text-slate-500">No matching contracts found.</p>
                )}

                {!isLoadingContracts &&
                  filteredContracts.map((contract) => (
                    <Link
                      key={contract.id}
                      href={`/contracts/${contract.id}/wars`}
                      className="block rounded px-2 py-1.5 text-xs text-slate-700 transition-colors hover:bg-slate-100"
                    >
                      <p className="truncate font-medium text-slate-800">{contract.contractName}</p>
                      <p className="truncate text-[11px] text-slate-500">
                        {contract.activeContract.contractNumber || "No contract number"}
                      </p>
                    </Link>
                  ))}
              </div>
            )}
          </div>
        )}

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

      {userRole !== "CONTRIBUTOR" ? (
        <div className="border-t p-4">
          <p className="text-xs text-slate-500">EPA Business Platform v1.0</p>
        </div>
      ) : null}
    </aside>
  );
}
