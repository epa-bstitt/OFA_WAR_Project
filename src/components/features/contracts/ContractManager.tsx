"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { Plus, Pencil, Trash2, ExternalLink, XCircle } from "lucide-react";
import type { MockContract } from "@/lib/mock-contracts";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { ContractsOutlookTable } from "./ContractsOutlookTable";

interface ContractManagerProps {
  initialContracts: MockContract[];
}

interface ContractFormState {
  contractName: string;
  category: string;
  cor: string;
  contractNumber: string;
  office: string;
  nextPeriodOfPerf: string;
  ultimateCompletionDate: string;
  co: string;
  cs: string;
  orderNumber: string;
}

const EMPTY_FORM: ContractFormState = {
  contractName: "",
  category: "Contract",
  cor: "",
  contractNumber: "",
  office: "",
  nextPeriodOfPerf: "",
  ultimateCompletionDate: "",
  co: "",
  cs: "",
  orderNumber: "",
};

function toFormState(contract: MockContract): ContractFormState {
  return {
    contractName: contract.contractName,
    category: contract.category,
    cor: contract.activeContract.cor,
    contractNumber: contract.activeContract.contractNumber,
    office: contract.activeContract.office,
    nextPeriodOfPerf: contract.activeContract.nextPeriodOfPerf,
    ultimateCompletionDate: contract.activeContract.ultimateCompletionDate,
    co: contract.activeContract.co,
    cs: contract.activeContract.cs,
    orderNumber: contract.activeContract.orderNumber,
  };
}

