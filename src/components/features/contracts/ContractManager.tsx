"use client";

import { useMemo, useState } from "react";
import Link from "next/link";
import { ChevronDown, ExternalLink, Pencil, Plus, Trash2, XCircle } from "lucide-react";
import { toast } from "sonner";
import { MOCK_CONTRACT_ASSIGNEES, type MockContract } from "@/lib/mock-contracts";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ContractsOutlookTable } from "./ContractsOutlookTable";
import { NewAwardsRecompetesTable } from "./NewAwardsRecompetesTable";

interface ContractManagerProps {
  initialContracts: MockContract[];
  hideFilters?: boolean;
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

type FormMode = "outlook" | "recompetes";

const RECOMPETES_CATEGORY = "New Awards and Recompetes";
const LEGACY_CATEGORY = "Legacy Contracts";
const OUTLOOK_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";

const TAB_LABELS: Record<"outlook" | "recompetes" | "legacy", string> = {
  outlook: "Current and Active Contracts/Purchase Order Outlook",
  recompetes: "New Awards and Recompetes",
  legacy: "Legacy Contracts",
};

interface AssigneeOption {
  value: string;
  label: string;
  email: string;
}

const INITIAL_ASSIGNEE_OPTIONS: AssigneeOption[] = [
  ...Object.entries(MOCK_CONTRACT_ASSIGNEES).map(([value, assignee]) => ({
    value,
    label: assignee.name,
    email: assignee.email,
  })),
];

function getCategoryForTab(tab: "outlook" | "recompetes" | "legacy") {
  if (tab === "recompetes") {
    return RECOMPETES_CATEGORY;
  }

  if (tab === "legacy") {
    return LEGACY_CATEGORY;
  }

  return OUTLOOK_CATEGORY;
}

function getTabLabel(tab: "outlook" | "recompetes" | "legacy") {
  return TAB_LABELS[tab];
}

function createAssigneeId(name: string, email: string) {
  const base = email.trim() || name.trim();
  return base
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 40);
}

function getAssigneeLabel(assigneeIds: string[], assigneeOptions: AssigneeOption[]) {
  if (assigneeIds.length === 0) {
    return "Unassigned";
  }

  const labels = assigneeIds
    .map((assigneeId) => assigneeOptions.find((option) => option.value === assigneeId)?.label)
    .filter((label): label is string => Boolean(label));

  return labels.length > 0 ? labels.join(", ") : "Unassigned";
}

function getAssigneeDetails(assigneeIds: string[], assigneeOptions: AssigneeOption[]) {
  return assigneeIds
    .map((assigneeId) => {
      const assignee = assigneeOptions.find((option) => option.value === assigneeId);
      if (!assignee) {
        return null;
      }

      return {
        name: assignee.label,
        email: assignee.email,
      };
    })
    .filter((item): item is { name: string; email: string } => Boolean(item));
}

function toTimestamp(value: string) {
  const trimmed = value.trim();
  if (!trimmed) {
    return Number.NaN;
  }

  const parsed = new Date(trimmed).getTime();
  return Number.isNaN(parsed) ? Number.NaN : parsed;
}

