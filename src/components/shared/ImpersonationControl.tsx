"use client";

import { useState } from "react";
import { useSession } from "next-auth/react";
import { UserRoundSearch } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { listImpersonationTargets, startImpersonation, stopImpersonation } from "@/app/actions/admin/impersonation";

type Target = Awaited<ReturnType<typeof listImpersonationTargets>>[number];

export function ImpersonationControl() {
  const { data: session } = useSession();
  const [open, setOpen] = useState(false);
  const [targets, setTargets] = useState<Target[]>([]);
  const [search, setSearch] = useState("");
  const [busy, setBusy] = useState(false);
  const impersonatedBy = session?.user?.impersonatedBy;

  async function openPicker() {
    setOpen(true);
    setBusy(true);
    try {
      setTargets(await listImpersonationTargets());
    } catch {
      toast.error("Could not load users.");
    } finally {
      setBusy(false);
    }
  }

  async function switchTo(targetId: string) {
    setBusy(true);
    try {
      await startImpersonation(targetId);
      window.location.assign("/dashboard");
    } catch {
      toast.error("Could not switch users.");
      setBusy(false);
    }
  }

  async function returnToAdmin() {
    setBusy(true);
    try {
      await stopImpersonation();
      window.location.assign("/dashboard");
    } catch {
      toast.error("Could not return to your admin account.");
      setBusy(false);
    }
  }

  if (impersonatedBy) {
    return (
      <div className="flex flex-wrap items-center justify-between gap-2 border-b border-amber-300 bg-amber-50 px-6 py-2 text-sm text-amber-950" role="status">
        <span>Viewing as {session?.user?.name || session?.user?.email} ({session?.user?.role?.replaceAll("_", " ")}) on behalf of {impersonatedBy.name || impersonatedBy.email}</span>
        <Button type="button" size="sm" variant="outline" disabled={busy} onClick={returnToAdmin}>Return to admin</Button>
      </div>
    );
  }

  if (session?.user?.role !== "ADMINISTRATOR") return null;

  const matches = targets.filter((target) =>
    `${target.name ?? ""} ${target.email}`.toLowerCase().includes(search.trim().toLowerCase())
  );

  return (
    <>
      <div className="flex justify-end border-b px-6 py-2">
        <Button type="button" size="sm" variant="outline" onClick={openPicker}>
          <UserRoundSearch className="mr-2 h-4 w-4" /> View as user
        </Button>
      </div>
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="max-w-md">
          <DialogHeader><DialogTitle>View as user</DialogTitle></DialogHeader>
          <Input aria-label="Search users" placeholder="Search name or email" value={search} onChange={(event) => setSearch(event.target.value)} />
          <div className="max-h-72 space-y-1 overflow-y-auto">
            {busy ? <p className="text-sm text-muted-foreground">Loading users...</p> : matches.map((target) => (
              <button key={target.id} type="button" disabled={busy} onClick={() => switchTo(target.id)} className="flex w-full flex-col rounded-sm px-3 py-2 text-left hover:bg-accent focus-visible:bg-accent focus-visible:outline-none">
                <span className="text-sm font-medium">{target.name || target.email}</span>
                <span className="text-xs text-muted-foreground">{target.email} - {target.role.replaceAll("_", " ")}</span>
              </button>
            ))}
            {!busy && matches.length === 0 ? <p className="text-sm text-muted-foreground">No users found.</p> : null}
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}