export function ContractManager({ initialContracts }: ContractManagerProps) {
  const [contracts, setContracts] = useState<MockContract[]>(initialContracts);
  const [selectedContract, setSelectedContract] = useState<MockContract | null>(null);
  const [editingContractId, setEditingContractId] = useState<string | null>(null);
  const [formState, setFormState] = useState<ContractFormState>(EMPTY_FORM);
  const [isSaving, setIsSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isEditMode = Boolean(editingContractId);

  const sortedContracts = useMemo(
    () => [...contracts].sort((a, b) => a.contractName.localeCompare(b.contractName)),
    [contracts]
  );

  function resetForm() {
    setEditingContractId(null);
    setFormState(EMPTY_FORM);
    setError(null);
  }

  function startCreate() {
    setSelectedContract(null);
    setEditingContractId(null);
    setFormState(EMPTY_FORM);
    setError(null);
  }

  function startEdit(contract: MockContract) {
    setEditingContractId(contract.id);
    setFormState(toFormState(contract));
    setError(null);
  }

  async function refreshContracts() {
    const response = await fetch("/api/contracts", { cache: "no-store" });
    const payload = await response.json();

    if (!response.ok) {
      throw new Error(payload?.error || "Failed to load contracts.");
    }

    setContracts(payload.contracts);
  }

  async function handleSubmit(event: React.FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setIsSaving(true);
    setError(null);

    try {
      const endpoint = editingContractId ? `/api/contracts/${editingContractId}` : "/api/contracts";
      const method = editingContractId ? "PUT" : "POST";

      const response = await fetch(endpoint, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formState),
      });

      const payload = await response.json();

      if (!response.ok) {
        throw new Error(payload?.error || "Failed to save contract.");
      }

      await refreshContracts();
      resetForm();
    } catch (submitError) {
      const message = submitError instanceof Error ? submitError.message : "Failed to save contract.";
      setError(message);
    } finally {
      setIsSaving(false);
    }
  }

  async function handleDelete(contractId: string) {
    const confirmed = window.confirm("Delete this contract? Existing WAR history will no longer be visible.");
    if (!confirmed) {
      return;
    }

    setIsSaving(true);
    setError(null);

    try {
      const response = await fetch(`/api/contracts/${contractId}`, {
        method: "DELETE",
      });

      const payload = await response.json();

      if (!response.ok) {
        throw new Error(payload?.error || "Failed to delete contract.");
      }

      await refreshContracts();

      if (selectedContract?.id === contractId) {
        setSelectedContract(null);
      }

      if (editingContractId === contractId) {
        resetForm();
      }
    } catch (deleteError) {
      const message = deleteError instanceof Error ? deleteError.message : "Failed to delete contract.";
      setError(message);
    } finally {
      setIsSaving(false);
    }
  }

  return (
    <div className="space-y-6">
      <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle>Contracts</CardTitle>
            <Button type="button" variant="outline" size="sm" onClick={startCreate}>
              <Plus className="mr-1 h-3.5 w-3.5" />
              New Contract
            </Button>
          </CardHeader>
          <CardContent className="space-y-3">
            {sortedContracts.map((contract) => (
              <div
                key={contract.id}
                className="flex items-center justify-between rounded-md border border-slate-200 p-3"
              >
                <button
                  type="button"
                  onClick={() => setSelectedContract(contract)}
                  className="text-left text-sm font-medium text-[#005ea2] hover:underline"
                >
                  {contract.contractName}
                </button>
                <div className="flex items-center gap-2">
                  <Link href={`/contracts/${contract.id}/wars`}>
                    <Button variant="outline" size="sm">
                      <ExternalLink className="mr-1 h-3.5 w-3.5" />
                      WAR entries
                    </Button>
                  </Link>
                  <Button type="button" variant="ghost" size="sm" onClick={() => startEdit(contract)}>
                    <Pencil className="mr-1 h-3.5 w-3.5" />
                    Edit
                  </Button>
                  <Button
                    type="button"
                    variant="ghost"
                    size="sm"
                    onClick={() => handleDelete(contract.id)}
                    disabled={isSaving}
                  >
                    <Trash2 className="mr-1 h-3.5 w-3.5" />
                    Delete
                  </Button>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{isEditMode ? "Manage Contracts" : "Create New Contract"}</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-3">
              <div className="space-y-2">
                <Label htmlFor="contractName">Contract Name</Label>
                <Input
                  id="contractName"
                  value={formState.contractName}
                  onChange={(event) => setFormState((prev) => ({ ...prev, contractName: event.target.value }))}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="category">Category</Label>
                <Input
                  id="category"
                  value={formState.category}
                  onChange={(event) => setFormState((prev) => ({ ...prev, category: event.target.value }))}
                />
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="cor">COR</Label>
                  <Input
                    id="cor"
                    value={formState.cor}
                    onChange={(event) => setFormState((prev) => ({ ...prev, cor: event.target.value }))}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="contractNumber">Contract Number</Label>
                  <Input
                    id="contractNumber"
                    value={formState.contractNumber}
                    onChange={(event) =>
                      setFormState((prev) => ({ ...prev, contractNumber: event.target.value }))
                    }
                  />
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="office">Office</Label>
                  <Input
                    id="office"
                    value={formState.office}
                    onChange={(event) => setFormState((prev) => ({ ...prev, office: event.target.value }))}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="nextPeriodOfPerf">Next Period of Perf.</Label>
                  <Input
                    id="nextPeriodOfPerf"
                    value={formState.nextPeriodOfPerf}
                    onChange={(event) =>
                      setFormState((prev) => ({ ...prev, nextPeriodOfPerf: event.target.value }))
                    }
                  />
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="ultimateCompletionDate">Ultimate Completion Date</Label>
                  <Input
                    id="ultimateCompletionDate"
                    value={formState.ultimateCompletionDate}
                    onChange={(event) =>
                      setFormState((prev) => ({ ...prev, ultimateCompletionDate: event.target.value }))
                    }
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="orderNumber">Order Number</Label>
                  <Input
                    id="orderNumber"
                    value={formState.orderNumber}
                    onChange={(event) =>
                      setFormState((prev) => ({ ...prev, orderNumber: event.target.value }))
                    }
                  />
                </div>
              </div>

              <div className="grid gap-3 sm:grid-cols-2">
                <div className="space-y-2">
                  <Label htmlFor="co">CO</Label>
                  <Input
                    id="co"
                    value={formState.co}
                    onChange={(event) => setFormState((prev) => ({ ...prev, co: event.target.value }))}
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="cs">CS</Label>
                  <Input
                    id="cs"
                    value={formState.cs}
                    onChange={(event) => setFormState((prev) => ({ ...prev, cs: event.target.value }))}
                  />
                </div>
              </div>

              {error && (
                <p className="text-sm text-rose-600">{error}</p>
              )}

              <div className="flex flex-wrap items-center gap-2 pt-2">
                <Button type="submit" disabled={isSaving}>
                  <Plus className="mr-2 h-4 w-4" />
                  {isEditMode ? "Update Contract" : "Create Contract"}
                </Button>
                {isEditMode && (
                  <Button type="button" variant="outline" onClick={resetForm}>
                    <XCircle className="mr-2 h-4 w-4" />
                    Cancel Edit
                  </Button>
                )}
              </div>
            </form>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader className="flex flex-row items-center justify-between">
          <CardTitle>Current and Active Contracts/Purchase Order Outlook</CardTitle>
          <Link href="/contracts/outlook">
            <Button variant="outline">Open Full View</Button>
          </Link>
        </CardHeader>
        <CardContent>
          <ContractsOutlookTable contracts={sortedContracts} />
        </CardContent>
      </Card>

      <Dialog open={Boolean(selectedContract)} onOpenChange={(open) => !open && setSelectedContract(null)}>
        {selectedContract && (
          <DialogContent>
            <DialogHeader>
              <DialogTitle>{selectedContract.contractName}</DialogTitle>
              <DialogDescription>High-level contract information.</DialogDescription>
            </DialogHeader>
            <div className="grid gap-3 text-sm sm:grid-cols-2">
              <p><span className="font-semibold">COR:</span> {selectedContract.activeContract.cor || "-"}</p>
              <p><span className="font-semibold">Contract Number:</span> {selectedContract.activeContract.contractNumber || "-"}</p>
              <p><span className="font-semibold">Office:</span> {selectedContract.activeContract.office || "-"}</p>
              <p><span className="font-semibold">Next Period of Perf.:</span> {selectedContract.activeContract.nextPeriodOfPerf || "-"}</p>
              <p><span className="font-semibold">Ultimate Completion Date:</span> {selectedContract.activeContract.ultimateCompletionDate || "-"}</p>
              <p><span className="font-semibold">Order Number:</span> {selectedContract.activeContract.orderNumber || "-"}</p>
              <p><span className="font-semibold">CO:</span> {selectedContract.activeContract.co || "-"}</p>
              <p><span className="font-semibold">CS:</span> {selectedContract.activeContract.cs || "-"}</p>
            </div>
            <DialogFooter>
              <Link href={`/contracts/${selectedContract.id}/wars`}>
                <Button variant="outline">View WAR Entries</Button>
              </Link>
              <Button type="button" onClick={() => setSelectedContract(null)}>Close</Button>
            </DialogFooter>
          </DialogContent>
        )}
      </Dialog>
    </div>
  );
}