const EMPTY_FORM: ContractFormState = {
  contractName: "",
  category: OUTLOOK_CATEGORY,
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

export function ContractManager({ initialContracts, hideFilters = false }: ContractManagerProps) {
  const [contracts, setContracts] = useState<MockContract[]>(initialContracts);
  const [activeTab, setActiveTab] = useState("recompetes");
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [selectedContract, setSelectedContract] = useState<MockContract | null>(null);
  const [editingContractId, setEditingContractId] = useState<string | null>(null);
  const [formMode, setFormMode] = useState<FormMode>("outlook");
  const [formState, setFormState] = useState<ContractFormState>(EMPTY_FORM);
  const [formAssigneeIds, setFormAssigneeIds] = useState<string[]>([]);
  const [assigneeOptions, setAssigneeOptions] = useState<AssigneeOption[]>(INITIAL_ASSIGNEE_OPTIONS);
  const [assigneeSearch, setAssigneeSearch] = useState("");
  const [isAssigneeDropdownOpen, setIsAssigneeDropdownOpen] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [fieldErrors, setFieldErrors] = useState<Partial<Record<keyof ContractFormState, string>>>({});
  const [searchTerm, setSearchTerm] = useState("");
  const [assignmentFilter, setAssignmentFilter] = useState<"all" | "assigned" | "unassigned">("all");
  const [dueFilter, setDueFilter] = useState<"all" | "dueSoon">("all");
  const [sortBy, setSortBy] = useState<"name" | "endDate" | "assignee">("name");
  const [sortDirection, setSortDirection] = useState<"asc" | "desc">("asc");

  const isEditMode = Boolean(editingContractId);

  const sortedContracts = useMemo(() => {
    const normalizedSearch = searchTerm.trim().toLowerCase();
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const dueSoonLimit = new Date(today);
    dueSoonLimit.setDate(today.getDate() + 30);

    const filtered = contracts.filter((contract) => {
      const assigneeLabel = getAssigneeLabel(contract.assigneeIds ?? [], assigneeOptions).toLowerCase();

      if (normalizedSearch) {
        const text = [
          contract.contractName,
          contract.activeContract.contractNumber,
          contract.activeContract.office,
          assigneeLabel,
        ]
          .join(" ")
          .toLowerCase();

        if (!text.includes(normalizedSearch)) {
          return false;
        }
      }

      if (assignmentFilter === "assigned" && (contract.assigneeIds ?? []).length === 0) {
        return false;
      }

      if (assignmentFilter === "unassigned" && (contract.assigneeIds ?? []).length > 0) {
        return false;
      }

      if (dueFilter === "dueSoon") {
        const endDate = toTimestamp(contract.activeContract.ultimateCompletionDate);
        if (Number.isNaN(endDate) || endDate < today.getTime() || endDate > dueSoonLimit.getTime()) {
          return false;
        }
      }

      return true;
    });

    const sorted = [...filtered].sort((a, b) => {
      if (sortBy === "assignee") {
        return getAssigneeLabel(a.assigneeIds ?? [], assigneeOptions).localeCompare(
          getAssigneeLabel(b.assigneeIds ?? [], assigneeOptions)
        );
      }

      if (sortBy === "endDate") {
        const aDate = toTimestamp(a.activeContract.ultimateCompletionDate);
        const bDate = toTimestamp(b.activeContract.ultimateCompletionDate);

        if (Number.isNaN(aDate) && Number.isNaN(bDate)) {
          return a.contractName.localeCompare(b.contractName);
        }

        if (Number.isNaN(aDate)) {
          return 1;
        }

        if (Number.isNaN(bDate)) {
          return -1;
        }

        return aDate - bDate;
      }

      return a.contractName.localeCompare(b.contractName);
    });

    return sortDirection === "asc" ? sorted : sorted.reverse();
  }, [contracts, searchTerm, assignmentFilter, dueFilter, sortBy, sortDirection, assigneeOptions]);

  const hasActiveFilters =
    searchTerm.trim().length > 0 ||
    assignmentFilter !== "all" ||
    dueFilter !== "all" ||
    sortBy !== "name" ||
    sortDirection !== "asc";

  const filteredAssigneeOptions = useMemo(() => {
    const normalizedSearch = assigneeSearch.trim().toLowerCase();

    if (!normalizedSearch) {
      return assigneeOptions;
    }

    return assigneeOptions.filter((option) =>
      `${option.label} ${option.email}`.toLowerCase().includes(normalizedSearch)
    );
  }, [assigneeOptions, assigneeSearch]);

  const availableAssigneeOptions = useMemo(
    () => filteredAssigneeOptions.filter((option) => !formAssigneeIds.includes(option.value)),
    [filteredAssigneeOptions, formAssigneeIds]
  );

  const outlookContracts = useMemo(
    () =>
      sortedContracts.filter(
        (contract) =>
          contract.category !== RECOMPETES_CATEGORY && contract.category !== LEGACY_CATEGORY
      ),
    [sortedContracts]
  );

  const recompeteContracts = useMemo(
    () => sortedContracts.filter((contract) => contract.category === RECOMPETES_CATEGORY),
    [sortedContracts]
  );

  const legacyContracts = useMemo(
    () => sortedContracts.filter((contract) => contract.category === LEGACY_CATEGORY),
    [sortedContracts]
  );

  function resetForm() {
    setEditingContractId(null);
    setFormState(EMPTY_FORM);
    setFormAssigneeIds([]);
    setAssigneeSearch("");
    setIsAssigneeDropdownOpen(false);
    setFieldErrors({});
    setError(null);
  }

  function startCreate() {
    const nextMode: FormMode = activeTab === "recompetes" ? "recompetes" : "outlook";
    const createTab: "outlook" | "recompetes" | "legacy" =
      activeTab === "legacy" ? "legacy" : activeTab === "recompetes" ? "recompetes" : "outlook";
    setSelectedContract(null);
    setEditingContractId(null);
    setFormMode(nextMode);
    setFormState({
      ...EMPTY_FORM,
      category: getCategoryForTab(createTab),
    });
    setFormAssigneeIds([]);
    setAssigneeSearch("");
    setIsAssigneeDropdownOpen(false);
    setFieldErrors({});
    setError(null);
    setIsCreateDialogOpen(true);
  }

  function startEdit(contract: MockContract, mode: FormMode = "outlook") {
    setEditingContractId(contract.id);
    setFormMode(mode);
    setFormState(toFormState(contract));
    setFormAssigneeIds(contract.assigneeIds ?? []);
    setAssigneeSearch("");
    setIsAssigneeDropdownOpen(false);
    setFieldErrors({});
    setError(null);
  }

  function updateFormField(field: keyof ContractFormState, value: string) {
    setFormState((prev) => ({ ...prev, [field]: value }));
    setFieldErrors((prev) => {
      if (!prev[field]) {
        return prev;
      }

      const next = { ...prev };
      delete next[field];
      return next;
    });
  }

  function isAcceptedDateInput(value: string) {
    const trimmed = value.trim();
    if (!trimmed) {
      return true;
    }

    const slashDate = /^\d{1,2}\/\d{1,2}(\/\d{2,4})?$/;
    const isoDate = /^\d{4}-\d{2}-\d{2}$/;
    return slashDate.test(trimmed) || isoDate.test(trimmed);
  }

  function validateForm(mode: FormMode): Partial<Record<keyof ContractFormState, string>> {
    const nextErrors: Partial<Record<keyof ContractFormState, string>> = {};

    if (!isAcceptedDateInput(formState.nextPeriodOfPerf)) {
      nextErrors.nextPeriodOfPerf = "Use MM/DD or YYYY-MM-DD format.";
    }

    if (!isAcceptedDateInput(formState.ultimateCompletionDate)) {
      nextErrors.ultimateCompletionDate = "Use MM/DD or YYYY-MM-DD format.";
    }

    return nextErrors;
  }

  function addAssigneeToContract(assigneeId: string) {
    if (!assigneeId) {
      return;
    }

    setFormAssigneeIds((prev) => {
      if (prev.includes(assigneeId)) {
        return prev;
      }

      return [...prev, assigneeId];
    });
    setAssigneeSearch("");
    setIsAssigneeDropdownOpen(false);
  }

  function removeAssigneeFromContract(assigneeId: string) {
    setFormAssigneeIds((prev) => prev.filter((id) => id !== assigneeId));
  }

  function addAssigneeFromSearch() {
    const trimmedSearch = assigneeSearch.trim();
    if (!trimmedSearch) {
      setIsAssigneeDropdownOpen(false);
      setError("Type a person name or email first.");
      toast.error("Type a person name or email first.");
      return;
    }

    const matchedOption = availableAssigneeOptions[0];
    if (matchedOption) {
      addAssigneeToContract(matchedOption.value);
      setError(null);
      toast.success(`${matchedOption.label} added to the contract.`);
      return;
    }

    const existingOption = assigneeOptions.find(
      (option) =>
        option.label.toLowerCase() === trimmedSearch.toLowerCase() ||
        option.email.toLowerCase() === trimmedSearch.toLowerCase()
    );

    if (existingOption) {
      addAssigneeToContract(existingOption.value);
      setError(null);
      toast.success(`${existingOption.label} added to the contract.`);
      return;
    }

    const nextOption: AssigneeOption = {
      value: createAssigneeId(trimmedSearch, trimmedSearch.includes("@") ? trimmedSearch : ""),
      label: trimmedSearch,
      email: trimmedSearch.includes("@") ? trimmedSearch : "",
    };

    setAssigneeOptions((prev) => {
      if (prev.some((option) => option.value === nextOption.value)) {
        return prev;
      }

      return [...prev, nextOption];
    });
    addAssigneeToContract(nextOption.value);
    setError(null);
    toast.success(`${nextOption.label} added to the contract.`);
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
    const validationErrors = validateForm(formMode);
    if (Object.keys(validationErrors).length > 0) {
      setFieldErrors(validationErrors);
      setError("Please fix highlighted fields before saving.");
      toast.error("Please fix highlighted fields before saving.");
      return;
    }

    setIsSaving(true);
    setError(null);
    const wasEditMode = Boolean(editingContractId);

    try {
      const endpoint = editingContractId ? `/api/contracts/${editingContractId}` : "/api/contracts";
      const method = editingContractId ? "PUT" : "POST";
      const editingContract = editingContractId
        ? contracts.find((contract) => contract.id === editingContractId)
        : null;
      const category = editingContract ? editingContract.category : formState.category;

      const response = await fetch(endpoint, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          ...formState,
          category,
          assigneeIds: formAssigneeIds,
        }),
      });

      const payload = await response.json();

      if (!response.ok) {
        throw new Error(payload?.error || "Failed to save contract.");
      }

      await refreshContracts();
      resetForm();

      if (!wasEditMode) {
        setIsCreateDialogOpen(false);
      }

      toast.success(wasEditMode ? "Contract updated successfully." : "Contract created successfully.");
    } catch (submitError) {
      const message = submitError instanceof Error ? submitError.message : "Failed to save contract.";
      setError(message);
      toast.error(message);
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

      toast.success("Contract deleted successfully.");

    } catch (deleteError) {
      const message = deleteError instanceof Error ? deleteError.message : "Failed to delete contract.";
      setError(message);
      toast.error(message);
    } finally {
      setIsSaving(false);
    }
  }

  async function handleMove(contractId: string, targetTab: "outlook" | "recompetes" | "legacy") {
    const contract = contracts.find((item) => item.id === contractId);
    if (!contract) {
      return;
    }

    const targetCategory = getCategoryForTab(targetTab);

    setIsSaving(true);
    setError(null);

    try {
      const response = await fetch(`/api/contracts/${contractId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contractName: contract.contractName,
          cor: contract.activeContract.cor,
          contractNumber: contract.activeContract.contractNumber,
          office: contract.activeContract.office,
          nextPeriodOfPerf: contract.activeContract.nextPeriodOfPerf,
          ultimateCompletionDate: contract.activeContract.ultimateCompletionDate,
          co: contract.activeContract.co,
          cs: contract.activeContract.cs,
          orderNumber: contract.activeContract.orderNumber,
          category: targetCategory,
        }),
      });

      const payload = await response.json();
      if (!response.ok) {
        throw new Error(payload?.error || "Failed to move contract.");
      }

      await refreshContracts();
      setActiveTab(targetTab);
      toast.success(`Contract moved to ${getTabLabel(targetTab)}.`);
    } catch (moveError) {
      const message = moveError instanceof Error ? moveError.message : "Failed to move contract.";
      setError(message);
      toast.error(message);
    } finally {
      setIsSaving(false);
    }
  }

  function getMoveTargets(currentTab: "outlook" | "recompetes" | "legacy") {
    const allTargets: Array<{ value: "outlook" | "recompetes" | "legacy"; label: string }> = [
      {
        value: "outlook",
        label: "Current and Active Contracts/Purchase Order Outlook",
      },
      {
        value: "recompetes",
        label: "New Awards and Recompetes",
      },
      {
        value: "legacy",
        label: "Legacy Contracts",
      },
    ];

    if (currentTab === "recompetes") {
      return allTargets.filter((target) => target.value === "outlook");
    }

    if (currentTab === "outlook") {
      return allTargets.filter((target) => target.value === "recompetes" || target.value === "legacy");
    }

    return allTargets.filter((target) => target.value === "outlook");
  }

  function renderContractForm(idPrefix: string, mode: FormMode) {
    const isRecompetesMode = mode === "recompetes";

    return (
      <form onSubmit={handleSubmit} className="space-y-3">
        <div className="space-y-3 rounded-lg border border-slate-200 bg-slate-50/60 p-4">
          <div>
            <p className="text-sm font-semibold text-slate-900">Basics</p>
            <p className="text-xs text-slate-500">Start with the contract name and assignees before adding schedule details.</p>
          </div>

          <div className="space-y-2">
            <Label htmlFor={`${idPrefix}-contractName`}>
              {isRecompetesMode ? "Upcoming Procurement" : "Contract Name"}
            </Label>
            <Input
              id={`${idPrefix}-contractName`}
              placeholder={isRecompetesMode ? "Example: EIS" : "Example: HESC II"}
              value={formState.contractName}
              onChange={(event) => updateFormField("contractName", event.target.value)}
              className={fieldErrors.contractName ? "border-rose-400 focus-visible:ring-rose-500" : undefined}
            />
            {fieldErrors.contractName && <p className="text-xs text-rose-600">{fieldErrors.contractName}</p>}
          </div>

          <div className="space-y-2">
            <Label>Assigned To</Label>
            <div className="grid gap-2 sm:grid-cols-[1fr_auto]">
              <div className="relative">
                <Input
                  placeholder="Search for a person"
                  value={assigneeSearch}
                  onChange={(event) => {
                    const nextValue = event.target.value;
                    setAssigneeSearch(nextValue);
                    setIsAssigneeDropdownOpen(nextValue.trim().length > 0);
                  }}
                  onFocus={() => {
                    if (assigneeSearch.trim().length > 0) {
                      setIsAssigneeDropdownOpen(true);
                    }
                  }}
                  onBlur={() => {
                    window.setTimeout(() => setIsAssigneeDropdownOpen(false), 120);
                  }}
                  onKeyDown={(event) => {
                    if (event.key === "Enter") {
                      event.preventDefault();
                      addAssigneeFromSearch();
                    }
                  }}
                />
                {isAssigneeDropdownOpen && assigneeSearch.trim().length > 0 && (
                  <div className="absolute z-50 mt-1 max-h-64 w-full overflow-y-auto rounded-md border border-slate-200 bg-white p-1 shadow-md">
                    {availableAssigneeOptions.length === 0 ? (
                      <button
                        type="button"
                        className="flex w-full cursor-pointer items-center rounded-sm px-3 py-2 text-left text-sm text-slate-600 hover:bg-slate-50"
                        onMouseDown={(event) => event.preventDefault()}
                        onClick={addAssigneeFromSearch}
                      >
                        Add "{assigneeSearch.trim()}"
                      </button>
                    ) : (
                      availableAssigneeOptions.map((option) => (
                        <button
                          key={`${idPrefix}-search-${option.value}`}
                          type="button"
                          className="flex w-full cursor-pointer flex-col rounded-sm px-3 py-2 text-left hover:bg-slate-50"
                          onMouseDown={(event) => event.preventDefault()}
                          onClick={() => {
                            addAssigneeToContract(option.value);
                            setError(null);
                            toast.success(`${option.label} added to the contract.`);
                          }}
                        >
                          <span className="font-medium text-slate-900">{option.label}</span>
                          <span className="text-xs text-slate-500">{option.email}</span>
                        </button>
                      ))
                    )}
                  </div>
                )}
              </div>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button
                    type="button"
                    variant="outline"
                    size="icon"
                    aria-label="Open assignee list"
                    disabled={availableAssigneeOptions.length === 0}
                    onClick={() => setIsAssigneeDropdownOpen(false)}
                  >
                    <ChevronDown className="h-4 w-4" />
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="w-72 max-h-64 overflow-y-auto">
                  {availableAssigneeOptions.length === 0 ? (
                    <DropdownMenuItem disabled>
                      {assigneeSearch.trim() ? "No people match your search." : "No more people to add."}
                    </DropdownMenuItem>
                  ) : (
                    availableAssigneeOptions.map((option) => (
                      <DropdownMenuItem
                        key={`${idPrefix}-${option.value}`}
                        onSelect={() => {
                          addAssigneeToContract(option.value);
                          setError(null);
                          toast.success(`${option.label} added to the contract.`);
                        }}
                      >
                        <div className="flex flex-col">
                          <span className="font-medium text-slate-900">{option.label}</span>
                          <span className="text-xs text-slate-500">{option.email}</span>
                        </div>
                      </DropdownMenuItem>
                    ))
                  )}
                </DropdownMenuContent>
              </DropdownMenu>
            </div>

            <div className="flex flex-wrap gap-2 rounded-md border border-slate-200 p-3">
              {formAssigneeIds.length === 0 ? (
                <span className="text-xs text-slate-500">No assignees selected</span>
              ) : (
                formAssigneeIds.map((assigneeId) => {
                  const assignee = assigneeOptions.find((option) => option.value === assigneeId);
                  return (
                    <span
                      key={`${idPrefix}-${assigneeId}`}
                      className="inline-flex items-center gap-2 rounded-full bg-sky-100 px-2.5 py-1 text-xs font-medium text-sky-800"
                    >
                      <span>{assignee?.label || assigneeId}</span>
                      <button
                        type="button"
                        className="text-sky-900/80 hover:text-sky-950"
                        onClick={() => removeAssigneeFromContract(assigneeId)}
                        aria-label={`Remove ${assignee?.label || assigneeId}`}
                      >
                        x
                      </button>
                    </span>
                  );
                })
              )}
            </div>
            <p className="text-xs text-slate-500">
              {assigneeSearch.trim()
                ? availableAssigneeOptions.length > 0
                  ? "Type to see matching people automatically, or use the arrow to browse the full dropdown."
                  : "No existing match found. Press Enter to add the typed person."
                : "Start typing to see matching people automatically, or use the arrow to browse the dropdown."}
            </p>
          </div>
        </div>

        {isRecompetesMode ? (
          <>
            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-ultimateCompletionDate`}>Contract End Date</Label>
                <Input
                  id={`${idPrefix}-ultimateCompletionDate`}
                  placeholder="MM/DD or YYYY-MM-DD"
                  value={formState.ultimateCompletionDate}
                  onChange={(event) => updateFormField("ultimateCompletionDate", event.target.value)}
                  className={fieldErrors.ultimateCompletionDate ? "border-rose-400 focus-visible:ring-rose-500" : undefined}
                />
                {fieldErrors.ultimateCompletionDate && <p className="text-xs text-rose-600">{fieldErrors.ultimateCompletionDate}</p>}
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-nextPeriodOfPerf`}>PALT Start</Label>
                <Input
                  id={`${idPrefix}-nextPeriodOfPerf`}
                  placeholder="MM/DD or YYYY-MM-DD"
                  value={formState.nextPeriodOfPerf}
                  onChange={(event) => updateFormField("nextPeriodOfPerf", event.target.value)}
                  className={fieldErrors.nextPeriodOfPerf ? "border-rose-400 focus-visible:ring-rose-500" : undefined}
                />
                {fieldErrors.nextPeriodOfPerf && <p className="text-xs text-rose-600">{fieldErrors.nextPeriodOfPerf}</p>}
              </div>
            </div>

            <div className="space-y-3 rounded-lg border border-slate-200 bg-white p-4">
              <div>
                <p className="text-sm font-semibold text-slate-900">Milestone Details</p>
                <p className="text-xs text-slate-500">Capture milestone checkpoints and context notes for this procurement.</p>
              </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-cor`}>Submit APP (PALT + 2 weeks)</Label>
                <Input
                  id={`${idPrefix}-cor`}
                  placeholder="Target date or note"
                  value={formState.cor}
                  onChange={(event) => updateFormField("cor", event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-co`}>Engagement Meeting</Label>
                <Input
                  id={`${idPrefix}-co`}
                  placeholder="Target date or note"
                  value={formState.co}
                  onChange={(event) => updateFormField("co", event.target.value)}
                />
              </div>
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-cs`}>Submit SRO (APP + 2 weeks)</Label>
                <Input
                  id={`${idPrefix}-cs`}
                  placeholder="Target date or note"
                  value={formState.cs}
                  onChange={(event) => updateFormField("cs", event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-contractNumber`}>Submit CGER (SRO + 2 weeks)</Label>
                <Input
                  id={`${idPrefix}-contractNumber`}
                  placeholder="Milestone checkpoint"
                  value={formState.contractNumber}
                  onChange={(event) => updateFormField("contractNumber", event.target.value)}
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor={`${idPrefix}-office`}>Notes</Label>
              <Input
                id={`${idPrefix}-office`}
                placeholder="Any planning notes or blockers"
                value={formState.office}
                onChange={(event) => updateFormField("office", event.target.value)}
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor={`${idPrefix}-orderNumber`}>Reference</Label>
              <Input
                id={`${idPrefix}-orderNumber`}
                placeholder="Reference ID (optional)"
                value={formState.orderNumber}
                onChange={(event) => updateFormField("orderNumber", event.target.value)}
              />
            </div>
            </div>
          </>
        ) : (
          <>
            <div className="space-y-3 rounded-lg border border-slate-200 bg-white p-4">
              <div>
                <p className="text-sm font-semibold text-slate-900">Contract Details</p>
                <p className="text-xs text-slate-500">Capture identifiers, people, and schedule dates to keep records complete.</p>
              </div>
            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-cor`}>COR</Label>
                <Input
                  id={`${idPrefix}-cor`}
                  placeholder="COR name"
                  value={formState.cor}
                  onChange={(event) => updateFormField("cor", event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-contractNumber`}>Contract Number</Label>
                <Input
                  id={`${idPrefix}-contractNumber`}
                  placeholder="Contract identifier"
                  value={formState.contractNumber}
                  onChange={(event) => updateFormField("contractNumber", event.target.value)}
                />
              </div>
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-office`}>Office</Label>
                <Input
                  id={`${idPrefix}-office`}
                  placeholder="Program office"
                  value={formState.office}
                  onChange={(event) => updateFormField("office", event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-nextPeriodOfPerf`}>Next Period of Perf.</Label>
                <Input
                  id={`${idPrefix}-nextPeriodOfPerf`}
                  placeholder="MM/DD or YYYY-MM-DD"
                  value={formState.nextPeriodOfPerf}
                  onChange={(event) => updateFormField("nextPeriodOfPerf", event.target.value)}
                  className={fieldErrors.nextPeriodOfPerf ? "border-rose-400 focus-visible:ring-rose-500" : undefined}
                />
                {fieldErrors.nextPeriodOfPerf && <p className="text-xs text-rose-600">{fieldErrors.nextPeriodOfPerf}</p>}
              </div>
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-ultimateCompletionDate`}>Ultimate Completion Date</Label>
                <Input
                  id={`${idPrefix}-ultimateCompletionDate`}
                  placeholder="MM/DD or YYYY-MM-DD"
                  value={formState.ultimateCompletionDate}
                  onChange={(event) => updateFormField("ultimateCompletionDate", event.target.value)}
                  className={fieldErrors.ultimateCompletionDate ? "border-rose-400 focus-visible:ring-rose-500" : undefined}
                />
                {fieldErrors.ultimateCompletionDate && <p className="text-xs text-rose-600">{fieldErrors.ultimateCompletionDate}</p>}
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-orderNumber`}>Order Number</Label>
                <Input
                  id={`${idPrefix}-orderNumber`}
                  placeholder="Task/Order number"
                  value={formState.orderNumber}
                  onChange={(event) => updateFormField("orderNumber", event.target.value)}
                />
              </div>
            </div>

            <div className="grid gap-3 sm:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-co`}>CO</Label>
                <Input
                  id={`${idPrefix}-co`}
                  placeholder="CO name"
                  value={formState.co}
                  onChange={(event) => updateFormField("co", event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor={`${idPrefix}-cs`}>CS</Label>
                <Input
                  id={`${idPrefix}-cs`}
                  placeholder="CS name"
                  value={formState.cs}
                  onChange={(event) => updateFormField("cs", event.target.value)}
                />
              </div>
            </div>
            </div>
          </>
        )}

        {error && (
          <p className="text-sm text-rose-600">{error}</p>
        )}

        <div className="flex flex-wrap items-center gap-2 pt-2">
          <Button type="submit" disabled={isSaving}>
            <Plus className="mr-2 h-4 w-4" />
            {isSaving ? "Saving..." : isEditMode ? "Update Contract" : "Create Contract"}
          </Button>
          {isEditMode && (
            <Button type="button" variant="outline" onClick={resetForm}>
              <XCircle className="mr-2 h-4 w-4" />
              Cancel Edit
            </Button>
          )}
        </div>
      </form>
    );
  }

  function renderContractFormCard(idPrefix: string) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>{formMode === "recompetes" ? "Manage New Awards and Recompetes" : "Manage Contracts"}</CardTitle>
        </CardHeader>
        <CardContent>
          {isEditMode ? (
            renderContractForm(idPrefix, formMode)
          ) : (
            <div className="space-y-3 text-sm text-slate-600">
              <p>Select a contract and click Edit to manage details here.</p>
              <p>Use the + New Contract button to create a new contract in a popup form.</p>
            </div>
          )}
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-6">
      {!hideFilters && (
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Quick Filters and Sorting</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-5">
              <div className="space-y-2 xl:col-span-2">
                <Label htmlFor="contracts-search">Search</Label>
                <Input
                  id="contracts-search"
                  placeholder="Search contract, number, office, or assignee"
                  value={searchTerm}
                  onChange={(event) => setSearchTerm(event.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label>Assignment</Label>
                <Select
                  value={assignmentFilter}
                  onValueChange={(value: "all" | "assigned" | "unassigned") => setAssignmentFilter(value)}
                >
                  <SelectTrigger>
                    <SelectValue placeholder="All" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All</SelectItem>
                    <SelectItem value="assigned">Assigned only</SelectItem>
                    <SelectItem value="unassigned">Unassigned only</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Due Date</Label>
                <Select value={dueFilter} onValueChange={(value: "all" | "dueSoon") => setDueFilter(value)}>
                  <SelectTrigger>
                    <SelectValue placeholder="All" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">All dates</SelectItem>
                    <SelectItem value="dueSoon">Due in 30 days</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Sort By</Label>
                <div className="flex gap-2">
                  <Select value={sortBy} onValueChange={(value: "name" | "endDate" | "assignee") => setSortBy(value)}>
                    <SelectTrigger>
                      <SelectValue placeholder="Contract name" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="name">Contract name</SelectItem>
                      <SelectItem value="endDate">End date</SelectItem>
                      <SelectItem value="assignee">Assignee</SelectItem>
                    </SelectContent>
                  </Select>
                  <Select value={sortDirection} onValueChange={(value: "asc" | "desc") => setSortDirection(value)}>
                    <SelectTrigger className="w-[120px]">
                      <SelectValue placeholder="Asc" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="asc">Asc</SelectItem>
                      <SelectItem value="desc">Desc</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
            <div className="flex flex-wrap items-center justify-between gap-2 text-sm text-slate-600">
              <p>
                Showing {sortedContracts.length} of {contracts.length} contracts
              </p>
              {hasActiveFilters && (
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    setSearchTerm("");
                    setAssignmentFilter("all");
                    setDueFilter("all");
                    setSortBy("name");
                    setSortDirection("asc");
                  }}
                >
                  Clear filters
                </Button>
              )}
            </div>
          </CardContent>
        </Card>
      )}

      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-4">
        <TabsList className="h-auto w-full justify-start overflow-x-auto p-1">
          <TabsTrigger
            value="recompetes"
            className="border border-amber-200 bg-amber-50 text-amber-800 data-[state=active]:border-amber-700 data-[state=active]:bg-amber-300 data-[state=active]:text-amber-950"
          >
            New Awards and Recompetes
          </TabsTrigger>
          <TabsTrigger
            value="outlook"
            className="border border-sky-200 bg-sky-50 text-sky-800 data-[state=active]:border-sky-700 data-[state=active]:bg-sky-300 data-[state=active]:text-sky-950"
          >
            Current and Active Contracts/Purchase Order Outlook
          </TabsTrigger>
          <TabsTrigger
            value="legacy"
            className="border border-rose-200 bg-rose-50 text-rose-800 data-[state=active]:border-rose-700 data-[state=active]:bg-rose-300 data-[state=active]:text-rose-950"
          >
            Legacy Contracts
          </TabsTrigger>
        </TabsList>

        <TabsContent value="outlook" className="space-y-6">
          <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>Current and Active Contracts/Purchase Order Outlook</CardTitle>
                <Button type="button" variant="outline" size="sm" onClick={startCreate}>
                  <Plus className="mr-1 h-3.5 w-3.5" />
                  New Contract
                </Button>
              </CardHeader>
              <CardContent>
                <ContractsOutlookTable
                  contracts={outlookContracts}
                  showActions
                  getAssigneeLabel={(contract) => getAssigneeLabel(contract.assigneeIds ?? [], assigneeOptions)}
                  getAssigneeDetails={(contract) => getAssigneeDetails(contract.assigneeIds ?? [], assigneeOptions)}
                  onEdit={(contract) => startEdit(contract, "outlook")}
                  onDelete={handleDelete}
                  onMove={handleMove}
                  moveTargets={getMoveTargets("outlook")}
                  isDeleting={isSaving}
                />
              </CardContent>
            </Card>

            {renderContractFormCard("outlook")}
          </div>
        </TabsContent>

        <TabsContent value="recompetes" className="space-y-6">
          <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between">
                <CardTitle>New Awards and Recompetes</CardTitle>
                <Button type="button" variant="outline" size="sm" onClick={startCreate}>
                  <Plus className="mr-1 h-3.5 w-3.5" />
                  New Contract
                </Button>
              </CardHeader>
              <CardContent>
                <NewAwardsRecompetesTable
                  contracts={recompeteContracts}
                  getAssigneeLabel={(contract) => getAssigneeLabel(contract.assigneeIds ?? [], assigneeOptions)}
                  getAssigneeDetails={(contract) => getAssigneeDetails(contract.assigneeIds ?? [], assigneeOptions)}
                  onEdit={(contract) => startEdit(contract, "recompetes")}
                  onDelete={handleDelete}
                  onMove={handleMove}
                  moveTargets={getMoveTargets("recompetes")}
                  isDeleting={isSaving}
                />
              </CardContent>
            </Card>

            {renderContractFormCard("recompetes")}
          </div>
        </TabsContent>

        <TabsContent value="legacy" className="space-y-6">
          <div className="grid gap-6 lg:grid-cols-[1fr_360px]">
            <Card>
              <CardHeader>
                <CardTitle>Legacy Contracts</CardTitle>
              </CardHeader>
              <CardContent>
                <ContractsOutlookTable
                  contracts={legacyContracts}
                  showActions
                  getAssigneeLabel={(contract) => getAssigneeLabel(contract.assigneeIds ?? [], assigneeOptions)}
                  getAssigneeDetails={(contract) => getAssigneeDetails(contract.assigneeIds ?? [], assigneeOptions)}
                  onEdit={(contract) => startEdit(contract, "outlook")}
                  onDelete={handleDelete}
                  onMove={handleMove}
                  moveTargets={getMoveTargets("legacy")}
                  isDeleting={isSaving}
                />
              </CardContent>
            </Card>

            {renderContractFormCard("legacy")}
          </div>
        </TabsContent>
      </Tabs>

      <Dialog open={Boolean(selectedContract)} onOpenChange={(open) => !open && setSelectedContract(null)}>
        {selectedContract && (
          <DialogContent>
            <DialogHeader>
              <DialogTitle>{selectedContract.contractName}</DialogTitle>
              <DialogDescription>High-level contract information.</DialogDescription>
            </DialogHeader>
            <div className="grid gap-3 text-sm sm:grid-cols-2">
              <p><span className="font-semibold">Assigned To:</span> {getAssigneeLabel(selectedContract.assigneeIds ?? [], assigneeOptions)}</p>
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

      <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
        <DialogContent className="sm:max-w-2xl">
          <DialogHeader>
            <DialogTitle>
              {formMode === "recompetes" ? "Create New Award or Recompete" : "Create New Contract"}
            </DialogTitle>
            <DialogDescription>
              Add a new {formMode === "recompetes" ? "award or recompete" : "contract"} with the fields below.
            </DialogDescription>
          </DialogHeader>
          {renderContractForm("create-dialog", formMode)}
        </DialogContent>
      </Dialog>
    </div>
  );
}
