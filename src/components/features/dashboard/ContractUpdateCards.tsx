"use client";

import { useEffect, useMemo, useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { Switch } from "@/components/ui/switch";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogFooter,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";
import { CardGrid } from "@/components/shared/CardGrid";
import type { ActiveContractDetails, MockContract } from "@/lib/mock-contracts";
import { cn } from "@/lib/utils";
import { CircleHelp } from "lucide-react";
import { CardWalkthrough, CardWalkthroughStep } from "./CardWalkthrough";

interface ContractUpdateCardsProps {
  contracts: MockContract[];
  enhancedEditorEnabled?: boolean;
}

type WalkthroughVariant = "simple" | "advanced";

type LineItemStatus = "NORMAL" | "RISK" | "CRITICAL";
type LineItemCategory = "GENERAL" | "FUNDING" | "ACTION" | "RISK" | "DECISION" | "MEETING";

interface DraftLineItem {
  id: string;
  text: string;
  status: LineItemStatus;
  category: LineItemCategory;
  owner: string;
  dueDate: string;
  carryForward: boolean;
  actionRequired: boolean;
}

interface DraftState {
  submissionMode: "SIMPLE" | "DETAILED";
  simpleText: string;
  simpleStatus: LineItemStatus;
  lineItems: DraftLineItem[];
  noUpdate: boolean;
  submitted: boolean;
  submittedAt: string | null;
}

type ActiveContractState = Record<string, ActiveContractDetails>;

interface FieldHintLabelProps {
  label: string;
  hint: string;
  dataTour?: string;
}

function FieldHintLabel({ label, hint, dataTour }: FieldHintLabelProps) {
  return (
    <div className="mb-1 flex items-center gap-1.5" data-tour={dataTour}>
      <p className="text-xs font-medium text-slate-500">{label}</p>
      <Tooltip>
        <TooltipTrigger asChild>
          <button
            type="button"
            aria-label={`More information about ${label}`}
            className="rounded-full text-slate-400 transition hover:text-slate-700 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 focus-visible:ring-offset-2"
          >
            <CircleHelp className="h-3.5 w-3.5" />
          </button>
        </TooltipTrigger>
        <TooltipContent side="top" className="max-w-[280px] bg-slate-900 px-3 py-2 text-slate-100">
          <p className="text-xs leading-5">{hint}</p>
        </TooltipContent>
      </Tooltip>
    </div>
  );
}

const statusStyles: Record<LineItemStatus, string> = {
  NORMAL: "bg-slate-100 text-slate-700 border-slate-200",
  RISK: "bg-amber-100 text-amber-800 border-amber-200",
  CRITICAL: "bg-rose-100 text-rose-800 border-rose-200",
};

const categoryOptions: Array<{ value: LineItemCategory; label: string; description: string }> = [
  { value: "GENERAL", label: "General", description: "General weekly context and summary notes." },
  { value: "FUNDING", label: "Funding", description: "Funding status, runout dates, and approvals." },
  { value: "ACTION", label: "Action", description: "Task orders, requests, and operational work." },
  { value: "RISK", label: "Risk", description: "Issues, blockers, and escalation items." },
  { value: "DECISION", label: "Decision", description: "Decisions pending or required from stakeholders." },
  { value: "MEETING", label: "Meeting", description: "Meetings, briefings, and follow-up notes." },
];

function createLineItem(
  text: string = "",
  overrides: Partial<Omit<DraftLineItem, "id" | "text">> = {}
): DraftLineItem {
  return {
    id: `${Date.now()}-${Math.random().toString(36).slice(2, 8)}`,
    text,
    status: overrides.status ?? "NORMAL",
    category: overrides.category ?? "GENERAL",
    owner: overrides.owner ?? "",
    dueDate: overrides.dueDate ?? "",
    carryForward: overrides.carryForward ?? false,
    actionRequired: overrides.actionRequired ?? false,
  };
}

const cardThemes: Record<string, { shell: string; panel: string; badge: string }> = {
  ebusiness: {
    shell: "border-sky-300 bg-gradient-to-br from-white via-sky-50 to-cyan-100 shadow-[0_24px_60px_-28px_rgba(14,116,144,0.45)]",
    panel: "border-sky-200 bg-white/90",
    badge: "bg-sky-700 text-white hover:bg-sky-700",
  },
  "hesc-ii": {
    shell: "border-emerald-300 bg-gradient-to-br from-white via-emerald-50 to-lime-100 shadow-[0_24px_60px_-28px_rgba(5,150,105,0.4)]",
    panel: "border-emerald-200 bg-white/90",
    badge: "bg-emerald-700 text-white hover:bg-emerald-700",
  },
  "iti-iii": {
    shell: "border-amber-300 bg-gradient-to-br from-white via-amber-50 to-orange-100 shadow-[0_24px_60px_-28px_rgba(217,119,6,0.42)]",
    panel: "border-amber-200 bg-white/90",
    badge: "bg-amber-700 text-white hover:bg-amber-700",
  },
};

const WALKTHROUGH_DISMISSED_KEY = "war-submit-card-walkthrough-dismissed";

export function ContractUpdateCards({
  contracts,
  enhancedEditorEnabled = true,
}: ContractUpdateCardsProps) {
  const initialDrafts = useMemo<Record<string, DraftState>>(
    () =>
      Object.fromEntries(
        contracts.map((contract) => [
          contract.id,
          {
            submissionMode: "SIMPLE",
            simpleText: "",
            simpleStatus: "NORMAL",
            lineItems: [createLineItem()],
            noUpdate: false,
            submitted: false,
            submittedAt: null,
          },
        ])
      ),
    [contracts]
  );
  const [drafts, setDrafts] = useState<Record<string, DraftState>>(initialDrafts);
  const [selectedContractId, setSelectedContractId] = useState<string | null>(null);
  const [isEnhancedModeEnabled, setIsEnhancedModeEnabled] = useState(enhancedEditorEnabled);
  const [walkthroughVariant, setWalkthroughVariant] = useState<WalkthroughVariant | null>(null);
  const [selectedActiveContractId, setSelectedActiveContractId] = useState<string | null>(null);
  const [activeContracts, setActiveContracts] = useState<ActiveContractState>(
    Object.fromEntries(contracts.map((contract) => [contract.id, contract.activeContract]))
  );

  const selectedContract =
    contracts.find((contract) => contract.id === selectedContractId) ?? null;
  const selectedActiveContract = selectedActiveContractId
    ? activeContracts[selectedActiveContractId]
    : null;

  const firstContractId = contracts[0]?.id ?? null;

  const isWalkthroughOpen = walkthroughVariant !== null;

  const simpleWalkthroughSteps = useMemo<CardWalkthroughStep[]>(() => {
    if (!firstContractId) {
      return [];
    }

    return [
      {
        id: "card-overview",
        selector: "[data-tour='submit-card-shell']",
        title: "Start with the first project card",
        description:
          "Each card is a separate project update. Use this first card as the pattern, then repeat for any other projects that need changes this week.",
      },
      {
        id: "previous-week",
        selector: "[data-tour='submit-card-previous-week']",
        title: "Review prior context quickly",
        description:
          "The previous-week section gives fast context so you can see what changed before drafting this week's update.",
      },
      {
        id: "simple-status",
        selector: "[data-tour='submit-card-simple-status']",
        title: "Set update severity",
        description:
          "Choose NORMAL, RISK, or CRITICAL to signal urgency and review priority for this week\'s update.",
      },
      {
        id: "simple-text",
        selector: "[data-tour='submit-card-simple-text']",
        title: "Write the weekly narrative",
        description:
          "Capture what changed this week in plain language: progress, blockers, and what leadership needs to know.",
      },
      {
        id: "no-update",
        selector: "[data-tour='submit-card-no-update-button']",
        title: "Use No Update when appropriate",
        description:
          "Select No Update only when nothing changed this week. It auto-fills a standard response and keeps reporting consistent.",
      },
      {
        id: "submit-button",
        selector: "[data-tour='submit-card-submit-button']",
        title: "Submit this project when ready",
        description:
          "Use Submit to lock this card's draft for the week. You can still reopen it later by selecting Edit.",
      },
    ];
  }, [firstContractId]);

  const advancedWalkthroughSteps = useMemo<CardWalkthroughStep[]>(() => {
    if (!firstContractId) {
      return [];
    }

    return [
      {
        id: "advanced-tabs",
        selector: "[data-tour='submit-card-mode-tabs']",
        title: "Switch to Detailed mode",
        description:
          "Detailed mode is designed for structured updates with categories and richer tracking fields.",
      },
      {
        id: "advanced-status",
        selector: "[data-tour='submit-card-detailed-status']",
        title: "Set line-item status",
        description:
          "Each detailed entry gets a status. Use CRITICAL for urgent blockers, RISK for emerging concerns, and NORMAL for stable progress.",
      },
      {
        id: "advanced-owner",
        selector: "[data-tour='submit-card-detailed-owner']",
        title: "Assign an owner",
        description:
          "Owner identifies who is accountable for follow-up. Use a person or team name so reviewers know who to contact.",
      },
      {
        id: "advanced-due-date",
        selector: "[data-tour='submit-card-detailed-due-date']",
        title: "Set a due date",
        description:
          "Use due date for commitments and expected completion timing. Leave blank only when a date is genuinely unknown.",
      },
      {
        id: "advanced-action-required",
        selector: "[data-tour='submit-card-detailed-action-required']",
        title: "Flag action-required items",
        description:
          "Check Action required when leadership or another team needs to do something to move this item forward.",
      },
      {
        id: "advanced-line-carry-forward",
        selector: "[data-tour='submit-card-detailed-line-carry-forward']",
        title: "Mark ongoing items",
        description:
          "Check Carry forward for items that remain active into the next reporting cycle.",
      },
      {
        id: "advanced-text",
        selector: "[data-tour='submit-card-detailed-text']",
        title: "Document detailed update text",
        description:
          "Write specifics: what happened, impact, and next step. This text is what reviewers use for decisions and approvals.",
      },
      {
        id: "advanced-carry-forward",
        selector: "[data-tour='submit-card-carry-forward']",
        title: "Carry forward prior week text",
        description:
          "Use carry-forward when previous notes are still active so you can refine instead of retyping recurring updates.",
      },
      {
        id: "advanced-submit",
        selector: "[data-tour='submit-card-submit-button']",
        title: "Submit the detailed draft",
        description:
          "When your detailed items are complete, submit this card. You can still reopen it later by selecting Edit.",
      },
    ];
  }, [firstContractId]);

  const activeWalkthroughSteps = walkthroughVariant === "advanced"
    ? advancedWalkthroughSteps
    : simpleWalkthroughSteps;

  useEffect(() => {
    if (!firstContractId) {
      return;
    }

    const dismissed = window.localStorage.getItem(WALKTHROUGH_DISMISSED_KEY) === "true";

    if (dismissed) {
      return;
    }

    const timeoutId = window.setTimeout(() => {
      setWalkthroughVariant("simple");
    }, 500);

    return () => window.clearTimeout(timeoutId);
  }, [firstContractId]);

  function handleWalkthroughClose(rememberDismissal: boolean) {
    setWalkthroughVariant(null);

    if (rememberDismissal) {
      window.localStorage.setItem(WALKTHROUGH_DISMISSED_KEY, "true");
    }
  }

  function setSubmissionMode(contractId: string, mode: "SIMPLE" | "DETAILED") {
    patchSimpleDraft(contractId, { submissionMode: mode });
  }

  function launchSimpleWalkthrough() {
    if (!firstContractId) {
      return;
    }

    setSubmissionMode(firstContractId, "SIMPLE");
    setWalkthroughVariant("simple");
  }

  function launchAdvancedWalkthrough() {
    if (!firstContractId) {
      return;
    }

    setIsEnhancedModeEnabled(true);
    setSubmissionMode(firstContractId, "DETAILED");
    setWalkthroughVariant("advanced");
  }

  function patchLineItem(
    contractId: string,
    lineItemId: string,
    patch: Partial<Omit<DraftLineItem, "id">>
  ) {
    setDrafts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
        lineItems: prev[contractId].lineItems.map((lineItem) => {
          if (lineItem.id !== lineItemId) {
            return lineItem;
          }

          return { ...lineItem, ...patch };
        }),
        noUpdate:
          prev[contractId].lineItems.length === 1 &&
          ((patch.text ?? prev[contractId].lineItems[0]?.text ?? "").trim() === "No update this week."),
      },
    }));
  }

  function patchSimpleDraft(
    contractId: string,
    patch: Partial<Pick<DraftState, "simpleText" | "simpleStatus" | "submissionMode">>
  ) {
    setDrafts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
        ...patch,
        noUpdate:
          prev[contractId].lineItems.length === 1 &&
          ((patch.simpleText ?? prev[contractId].simpleText).trim() === "No update this week."),
      },
    }));
  }

  function addLineItem(contractId: string, category: LineItemCategory = "GENERAL") {
    setDrafts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
        noUpdate: false,
          submissionMode: "DETAILED",
        lineItems: [...prev[contractId].lineItems, createLineItem("", { category })],
      },
    }));
  }

  function removeLineItem(contractId: string, lineItemId: string) {
    setDrafts((prev) => {
      const nextLineItems = prev[contractId].lineItems.filter((lineItem) => lineItem.id !== lineItemId);

      return {
        ...prev,
        [contractId]: {
          ...prev[contractId],
          lineItems: nextLineItems.length > 0 ? nextLineItems : [createLineItem()],
          noUpdate: false,
        },
      };
    });
  }

  function toggleNoUpdate(contractId: string) {
    setDrafts((prev) => {
      const current = prev[contractId];
      const noUpdate = !current.noUpdate;

      return {
        ...prev,
        [contractId]: {
          lineItems: noUpdate ? [createLineItem("No update this week.")] : [createLineItem()],
          submissionMode: noUpdate ? prev[contractId].submissionMode : prev[contractId].submissionMode,
          simpleText: noUpdate ? "No update this week." : "",
          simpleStatus: prev[contractId].simpleStatus,
          noUpdate,
          submitted: current.submitted,
          submittedAt: current.submittedAt,
        },
      };
    });
  }

  function carryForwardPreviousWeek(contractId: string) {
    const contract = contracts.find((item) => item.id === contractId);

    if (!contract) {
      return;
    }

    setDrafts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
          submissionMode: "DETAILED",
        noUpdate: false,
        lineItems: [
          ...prev[contractId].lineItems,
          createLineItem(contract.previousWeekSubmission, {
            category: "GENERAL",
            carryForward: true,
            actionRequired: false,
          }),
        ],
      },
    }));
  }

  function submitContract(contractId: string) {
    setDrafts((prev) => {
      const current = prev[contractId];
      const hasContent =
        current.submissionMode === "SIMPLE"
          ? Boolean(current.simpleText.trim())
          : current.lineItems.some((lineItem) => lineItem.text.trim());

      if (!hasContent) {
        return prev;
      }

      const syncedLineItems =
        current.submissionMode === "SIMPLE"
          ? [
              createLineItem(current.simpleText, {
                status: current.simpleStatus,
                category: "GENERAL",
              }),
            ]
          : current.lineItems;

      return {
        ...prev,
        [contractId]: {
          ...current,
          lineItems: syncedLineItems,
          submitted: true,
          submittedAt: new Date().toLocaleDateString("en-US", {
            month: "2-digit",
            day: "2-digit",
            year: "numeric",
          }),
        },
      };
    });
  }

  function enableEditing(contractId: string) {
    setDrafts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
        submitted: false,
        submittedAt: null,
      },
    }));
  }

  function updateActiveContractField(
    contractId: string,
    field: keyof ActiveContractDetails,
    value: string
  ) {
    setActiveContracts((prev) => ({
      ...prev,
      [contractId]: {
        ...prev[contractId],
        [field]: value,
      },
    }));
  }

  function renderBasicLineItems(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    return (
      <div className="space-y-3">
        {draft.lineItems.map((lineItem, index) => (
          <div
            key={lineItem.id}
            className="rounded-xl border border-slate-200 bg-white/80 p-3 shadow-sm"
          >
            <div className="mb-3 flex flex-wrap items-center justify-between gap-2">
              <div className="flex items-center gap-2">
                <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">
                  Line Item {index + 1}
                </p>
                <span className={cn("rounded-full border px-2 py-0.5 text-[11px] font-semibold", statusStyles[lineItem.status])}>
                  {lineItem.status}
                </span>
              </div>
              <div className="flex items-center gap-2">
                <div className="w-[140px]">
                  <FieldHintLabel
                    label="Status"
                    hint="Pick the overall severity of this update: NORMAL for stable progress, RISK for concerns, CRITICAL for urgent issues."
                    dataTour={isFirstCard && index === 0 ? "submit-card-basic-status" : undefined}
                  />
                  <Select
                    disabled={draft.submitted}
                    value={lineItem.status}
                    onValueChange={(value) =>
                      patchLineItem(contract.id, lineItem.id, { status: value as LineItemStatus })
                    }
                  >
                    <SelectTrigger className="bg-white text-slate-900">
                      <SelectValue placeholder="Status" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="NORMAL">NORMAL</SelectItem>
                      <SelectItem value="RISK">RISK</SelectItem>
                      <SelectItem value="CRITICAL">CRITICAL</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  disabled={draft.submitted || draft.lineItems.length === 1}
                  onClick={() => removeLineItem(contract.id, lineItem.id)}
                >
                  Remove
                </Button>
              </div>
            </div>
            <FieldHintLabel
              label="Line Item Details"
              hint="Summarize weekly progress, blockers, and planned next steps for this line item."
              dataTour={isFirstCard && index === 0 ? "submit-card-basic-text" : undefined}
            />
            <Textarea
              value={lineItem.text}
              placeholder={index === 0 ? contract.currentUpdatePlaceholder : "Add another line item."}
              className="min-h-[110px] resize-y border-slate-400 bg-white text-slate-900 shadow-sm"
              disabled={draft.submitted}
              onChange={(event) => patchLineItem(contract.id, lineItem.id, { text: event.target.value })}
              onClick={(event) => event.stopPropagation()}
            />
          </div>
        ))}

        <Button
          type="button"
          variant="outline"
          disabled={draft.submitted || draft.noUpdate}
          onClick={() => addLineItem(contract.id)}
        >
          Add Line Item
        </Button>
      </div>
    );
  }

  function renderSimpleSubmission(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    return (
      <div className="rounded-xl border border-slate-200 bg-white/80 p-4 shadow-sm">
        <div className="mb-4 flex flex-wrap items-center justify-between gap-3">
          <div>
            <p className="text-sm font-semibold text-slate-900">Simple Text Submission</p>
            <p className="text-xs text-slate-500">
              Recommended for quick weekly narratives when you do not need extra tracking fields.
            </p>
          </div>
          <div className="w-[150px]">
            <FieldHintLabel
              label="Status"
              hint="Choose severity for the entire weekly narrative: NORMAL for on-track work, RISK for caution, CRITICAL for urgent attention."
              dataTour={isFirstCard ? "submit-card-simple-status" : undefined}
            />
            <Select
              disabled={draft.submitted}
              value={draft.simpleStatus}
              onValueChange={(value) =>
                patchSimpleDraft(contract.id, { simpleStatus: value as LineItemStatus })
              }
            >
              <SelectTrigger className="bg-white text-slate-900">
                <SelectValue placeholder="Status" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="NORMAL">NORMAL</SelectItem>
                <SelectItem value="RISK">RISK</SelectItem>
                <SelectItem value="CRITICAL">CRITICAL</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>

        <div className="mb-3">
          <span className={cn("rounded-full border px-2 py-1 text-[11px] font-semibold", statusStyles[draft.simpleStatus])}>
            {draft.simpleStatus}
          </span>
        </div>

        <FieldHintLabel
          label="Weekly Update Text"
          hint="Write one concise narrative that covers progress, blockers, and what comes next for this contract this week."
          dataTour={isFirstCard ? "submit-card-simple-text" : undefined}
        />

        <Textarea
          value={draft.simpleText}
          placeholder={`Example: ${contract.currentUpdatePlaceholder}`}
          className="min-h-[150px] resize-y border-slate-400 bg-white text-slate-900 shadow-sm"
          disabled={draft.submitted}
          onChange={(event) => patchSimpleDraft(contract.id, { simpleText: event.target.value })}
          onClick={(event) => event.stopPropagation()}
        />
      </div>
    );
  }

  function renderEnhancedLineItems(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    return (
      <div className="space-y-4" data-tour={isFirstCard ? "submit-card-detailed-section" : undefined}>
        {categoryOptions.map((category) => {
          const items = draft.lineItems.filter((lineItem) => lineItem.category === category.value);

          return (
            <div key={category.value} className="rounded-xl border border-slate-200 bg-white/70 p-4 shadow-sm">
              <div className="mb-4 flex flex-wrap items-center justify-between gap-3">
                <div>
                  <p className="text-sm font-semibold text-slate-900">{category.label}</p>
                  <p className="text-xs text-slate-500">{category.description}</p>
                </div>
                <Button
                  type="button"
                  variant="outline"
                  size="sm"
                  data-tour={isFirstCard && category.value === "GENERAL" ? "submit-card-detailed-add-item" : undefined}
                  disabled={draft.submitted || draft.noUpdate}
                  onClick={() => addLineItem(contract.id, category.value)}
                >
                  Add {category.label} Item
                </Button>
              </div>

              {items.length === 0 ? (
                <div className="rounded-lg border border-dashed border-slate-300 bg-slate-50 px-4 py-3 text-xs text-slate-500">
                  No {category.label.toLowerCase()} items added yet.
                </div>
              ) : (
                <div className="space-y-3">
                  {items.map((lineItem, index) => {
                    const isFirstDetailedItem = isFirstCard && category.value === "GENERAL" && index === 0;

                    return (
                    <div key={lineItem.id} className="rounded-xl border border-slate-200 bg-white p-3 shadow-sm">
                      <div className="mb-3 flex flex-wrap items-center justify-between gap-2">
                        <div className="flex items-center gap-2">
                          <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">
                            {category.label} Item {index + 1}
                          </p>
                          <span className={cn("rounded-full border px-2 py-0.5 text-[11px] font-semibold", statusStyles[lineItem.status])}>
                            {lineItem.status}
                          </span>
                        </div>
                        <Button
                          type="button"
                          variant="ghost"
                          size="sm"
                          disabled={draft.submitted || draft.lineItems.length === 1}
                          onClick={() => removeLineItem(contract.id, lineItem.id)}
                        >
                          Remove
                        </Button>
                      </div>

                      <div className="mb-3 grid gap-3 md:grid-cols-2 xl:grid-cols-4">
                        <div>
                          <FieldHintLabel
                            label="Status"
                            hint="Classify the risk level for this specific line item so reviewers can triage quickly."
                            dataTour={isFirstDetailedItem ? "submit-card-detailed-status" : undefined}
                          />
                          <Select
                            disabled={draft.submitted}
                            value={lineItem.status}
                            onValueChange={(value) =>
                              patchLineItem(contract.id, lineItem.id, { status: value as LineItemStatus })
                            }
                          >
                            <SelectTrigger className="bg-white text-slate-900">
                              <SelectValue placeholder="Status" />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value="NORMAL">NORMAL</SelectItem>
                              <SelectItem value="RISK">RISK</SelectItem>
                              <SelectItem value="CRITICAL">CRITICAL</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>
                        <div>
                          <FieldHintLabel
                            label="Owner"
                            hint="Enter the accountable person or team responsible for resolving or advancing this item."
                            dataTour={isFirstDetailedItem ? "submit-card-detailed-owner" : undefined}
                          />
                          <Input
                            value={lineItem.owner}
                            disabled={draft.submitted}
                            placeholder="Owner"
                            className="bg-white text-slate-900"
                            onChange={(event) => patchLineItem(contract.id, lineItem.id, { owner: event.target.value })}
                          />
                        </div>
                        <div>
                          <FieldHintLabel
                            label="Due Date"
                            hint="Set the expected completion date for this item to help track schedule risk and deadlines."
                            dataTour={isFirstDetailedItem ? "submit-card-detailed-due-date" : undefined}
                          />
                          <Input
                            type="date"
                            value={lineItem.dueDate}
                            disabled={draft.submitted}
                            className="bg-white text-slate-900"
                            onChange={(event) => patchLineItem(contract.id, lineItem.id, { dueDate: event.target.value })}
                          />
                        </div>
                        <div className="flex flex-col justify-end gap-2">
                          <div
                            className="flex items-center gap-2 text-xs text-slate-600"
                            data-tour={isFirstDetailedItem ? "submit-card-detailed-action-required" : undefined}
                          >
                            <Checkbox
                              checked={lineItem.actionRequired}
                              disabled={draft.submitted}
                              onCheckedChange={(checked) =>
                                patchLineItem(contract.id, lineItem.id, { actionRequired: checked === true })
                              }
                            />
                            <span>Action required</span>
                            <Tooltip>
                              <TooltipTrigger asChild>
                                <button
                                  type="button"
                                  aria-label="More information about Action required"
                                  className="rounded-full text-slate-400 transition hover:text-slate-700 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 focus-visible:ring-offset-2"
                                >
                                  <CircleHelp className="h-3.5 w-3.5" />
                                </button>
                              </TooltipTrigger>
                              <TooltipContent side="top" className="max-w-[280px] bg-slate-900 px-3 py-2 text-slate-100">
                                <p className="text-xs leading-5">
                                  Check this when leadership or another team must take action for this item.
                                </p>
                              </TooltipContent>
                            </Tooltip>
                          </div>
                          <div
                            className="flex items-center gap-2 text-xs text-slate-600"
                            data-tour={isFirstDetailedItem ? "submit-card-detailed-line-carry-forward" : undefined}
                          >
                            <Checkbox
                              checked={lineItem.carryForward}
                              disabled={draft.submitted}
                              onCheckedChange={(checked) =>
                                patchLineItem(contract.id, lineItem.id, { carryForward: checked === true })
                              }
                            />
                            <span>Carry forward</span>
                            <Tooltip>
                              <TooltipTrigger asChild>
                                <button
                                  type="button"
                                  aria-label="More information about Carry forward"
                                  className="rounded-full text-slate-400 transition hover:text-slate-700 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-sky-500 focus-visible:ring-offset-2"
                                >
                                  <CircleHelp className="h-3.5 w-3.5" />
                                </button>
                              </TooltipTrigger>
                              <TooltipContent side="top" className="max-w-[280px] bg-slate-900 px-3 py-2 text-slate-100">
                                <p className="text-xs leading-5">
                                  Check this when the item should stay open and continue into the next weekly report.
                                </p>
                              </TooltipContent>
                            </Tooltip>
                          </div>
                        </div>
                      </div>

                      <FieldHintLabel
                        label="Line Item Details"
                        hint="Describe what changed, current impact, and what will happen next so reviewers have complete context."
                        dataTour={isFirstDetailedItem ? "submit-card-detailed-text" : undefined}
                      />

                      <Textarea
                        value={lineItem.text}
                        placeholder={contract.currentUpdatePlaceholder}
                        className="min-h-[110px] resize-y border-slate-400 bg-white text-slate-900 shadow-sm"
                        disabled={draft.submitted}
                        onChange={(event) => patchLineItem(contract.id, lineItem.id, { text: event.target.value })}
                        onClick={(event) => event.stopPropagation()}
                      />
                    </div>
                  );
                  })}
                </div>
              )}
            </div>
          );
        })}
      </div>
    );
  }

  return (
    <TooltipProvider delayDuration={120}>
      <div className="rounded-xl border border-slate-200 bg-white px-4 py-3 shadow-sm">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <p className="text-sm font-semibold text-slate-900">Enhanced Submission Workflow</p>
            <p className="text-xs text-slate-500">
              Toggle structured sections, owner and due-date tracking, and carry-forward support.
            </p>
          </div>
          <div className="flex flex-col items-end gap-2 sm:flex-row sm:items-center">
            <Button type="button" variant="outline" size="sm" onClick={launchSimpleWalkthrough}>
              Simple walkthrough
            </Button>
            <Button type="button" variant="secondary" size="sm" onClick={launchAdvancedWalkthrough}>
              Advanced walkthrough
            </Button>
            <label className="flex items-center gap-3 text-sm font-medium text-slate-700">
              <span>{isEnhancedModeEnabled ? "Enhanced mode" : "Simple mode"}</span>
              <Switch
                checked={isEnhancedModeEnabled}
                onCheckedChange={setIsEnhancedModeEnabled}
                aria-label="Toggle enhanced submission workflow"
              />
            </label>
          </div>
        </div>
      </div>

      <CardGrid columns={2} gap="lg">
        {contracts.map((contract, index) => {
          const isFirstCard = index === 0;
          const draft = drafts[contract.id] ?? {
            submissionMode: "SIMPLE",
            simpleText: "",
            simpleStatus: "NORMAL",
            lineItems: [createLineItem()],
            noUpdate: false,
            submitted: false,
            submittedAt: null,
          };
          const hasDraftContent =
            draft.submissionMode === "SIMPLE"
              ? Boolean(draft.simpleText.trim())
              : draft.lineItems.some((lineItem) => lineItem.text.trim());
          const theme = cardThemes[contract.id] ?? {
            shell: "border-slate-300 bg-white shadow-[0_24px_60px_-28px_rgba(15,23,42,0.25)]",
            panel: "border-slate-200 bg-white/90",
            badge: "bg-slate-800 text-white hover:bg-slate-800",
          };

          return (
            <Card
              key={contract.id}
              data-tour={isFirstCard ? "submit-card-shell" : undefined}
              className={cn(
                "cursor-pointer border-2 transition-transform duration-200 hover:-translate-y-1 hover:shadow-2xl",
                theme.shell,
                draft.submitted && "border-slate-300 bg-gradient-to-br from-slate-100 via-slate-100 to-slate-200 text-slate-500 shadow-none saturate-50"
              )}
              onClick={() => setSelectedContractId(contract.id)}
            >
              <CardHeader className="space-y-3">
                <div className="flex items-start justify-between gap-4">
                  <div className="space-y-3 flex-1">
                    <Badge variant="secondary" className={cn("w-fit border-transparent", theme.badge)}>
                      {contract.category}
                    </Badge>
                    <CardTitle>{contract.contractName}</CardTitle>
                    {draft.submitted && (
                      <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-600">
                        Submitted{draft.submittedAt ? ` on ${draft.submittedAt}` : ""}
                      </p>
                    )}
                    <div className="overflow-hidden rounded-xl border border-black/10 bg-white">
                      <img
                        src={contract.imageUrl}
                        alt={contract.imageAlt}
                        className={cn("h-44 w-full object-cover", draft.submitted && "grayscale")}
                        loading="lazy"
                        referrerPolicy="no-referrer"
                      />
                    </div>
                    <CardDescription>Click the card background to view full submission history.</CardDescription>
                  </div>
                  <Button
                    type="button"
                    variant="outline"
                    className="shrink-0"
                    onClick={(event) => {
                      event.stopPropagation();
                      setSelectedActiveContractId(contract.id);
                    }}
                  >
                    Active contract
                  </Button>
                  <Button
                    type="button"
                    variant="ghost"
                    className="shrink-0"
                    data-tour={isFirstCard ? "submit-card-history-button" : undefined}
                    onClick={(event) => {
                      event.stopPropagation();
                      setSelectedContractId(contract.id);
                    }}
                  >
                    View history
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-5">
                <div
                  className={cn("space-y-2 rounded-xl border p-4", theme.panel)}
                  data-tour={isFirstCard ? "submit-card-previous-week" : undefined}
                >
                  <p className="text-xs font-semibold uppercase tracking-[0.12em] text-slate-500">
                    Previous Week Submission
                  </p>
                  <p className="text-sm font-medium text-slate-900">{contract.previousWeekLabel}</p>
                  <p className="text-sm leading-6 text-slate-700">{contract.previousWeekSubmission}</p>
                </div>

                <div
                  className="space-y-2"
                  data-tour={isFirstCard ? "submit-card-current-update" : undefined}
                  onClick={(event) => event.stopPropagation()}
                >
                  <div className="flex items-center justify-between gap-3">
                    <p className="text-sm font-semibold text-slate-900">Current Update</p>
                    {draft.noUpdate && (
                      <span className="text-xs font-medium text-slate-500">Marked as no update</span>
                    )}
                  </div>
                  {isEnhancedModeEnabled ? (
                    <Tabs
                      value={draft.submissionMode}
                      onValueChange={(value) =>
                        patchSimpleDraft(contract.id, {
                          submissionMode: value as "SIMPLE" | "DETAILED",
                        })
                      }
                    >
                      <div className="rounded-xl border border-slate-200 bg-white/70 p-3">
                        <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                          <div>
                            <p className="text-sm font-semibold text-slate-900">Choose submission structure</p>
                            <p className="text-xs text-slate-500">
                              Start simple to reduce field overload, then switch to detailed if you need funding, risk, owner, or due-date tracking.
                            </p>
                          </div>
                          <TabsList data-tour={isFirstCard ? "submit-card-mode-tabs" : undefined}>
                            <TabsTrigger value="SIMPLE">Simple</TabsTrigger>
                            <TabsTrigger
                              value="DETAILED"
                              data-tour={isFirstCard ? "submit-card-detailed-tab" : undefined}
                            >
                              Detailed
                            </TabsTrigger>
                          </TabsList>
                        </div>
                      </div>

                      <TabsContent value="SIMPLE">
                        {renderSimpleSubmission(contract, draft, isFirstCard)}
                      </TabsContent>
                      <TabsContent value="DETAILED">
                        {renderEnhancedLineItems(contract, draft, isFirstCard)}
                      </TabsContent>
                    </Tabs>
                  ) : (
                    renderBasicLineItems(contract, draft, isFirstCard)
                  )}
                </div>

                <div
                  className="flex flex-wrap items-center justify-between gap-3"
                  data-tour={isFirstCard ? "submit-card-actions" : undefined}
                  onClick={(event) => event.stopPropagation()}
                >
                  <div className="flex flex-wrap items-center gap-2">
                    {isEnhancedModeEnabled && !draft.submitted && (
                      <Button
                        type="button"
                        variant="outline"
                        data-tour={isFirstCard ? "submit-card-carry-forward" : undefined}
                        disabled={draft.noUpdate || draft.submissionMode !== "DETAILED"}
                        onClick={() => carryForwardPreviousWeek(contract.id)}
                      >
                        Carry Forward Previous Week
                      </Button>
                    )}
                    <Button
                      type="button"
                      variant={draft.noUpdate ? "default" : "outline"}
                      disabled={draft.submitted}
                      data-tour={isFirstCard ? "submit-card-no-update-button" : undefined}
                      onClick={() => toggleNoUpdate(contract.id)}
                    >
                      No Update
                    </Button>
                    {draft.submitted ? (
                      <Button
                        type="button"
                        variant="outline"
                        onClick={() => enableEditing(contract.id)}
                      >
                        Edit
                      </Button>
                    ) : (
                      <Button
                        type="button"
                        data-tour={isFirstCard ? "submit-card-submit-button" : undefined}
                        onClick={() => submitContract(contract.id)}
                        disabled={!hasDraftContent}
                      >
                        Submit
                      </Button>
                    )}
                  </div>
                  <p className="text-xs text-slate-500">
                    {draft.submitted
                      ? "Submitted cards are locked until Edit is selected."
                      : isEnhancedModeEnabled
                        ? draft.submissionMode === "SIMPLE"
                          ? "Simple mode keeps the submission lightweight with a single text field and severity tag."
                          : "Detailed mode tracks category, owner, due date, carry-forward items, and action flags."
                        : "Draft changes are for demo only."}
                  </p>
                </div>
              </CardContent>
            </Card>
          );
        })}
      </CardGrid>

      <Dialog open={Boolean(selectedContract)} onOpenChange={(open) => !open && setSelectedContractId(null)}>
        {selectedContract && (
          <DialogContent className="max-w-3xl">
            <DialogHeader>
              <div className="flex items-center gap-2">
                <Badge variant="secondary">{selectedContract.category}</Badge>
              </div>
              <DialogTitle>{selectedContract.contractName} History</DialogTitle>
              <DialogDescription>
                Historical submissions for this contract.
              </DialogDescription>
            </DialogHeader>

            <div className="overflow-hidden rounded-xl border border-slate-200 bg-slate-50">
              <img
                src={selectedContract.imageUrl}
                alt={selectedContract.imageAlt}
                className="h-56 w-full object-cover"
                loading="lazy"
                referrerPolicy="no-referrer"
              />
            </div>

            <div className="max-h-[65vh] space-y-4 overflow-y-auto pr-2">
              {selectedContract.history.map((entry) => (
                <div key={entry.id} className="rounded-lg border border-slate-200 p-4">
                  <div className="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                      <p className="text-sm font-semibold text-slate-900">Week of {entry.weekOf}</p>
                      <p className="text-xs text-slate-500">Submitted {entry.submittedAt}</p>
                    </div>
                    <Badge variant={entry.status === "APPROVED" ? "default" : "secondary"}>
                      {entry.status.replace("_", " ")}
                    </Badge>
                  </div>
                  <p className="mt-3 text-sm leading-6 text-slate-700">{entry.summary}</p>
                </div>
              ))}
            </div>
          </DialogContent>
        )}
      </Dialog>

      <CardWalkthrough
        steps={activeWalkthroughSteps}
        open={isWalkthroughOpen}
        onClose={handleWalkthroughClose}
      />

      <Dialog
        open={Boolean(selectedActiveContractId)}
        onOpenChange={(open) => !open && setSelectedActiveContractId(null)}
      >
        {selectedActiveContractId && selectedActiveContract && (
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>Current Active Contract</DialogTitle>
              <DialogDescription>
                Track the current active contract details for this card.
              </DialogDescription>
            </DialogHeader>

            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2 md:col-span-2">
                <p className="text-xs font-medium text-slate-500">Contract Name</p>
                <Input
                  value={selectedActiveContract.contractName}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "contractName", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">COR</p>
                <Input
                  value={selectedActiveContract.cor}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "cor", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">Contract Number</p>
                <Input
                  value={selectedActiveContract.contractNumber}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "contractNumber", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">Office</p>
                <Input
                  value={selectedActiveContract.office}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "office", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">Next Period of Perf.</p>
                <Input
                  value={selectedActiveContract.nextPeriodOfPerf}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "nextPeriodOfPerf", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">Ultimate Completion Date</p>
                <Input
                  value={selectedActiveContract.ultimateCompletionDate}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "ultimateCompletionDate", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">CO</p>
                <Input
                  value={selectedActiveContract.co}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "co", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">CS</p>
                <Input
                  value={selectedActiveContract.cs}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "cs", event.target.value)
                  }
                />
              </div>
              <div className="space-y-2">
                <p className="text-xs font-medium text-slate-500">Order Number</p>
                <Input
                  value={selectedActiveContract.orderNumber}
                  onChange={(event) =>
                    updateActiveContractField(selectedActiveContractId, "orderNumber", event.target.value)
                  }
                />
              </div>
            </div>

            <DialogFooter>
              <Button type="button" onClick={() => setSelectedActiveContractId(null)}>
                Save
              </Button>
            </DialogFooter>
          </DialogContent>
        )}
      </Dialog>
    </TooltipProvider>
  );
}