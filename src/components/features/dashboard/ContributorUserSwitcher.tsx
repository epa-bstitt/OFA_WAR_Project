"use client";

import { useMemo } from "react";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface SwitcherUser {
  id: string;
  name: string | null;
  email: string;
}

interface ContributorUserSwitcherProps {
  users: SwitcherUser[];
  selectedUserId: string;
}

export function ContributorUserSwitcher({ users, selectedUserId }: ContributorUserSwitcherProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const userOptions = useMemo(
    () => users.map((user) => ({
      id: user.id,
      label: user.name?.trim() || user.email,
      secondary: user.email,
    })),
    [users]
  );

  const onChangeUser = (userId: string) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set("asUser", userId);
    router.push(`${pathname}?${params.toString()}`);
  };

  return (
    <Card>
      <CardContent className="py-4">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p className="text-sm font-medium text-slate-900">Contributor View</p>
            <p className="text-xs text-slate-500">Switch the card data to another contributor.</p>
          </div>

          <div className="w-full sm:w-[320px]">
            <Select value={selectedUserId} onValueChange={onChangeUser}>
              <SelectTrigger>
                <SelectValue placeholder="Select contributor" />
              </SelectTrigger>
              <SelectContent>
                {userOptions.map((user) => (
                  <SelectItem key={user.id} value={user.id}>
                    <div className="flex flex-col">
                      <span>{user.label}</span>
                      <span className="text-xs text-muted-foreground">{user.secondary}</span>
                    </div>
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
