"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
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
import { getCurrentSubmissionPeriod, isSubmissionWindowOpen } from "@/lib/submission-periods";

interface ContractUpdateCardsProps {
  contracts: MockContract[];
  enhancedEditorEnabled?: boolean;
  submissionsEnabled?: boolean;
  deadlineOverrideEnabled?: boolean;
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
  actionRequired: boolean;
  carryForward: boolean;
}

interface DraftState {
  submissionMode: "SIMPLE" | "DETAILED";
  simpleText: string;
  simpleStatus: LineItemStatus;
  lineItems: DraftLineItem[];
  noUpdate: boolean;
  submitted: boolean;
  submittedAt: string | null;
  reviewSubmissionId: string | null;
  historyEntryId: string | null;
  reopenedAfterDeadline?: boolean;
  deadlineLocked?: boolean;
}

type ActiveContractState = Record<string, ActiveContractDetails & { categorySwitch?: string }>;

const categoryOptions: Array<{ value: LineItemCategory; label: string; description: string }> = [
  { value: "GENERAL", label: "General", description: "Overall contract progress and notable changes." },
  { value: "FUNDING", label: "Funding", description: "Budget execution, shortfalls, and allocation updates." },
  { value: "ACTION", label: "Action", description: "Tasks and follow-up actions requiring completion." },
  { value: "RISK", label: "Risk", description: "Items that may impact schedule, scope, or performance." },
  { value: "DECISION", label: "Decision", description: "Leadership decisions needed to move work forward." },
  { value: "MEETING", label: "Meeting", description: "Coordination outcomes and upcoming meeting priorities." },
];

const PALT_MATRIX: Record<string, Record<string, string[]>> = {
  "Simplified Acquisitions Procedures": {
    "Micropurchase": ["5", "5", "5", "5", "N/A", "N/A", "5"],
    "Above Micro & Under SAT": ["15", "15", "10", "10", "7", "8", "10"],
    "Above SAT- $6.5M (Commercial Test Procedures)": ["45", "45", "30", "20", "15", "15", "30"],
  },
  "FSS/GSA Order Including BPA Orders (no SOW)": {
    "Micropurchase": ["5", "5", "5", "5", "5", "5", "10"],
    "Above Micro & Under SAT": ["15", "15", "10", "10", "10", "5", "10"],
    "Over SAT": ["30", "30", "15", "15", "15", "15", "30"],
  },
  "FSS/GSA Order Including BPA Orders (w/SOW)": {
    "Micropurchase": ["5", "5", "5", "5", "5", "5", "10"],
    "Above Micro & Under SAT": ["30", "30", "15", "10", "10", "10", "15"],
    "Over SAT": ["45", "45", "15", "15", "15", "15", "30"],
  },
  "Sealed Bids Including 2 Step": {
    "Up to $1M": ["30", "30", "15", "30", "15", "15", "15"],
    "Above $1M up to $10M": ["45", "45", "30", "30", "30", "30", "30"],
    "Over $10M": ["60", "60", "30", "45", "45", "30", "30"],
  },
  "Competitive Proposals (RFP)": {
    "Up to $1M": ["45", "45", "30", "30", "15", "15", "30"],
    "Above $1M up to $10M": ["60", "60", "30", "30", "30", "30", "30"],
    "Over $10M": ["90", "60", "45", "30", "45", "30", "60"],
  },
};

const PALT_PROCUREMENT_TYPES = Object.keys(PALT_MATRIX);

const PALT_DOLLAR_VALUES_BY_PROCUREMENT: Record<string, string[]> = Object.fromEntries(
  Object.entries(PALT_MATRIX).map(([procurementType, values]) => [
    procurementType,
    Object.keys(values),
  ])
);

const PALT_MILESTONE_LABELS = [
  "OITO Engagement Ends",
  "Acquisition Planning Complete",
  "Procurement Package Complete",
  "Solicitation Issued",
  "Proposals Received",
  "Tech Evaluations Complete",
  "Final Proposals Received",
  "Award Complete",
];

function getPaltMilestoneDays(contract: ActiveContractDetails): string[] {
  const procurementType = contract.paltProcurementType || "";
  const dollarValue = contract.paltDollarValue || "";
  const rowValues = PALT_MATRIX[procurementType]?.[dollarValue];

  return rowValues || ["15", "15", "10", "10", "7", "8", "10"];
}

function getPaltDollarValues(procurementType?: string) {
  return PALT_DOLLAR_VALUES_BY_PROCUREMENT[procurementType || ""] || [];
}

function getPaltMilestoneSequence(contract: ActiveContractDetails) {
  const milestoneDays = getPaltMilestoneDays(contract);
  const procurementType = contract.paltProcurementType || "";
  const dollarValue = contract.paltDollarValue || "";

  if (procurementType === "Simplified Acquisitions Procedures" && dollarValue === "Micropurchase") {
    return [
      { milestone: "OITO Engagement Ends", days: milestoneDays[0] || "" },
      { milestone: "Acquisition Planning Complete", days: milestoneDays[1] || "" },
      { milestone: "Procurement Package Complete", days: milestoneDays[2] || "" },
      { milestone: "Solicitation Issued", days: milestoneDays[3] || "" },
      { milestone: "Proposals Received", days: milestoneDays[6] || "" },
      { milestone: "Award Complete", days: "End Date" },
    ];
  }

  return PALT_MILESTONE_LABELS.map((milestone, index) => ({
    milestone,
    days: index === PALT_MILESTONE_LABELS.length - 1 ? "End Date" : milestoneDays[index] || "",
  }));
}

type PaltMilestoneRow = {
  id: number;
  milestone: string;
  dueDate: string;
  days: string;
};

function addDaysToIsoDate(dateValue: string, daysValue: string) {
  const days = Number.parseInt(daysValue, 10);
  if (!dateValue || Number.isNaN(days)) {
    return "";
  }

  const parsed = new Date(`${dateValue}T00:00:00`);
  if (Number.isNaN(parsed.getTime())) {
    return "";
  }

  parsed.setDate(parsed.getDate() + days);
  return parsed.toISOString().slice(0, 10);
}

function applyCalculatedPaltDueDates(rows: PaltMilestoneRow[], startIndex = 1): PaltMilestoneRow[] {
  if (rows.length === 0) {
    return rows;
  }

  const nextRows = rows.map((row) => ({ ...row }));

  for (let index = Math.max(1, startIndex); index < nextRows.length; index += 1) {
    const previousDueDate = nextRows[index - 1]?.dueDate || "";
    const previousDays = nextRows[index - 1]?.days || "";
    nextRows[index].dueDate = addDaysToIsoDate(previousDueDate, previousDays);
  }

  return nextRows;
}

function buildPaltMilestones(contract: ActiveContractDetails) {
  const milestoneSequence = getPaltMilestoneSequence(contract);
  const defaults = applyCalculatedPaltDueDates([
    { id: 0, milestone: "Begin OITO Engagement", dueDate: contract.paltBeginOitoEngagement || "", days: "90" },
    ...milestoneSequence.map(({ milestone, days }, index) => ({
      id: index + 1,
      milestone,
      dueDate: "",
      days,
    })),
  ]);

  if (!contract.paltMilestones) {
    return defaults;
  }

  try {
    const parsed = JSON.parse(contract.paltMilestones);
    if (!Array.isArray(parsed)) {
      return defaults;
    }

    const normalizedRows: PaltMilestoneRow[] = parsed.map((row, index) => ({
      id: typeof row?.id === "number" ? row.id : index,
      milestone: typeof row?.milestone === "string" ? row.milestone : defaults[index]?.milestone || `Milestone ${index + 1}`,
      dueDate: typeof row?.dueDate === "string" ? row.dueDate : "",
      days: typeof row?.days === "string" || typeof row?.days === "number" ? String(row.days) : defaults[index]?.days || "",
    }));

    return normalizedRows;
  } catch {
    return defaults;
  }
}

function FieldHintLabel({
  label,
  hint,
  dataTour,
}: {
  label: string;
  hint: string;
  dataTour?: string;
}) {
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

function createLineItem(
  text = "",
  options: Partial<Pick<DraftLineItem, "status" | "category" | "owner" | "dueDate" | "actionRequired" | "carryForward">> = {}
): DraftLineItem {
  return {
    id: `${Date.now()}-${Math.random().toString(36).slice(2, 10)}`,
    text,
    status: options.status ?? "NORMAL",
    category: options.category ?? "GENERAL",
    owner: options.owner ?? "",
    dueDate: options.dueDate ?? "",
    actionRequired: options.actionRequired ?? false,
    carryForward: options.carryForward ?? false,
  };
}

const RECOMPETES_CATEGORY = "New Awards and Recompetes";
const LEGACY_CATEGORY = "Legacy Contracts";
const OUTLOOK_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";
const PALT_MODE = "PALT";

function isContributorVisibleContract(category: string) {
  return category !== LEGACY_CATEGORY;
}

function getInitialCategorySwitch(contract: MockContract) {
  if (contract.activeContract.categorySwitch) {
    return contract.activeContract.categorySwitch;
  }

  if (contract.activeContract.palt) {
    return PALT_MODE;
  }

  if (contract.category === RECOMPETES_CATEGORY) {
    return "RECOMPETES";
  }

  return "CURRENT";
}

function getCurrentTableLabel(category: string) {
  if (category === LEGACY_CATEGORY) {
    return "Legacy Contracts";
  }

  if (category === RECOMPETES_CATEGORY) {
    return "New Awards and Recompetes";
  }

  return OUTLOOK_CATEGORY;
}

const statusStyles: Record<LineItemStatus | "NORMAL" | "RISK" | "CRITICAL", string> = {
  NORMAL: "border-emerald-200 bg-emerald-50 text-emerald-700",
  RISK: "border-amber-200 bg-amber-50 text-amber-700",
  CRITICAL: "border-rose-200 bg-rose-50 text-rose-700",
};

function getDraftSeverity(draft: DraftState): LineItemStatus {
  if (draft.submissionMode === "SIMPLE") {
    return draft.simpleStatus;
  }

  if (draft.lineItems.some((lineItem) => lineItem.status === "CRITICAL")) {
    return "CRITICAL";
  }

  if (draft.lineItems.some((lineItem) => lineItem.status === "RISK")) {
    return "RISK";
  }

  return "NORMAL";
}

const WALKTHROUGH_DISMISSED_KEY = "war-submit-card-walkthrough-dismissed";

export function ContractUpdateCards({
  contracts,
  enhancedEditorEnabled = true,
  submissionsEnabled = true,
  deadlineOverrideEnabled = false,
  userRole = "contributor", // "contributor" or "overseer"; default to contributor for demo
}: ContractUpdateCardsProps & { userRole?: "contributor" | "overseer" }) {
  const router = useRouter();
  const visibleContracts = useMemo(
    () =>
      userRole === "contributor"
        ? contracts.filter((contract) => isContributorVisibleContract(contract.category))
        : contracts,
    [contracts, userRole]
  );
  const referenceNow = useMemo(() => new Date(), []);
  const submissionWindowOpen = useMemo(
    () => isSubmissionWindowOpen(referenceNow),
    [referenceNow]
  );
  const schedulingOverrideActive = deadlineOverrideEnabled;
  const currentPeriod = useMemo(
    () => getCurrentSubmissionPeriod(referenceNow),
    [referenceNow]
  );

  function canEditDraft(draft: DraftState): boolean {
    if (draft.reviewSubmissionId) {
      // Always allow opening existing submissions in Edit mode first.
      // Server-side rules still enforce whether an update can be saved.
      return true;
    }

    return submissionsEnabled && (submissionWindowOpen || schedulingOverrideActive);
  }

  const initialDrafts = useMemo<Record<string, DraftState>>(
    () =>
      Object.fromEntries(
        visibleContracts.map((contract) => {
          const currentCycleEntry = contract.history.find((entry) => {
            const submittedAt = new Date(entry.submittedAt);
            return submittedAt >= currentPeriod.start && submittedAt <= currentPeriod.end;
          });

          const reopenedAfterDeadline =
            schedulingOverrideActive ||
            contract.latestFeedback?.status === "CHANGES_REQUESTED" ||
            contract.latestFeedback?.status === "INFO_NEEDED";
          const deadlineLocked = !submissionWindowOpen && !schedulingOverrideActive;

          return [
            contract.id,
            {
              submissionMode: "SIMPLE",
              simpleText: "",
              simpleStatus: "NORMAL",
              lineItems: [createLineItem()],
              noUpdate: false,
              submitted: Boolean(currentCycleEntry),
              submittedAt: currentCycleEntry ? currentCycleEntry.submittedAt : null,
              reviewSubmissionId: currentCycleEntry ? currentCycleEntry.id : null,
              historyEntryId: currentCycleEntry ? currentCycleEntry.id : null,
              reopenedAfterDeadline,
              deadlineLocked,
            },
          ];
        })
      ),
    [visibleContracts, currentPeriod.id, schedulingOverrideActive, submissionWindowOpen]
  );
  const [drafts, setDrafts] = useState<Record<string, DraftState>>(initialDrafts);
  const [selectedContractId, setSelectedContractId] = useState<string | null>(null);
  const [isEnhancedModeEnabled, setIsEnhancedModeEnabled] = useState(enhancedEditorEnabled);
  const cardDensity = "detailed";
  const [walkthroughVariant, setWalkthroughVariant] = useState<WalkthroughVariant | null>(null);
  const [selectedActiveContractId, setSelectedActiveContractId] = useState<string | null>(null);
  const [isSavingActiveContract, setIsSavingActiveContract] = useState(false);
  const [activeContractSaveError, setActiveContractSaveError] = useState<string | null>(null);
  const paltAutosaveSignatureRef = useRef<string | null>(null);
  const [activeContracts, setActiveContracts] = useState<ActiveContractState>(
    Object.fromEntries(
      visibleContracts.map((contract) => [
        contract.id,
        {
          ...contract.activeContract,
          categorySwitch: getInitialCategorySwitch(contract),
        },
      ])
    )
  );

  useEffect(() => {
    setDrafts(initialDrafts);
    setActiveContracts(
      Object.fromEntries(
        visibleContracts.map((contract) => [
          contract.id,
          {
            ...contract.activeContract,
            categorySwitch: getInitialCategorySwitch(contract),
          },
        ])
      )
    );
  }, [visibleContracts, initialDrafts]);

  const selectedContract =
    visibleContracts.find((contract) => contract.id === selectedContractId) ?? null;
  const selectedActiveContract = selectedActiveContractId
    ? activeContracts[selectedActiveContractId]
    : null;

  const firstContractId = visibleContracts[0]?.id ?? null;
  const cardThemes = useMemo<Record<string, { shell: string; panel: string; badge: string }>>(
    () =>
      Object.fromEntries(
        visibleContracts.map((contract) => {
          if (contract.category === RECOMPETES_CATEGORY) {
            return [contract.id, {
              shell: "border-sky-300 bg-sky-50 shadow-[0_24px_60px_-28px_rgba(14,165,233,0.2)]",
              panel: "border-sky-200 bg-sky-50/90",
              badge: "bg-sky-700 text-white hover:bg-sky-700",
            }];
          }

          if (contract.category === LEGACY_CATEGORY) {
            return [contract.id, {
              shell: "border-slate-300 bg-white shadow-[0_24px_60px_-28px_rgba(15,23,42,0.18)]",
              panel: "border-slate-200 bg-white/90",
              badge: "bg-slate-800 text-white hover:bg-slate-800",
            }];
          }

          return [contract.id, {
            shell: "border-emerald-300 bg-emerald-50 shadow-[0_24px_60px_-28px_rgba(16,185,129,0.18)]",
            panel: "border-emerald-200 bg-emerald-50/90",
            badge: "bg-emerald-700 text-white hover:bg-emerald-700",
          }];
        })
      ),
    [visibleContracts]
  );

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
          reviewSubmissionId: current.reviewSubmissionId,
          historyEntryId: current.historyEntryId,
        },
      };
    });
  }

  function carryForwardPreviousWeek(contractId: string) {
    const contract = visibleContracts.find((item) => item.id === contractId);

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

  async function submitContract(contractId: string) {
    const currentDraft = drafts[contractId];

    if (!currentDraft) {
      return;
    }

    if (!submissionsEnabled && !currentDraft.reviewSubmissionId) {
      return;
    }

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

    const summary =
      currentDraft.submissionMode === "SIMPLE"
        ? currentDraft.simpleText.trim()
        : currentDraft.lineItems
            .map((lineItem) => lineItem.text.trim())
            .filter(Boolean)
            .join("\n\n");

    if (summary) {
      try {
        const response = await fetch(`/api/contracts/${contractId}/wars`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            summary,
            status: "IN_REVIEW",
            submissionId: currentDraft.reviewSubmissionId,
            historyEntryId: currentDraft.historyEntryId,
          }),
        });

        if (!response.ok) {
          throw new Error("Failed to submit WAR update to review queue.");
        }

        const payload = await response.json().catch(() => null);
        const reviewSubmissionId = typeof payload?.submissionId === "string" ? payload.submissionId : null;
        const historyEntryId = typeof payload?.entry?.id === "string" ? payload.entry.id : null;

        setDrafts((prev) => ({
          ...prev,
          [contractId]: {
            ...prev[contractId],
            reviewSubmissionId: reviewSubmissionId ?? prev[contractId].reviewSubmissionId,
            historyEntryId: historyEntryId ?? prev[contractId].historyEntryId,
          },
        }));

        router.refresh();
      } catch (error) {
        console.error(error);
        setDrafts((prev) => ({
          ...prev,
          [contractId]: {
            ...prev[contractId],
            submitted: false,
            submittedAt: null,
          },
        }));
      }
    }

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

  const saveActiveContractDetails = useCallback(async ({ closeOnSuccess = true }: { closeOnSuccess?: boolean } = {}) => {
    if (!selectedActiveContractId || !selectedActiveContract) {
      return;
    }

    setIsSavingActiveContract(true);
    setActiveContractSaveError(null);

    try {
      const selectedContractFromList = visibleContracts.find((contract) => contract.id === selectedActiveContractId);

      const response = await fetch(`/api/contracts/${selectedActiveContractId}`, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contractName: selectedActiveContract.contractName,
          cor: selectedActiveContract.cor,
          contractNumber: selectedActiveContract.contractNumber,
          office: selectedActiveContract.office,
          nextPeriodOfPerf: selectedActiveContract.nextPeriodOfPerf,
          ultimateCompletionDate: selectedActiveContract.ultimateCompletionDate,
          co: selectedActiveContract.co,
          cs: selectedActiveContract.cs,
          orderNumber: selectedActiveContract.orderNumber,
          palt: selectedActiveContract.palt || "",
          paltProcurementType: selectedActiveContract.paltProcurementType || "",
          paltDollarValue: selectedActiveContract.paltDollarValue || "",
          paltBeginOitoEngagement: selectedActiveContract.paltBeginOitoEngagement || "",
          paltOitoEngagement: selectedActiveContract.paltOitoEngagement || "",
          paltMilestones: selectedActiveContract.paltMilestones || "",
          category: selectedContractFromList?.category ?? "Contract",
        }),
      });

      if (!response.ok) {
        const payload = await response.json().catch(() => ({}));
        throw new Error(payload?.error || "Failed to save active contract details.");
      }

      if (closeOnSuccess) {
        setSelectedActiveContractId(null);
      }
    } catch (error) {
      const message = error instanceof Error ? error.message : "Failed to save active contract details.";
      setActiveContractSaveError(message);
    } finally {
      setIsSavingActiveContract(false);
    }
  }, [selectedActiveContractId, selectedActiveContract, visibleContracts]);

  useEffect(() => {
    if (!selectedActiveContractId || !selectedActiveContract) {
      paltAutosaveSignatureRef.current = null;
      return;
    }

    if (userRole !== "contributor" || selectedActiveContract.categorySwitch !== PALT_MODE) {
      paltAutosaveSignatureRef.current = null;
      return;
    }

    const signature = JSON.stringify({
      paltProcurementType: selectedActiveContract.paltProcurementType || "",
      paltDollarValue: selectedActiveContract.paltDollarValue || "",
      paltBeginOitoEngagement: selectedActiveContract.paltBeginOitoEngagement || "",
      paltOitoEngagement: selectedActiveContract.paltOitoEngagement || "",
      paltMilestones: selectedActiveContract.paltMilestones || "",
    });

    if (!paltAutosaveSignatureRef.current) {
      paltAutosaveSignatureRef.current = signature;
      return;
    }

    if (paltAutosaveSignatureRef.current === signature) {
      return;
    }

    paltAutosaveSignatureRef.current = signature;

    const timer = window.setTimeout(() => {
      void saveActiveContractDetails({ closeOnSuccess: false });
    }, 800);

    return () => {
      window.clearTimeout(timer);
    };
  }, [selectedActiveContractId, selectedActiveContract, userRole, saveActiveContractDetails]);

  useEffect(() => {
    if (!selectedActiveContractId || !selectedActiveContract) {
      return;
    }

    if (selectedActiveContract.categorySwitch !== PALT_MODE) {
      return;
    }

    const validProcurementType = PALT_PROCUREMENT_TYPES.includes(selectedActiveContract.paltProcurementType || "")
      ? (selectedActiveContract.paltProcurementType || "")
      : PALT_PROCUREMENT_TYPES[0] || "";
    const validDollarValues = getPaltDollarValues(validProcurementType);
    const validDollarValue = validDollarValues.includes(selectedActiveContract.paltDollarValue || "")
      ? (selectedActiveContract.paltDollarValue || "")
      : validDollarValues[0] || "";

    if (
      validProcurementType !== (selectedActiveContract.paltProcurementType || "") ||
      validDollarValue !== (selectedActiveContract.paltDollarValue || "")
    ) {
      setActiveContracts((prev) => ({
        ...prev,
        [selectedActiveContractId]: {
          ...prev[selectedActiveContractId],
          paltProcurementType: validProcurementType,
          paltDollarValue: validDollarValue,
          paltMilestones: "",
        },
      }));
    }
  }, [selectedActiveContractId, selectedActiveContract]);

  function updatePaltMilestone(
    contractId: string,
    rowIndex: number,
    field: "dueDate" | "days",
    value: string
  ) {
    const current = activeContracts[contractId];
    if (!current) {
      return;
    }

    const rows = buildPaltMilestones(current);
    const nextRows = rows.map((row, index) =>
      index === rowIndex
        ? {
            ...row,
            [field]: value,
          }
        : row
    );

    const recalculatedRows = applyCalculatedPaltDueDates(nextRows, rowIndex + 1);

    updateActiveContractField(contractId, "paltMilestones", JSON.stringify(recalculatedRows));
    updateActiveContractField(contractId, "paltBeginOitoEngagement", recalculatedRows[0]?.dueDate || "");
    updateActiveContractField(contractId, "paltOitoEngagement", recalculatedRows[1]?.dueDate || "");
    updateActiveContractField(contractId, "ultimateCompletionDate", recalculatedRows[recalculatedRows.length - 1]?.dueDate || "");
  }

  function renderBasicLineItems(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    const isDraftLocked = draft.submitted || !canEditDraft(draft);

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
                    disabled={isDraftLocked}
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
                  disabled={isDraftLocked || draft.lineItems.length === 1}
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
              disabled={isDraftLocked}
              onChange={(event) => patchLineItem(contract.id, lineItem.id, { text: event.target.value })}
              onClick={(event) => event.stopPropagation()}
            />
          </div>
        ))}

        <Button
          type="button"
          variant="outline"
          disabled={isDraftLocked || draft.noUpdate}
          onClick={() => addLineItem(contract.id)}
        >
          Add Line Item
        </Button>
      </div>
    );
  }

  function renderSimpleSubmission(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    const isDraftLocked = draft.submitted || !canEditDraft(draft);

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
              disabled={isDraftLocked}
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
          disabled={isDraftLocked}
          onChange={(event) => patchSimpleDraft(contract.id, { simpleText: event.target.value })}
          onClick={(event) => event.stopPropagation()}
        />
      </div>
    );
  }

  function renderEnhancedLineItems(contract: MockContract, draft: DraftState, isFirstCard: boolean) {
    const isDraftLocked = draft.submitted || !canEditDraft(draft);

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
                  disabled={isDraftLocked || draft.noUpdate}
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
                          disabled={isDraftLocked || draft.lineItems.length === 1}
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
                            disabled={isDraftLocked}
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
                            disabled={isDraftLocked}
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
                            disabled={isDraftLocked}
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
                              disabled={isDraftLocked}
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
                              disabled={isDraftLocked}
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
                        disabled={isDraftLocked}
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
                disabled={!submissionsEnabled}
              />
            </label>
          </div>
        </div>
        {!submissionsEnabled && (
          <div className="mt-3 rounded-lg border border-amber-200 bg-amber-50 px-3 py-2 text-sm text-amber-900">
            Contributor submissions are currently turned off by the program overseer. You can still review card history.
          </div>
        )}
      </div>

      <CardGrid columns={2} gap="lg">
        {visibleContracts.map((contract, index) => {
          const isFirstCard = index === 0;
          const draft = drafts[contract.id] ?? {
            submissionMode: "SIMPLE",
            simpleText: "",
            simpleStatus: "NORMAL",
            lineItems: [createLineItem()],
            noUpdate: false,
            submitted: false,
            submittedAt: null,
            reviewSubmissionId: null,
            historyEntryId: null,
          };
          const hasDraftContent =
            draft.submissionMode === "SIMPLE"
              ? Boolean(draft.simpleText.trim())
              : draft.lineItems.some((lineItem) => lineItem.text.trim());
          const isDraftLocked = draft.submitted || !canEditDraft(draft);
          const draftSeverity = getDraftSeverity(draft);
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
                    <div className="flex flex-wrap items-center gap-2">
                      <Badge variant="secondary" className={cn("w-fit border-transparent", theme.badge)}>
                        {getCurrentTableLabel(contract.category)}
                      </Badge>
                      <span className={cn("rounded-full border px-2 py-0.5 text-[11px] font-semibold", statusStyles[draftSeverity])}>
                        {draftSeverity}
                      </span>
                      {draft.submittedAt && (
                        <span className="rounded-full border border-slate-200 bg-white px-2 py-0.5 text-[11px] font-medium text-slate-600">
                          Submitted {draft.submittedAt}
                        </span>
                      )}
                    </div>
                    <CardTitle>{contract.contractName}</CardTitle>
                    {cardDensity === "detailed" && (
                      <>
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
                      </>
                    )}
                  </div>
                  <div className="flex shrink-0 flex-col gap-2">
                    <Button
                      type="button"
                      variant="outline"
                      className="shrink-0"
                      onClick={(event) => {
                        event.stopPropagation();
                        setSelectedActiveContractId(contract.id);
                      }}
                    >
                      Contract details
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
                </div>
              </CardHeader>
              <CardContent className="space-y-5">
                {cardDensity === "detailed" && (
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
                )}

                {contract.latestFeedback?.comment ? (
                  <div className="rounded-xl border border-amber-300 bg-amber-50 p-4">
                    <p className="text-xs font-semibold uppercase tracking-[0.12em] text-amber-800">
                      Overseer Comment
                    </p>
                    <p className="mt-1 text-sm font-medium text-amber-900">
                      {contract.latestFeedback.status === "CHANGES_REQUESTED" || contract.latestFeedback.status === "INFO_NEEDED"
                        ? "Please review this comment and submit an updated WAR entry."
                        : "Reviewer feedback"}
                    </p>
                    <p className="mt-2 whitespace-pre-wrap text-sm leading-6 text-amber-900">
                      {contract.latestFeedback.comment}
                    </p>
                  </div>
                ) : null}

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
                      onValueChange={(value) => {
                        if (!submissionsEnabled) {
                          return;
                        }

                        patchSimpleDraft(contract.id, {
                          submissionMode: value as "SIMPLE" | "DETAILED",
                        });
                      }}
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
                        disabled={!submissionsEnabled || draft.noUpdate || draft.submissionMode !== "DETAILED"}
                        onClick={() => carryForwardPreviousWeek(contract.id)}
                      >
                        Carry Forward Previous Week
                      </Button>
                    )}
                    <Button
                      type="button"
                      variant={draft.noUpdate ? "default" : "outline"}
                      disabled={isDraftLocked}
                      data-tour={isFirstCard ? "submit-card-no-update-button" : undefined}
                      onClick={() => toggleNoUpdate(contract.id)}
                    >
                      No Update
                    </Button>
                    {draft.submitted ? (
                      <Button
                        type="button"
                        variant="outline"
                        disabled={!canEditDraft(draft)}
                        onClick={() => enableEditing(contract.id)}
                      >
                        Edit
                      </Button>
                    ) : (
                      <Button
                        type="button"
                        data-tour={isFirstCard ? "submit-card-submit-button" : undefined}
                        onClick={() => submitContract(contract.id)}
                        disabled={(!submissionsEnabled && !draft.reviewSubmissionId) || !hasDraftContent}
                      >
                        {draft.reviewSubmissionId ? "Update" : "Submit"}
                      </Button>
                    )}
                  </div>
                  <p className="text-xs text-slate-500">
                    {!submissionsEnabled
                      ? "Submission drafting is locked by settings. Contributors can still review contract history and prior context."
                      : draft.submitted
                      ? "Submitted cards are locked until Edit is selected."
                      : !submissionWindowOpen && !draft.reopenedAfterDeadline && !draft.reviewSubmissionId
                        ? "Submissions are only open on the 1st and 3rd Tuesday from 8:00 AM to 5:00 PM unless reopened by reviewer comment."
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
          <DialogContent className="max-w-3xl max-h-[90vh] overflow-y-auto">
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
        onOpenChange={(open) => {
          if (!open) {
            setSelectedActiveContractId(null);
            setActiveContractSaveError(null);
          }
        }}
      >
        {selectedActiveContractId && selectedActiveContract && (
          <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
            <DialogHeader>
              <div className="flex items-center justify-between">
                <DialogTitle>{selectedActiveContract.contractName || "Contract Details"}</DialogTitle>
                {/* Contributor controls */}
                <div className="flex items-center gap-2 mr-10">
                  <Select
                    value={selectedActiveContract.categorySwitch || "CURRENT"}
                    onValueChange={(value) => {
                      updateActiveContractField(selectedActiveContractId, "categorySwitch", value);
                    }}
                  >
                    <SelectTrigger className="w-[220px]">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="RECOMPETES">New Awards and Recompetes</SelectItem>
                      <SelectItem value="CURRENT">Current and Active Contracts/Purchase Order Outlook</SelectItem>
                      {userRole === "contributor" ? (
                        <SelectItem value={PALT_MODE}>PALT</SelectItem>
                      ) : null}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <DialogDescription>
                Track the current active contract details for this card.
              </DialogDescription>
            </DialogHeader>

            {/* Modal content changes based on dropdown selection */}
            <div className="grid gap-4 md:grid-cols-2">
              {selectedActiveContract.categorySwitch === PALT_MODE ? (
                <>
                  <div className="md:col-span-2 rounded-lg border border-slate-200 bg-slate-50 p-3">
                    <p className="text-xs font-semibold uppercase tracking-[0.08em] text-slate-500">PALT Inputs</p>
                  </div>
                  <div className="space-y-2">
                    <p className="text-xs font-medium text-slate-500">Procurement Type</p>
                    <Select
                      value={selectedActiveContract.paltProcurementType || undefined}
                      onValueChange={(value) => {
                        const nextDollarValues = getPaltDollarValues(value);
                        updateActiveContractField(selectedActiveContractId, "paltProcurementType", value);
                        updateActiveContractField(selectedActiveContractId, "paltDollarValue", nextDollarValues[0] || "");
                        updateActiveContractField(selectedActiveContractId, "paltMilestones", "");
                      }}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select procurement type" />
                      </SelectTrigger>
                      <SelectContent>
                        {PALT_PROCUREMENT_TYPES.map((option) => (
                          <SelectItem key={option} value={option}>
                            {option}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="space-y-2">
                    <p className="text-xs font-medium text-slate-500">Dollar Value</p>
                    <Select
                      value={selectedActiveContract.paltDollarValue || undefined}
                      onValueChange={(value) => {
                        updateActiveContractField(selectedActiveContractId, "paltDollarValue", value);
                        updateActiveContractField(selectedActiveContractId, "paltMilestones", "");
                      }}
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Select dollar value" />
                      </SelectTrigger>
                      <SelectContent>
                        {getPaltDollarValues(selectedActiveContract.paltProcurementType).map((option) => (
                          <SelectItem key={option} value={option}>
                            {option}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                  </div>

                  <div className="md:col-span-2 overflow-hidden rounded-lg border border-slate-200">
                    <table className="w-full text-sm">
                      <thead className="bg-slate-100 text-slate-700">
                        <tr>
                          <th className="px-2 py-2 text-left">#</th>
                          <th className="px-2 py-2 text-left">Milestone</th>
                          <th className="px-2 py-2 text-left">Due Date</th>
                          <th className="px-2 py-2 text-left"># Milestones Days</th>
                        </tr>
                      </thead>
                      <tbody>
                        {buildPaltMilestones(selectedActiveContract).map((row, index) => (
                          <tr key={`${row.id}-${row.milestone}`} className="border-t border-slate-200">
                            <td className="px-2 py-2 text-slate-600">{row.id}</td>
                            <td className="px-2 py-2 text-slate-800">{row.milestone}</td>
                            <td className="px-2 py-2">
                              <Input
                                type="date"
                                value={row.dueDate}
                                onChange={(event) =>
                                  updatePaltMilestone(selectedActiveContractId, index, "dueDate", event.target.value)
                                }
                              />
                            </td>
                            <td className="px-2 py-2">
                              {row.milestone === "Award Complete" ? (
                                <div className="px-3 py-2 text-sm text-slate-500">End Date</div>
                              ) : (
                                <Input
                                  type="text"
                                  inputMode="numeric"
                                  value={row.days}
                                  onChange={(event) =>
                                    updatePaltMilestone(selectedActiveContractId, index, "days", event.target.value)
                                  }
                                />
                              )}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </>
              ) : selectedActiveContract.categorySwitch === "RECOMPETES" ? (
                <>
                  {(() => {
                    const isOnTable = visibleContracts.some(c => c.id === selectedActiveContractId && getCurrentTableLabel(c.category) === "New Awards and Recompetes");
                    const isLocked = userRole === "contributor" && !isOnTable;
                    const labels: Record<string, string> = {
                      contractName: "Upcoming Procurement",
                      cor: "COR",
                      contractNumber: "Contract Number",
                      office: "Office",
                      nextPeriodOfPerf: "Next Period of Perf.",
                      ultimateCompletionDate: "Contract End Date",
                      co: "CO",
                      cs: "CS",
                      orderNumber: "Order Number",
                      paltProcurementType: "PALT Procurement Type",
                      paltDollarValue: "PALT Dollar Value",
                      paltBeginOitoEngagement: "Begin OITO Engagement",
                      paltOitoEngagement: "OITO Engagement",
                      paltMilestones: "PALT Milestones",
                      solicitationNumber: "Solicitation Number",
                      anticipatedAwardDate: "Anticipated Award Date",
                      notes: "Notes"
                    };
                    return (
                      <>
                        {isLocked && (
                          <div className="mb-2 flex items-center gap-2 text-amber-700 text-xs font-medium">
                            <span role="img" aria-label="locked">🔒</span> This contract is not editable in this view.
                          </div>
                        )}
                        {Object.entries(selectedActiveContract).map(([key, value]) => {
                          if (
                            [
                              "id",
                              "categorySwitch",
                              "palt",
                              "paltProcurementType",
                              "paltDollarValue",
                              "paltBeginOitoEngagement",
                              "paltOitoEngagement",
                              "paltMilestones",
                            ].includes(key)
                          ) return null;
                          return (
                            <div className="space-y-2" key={key}>
                              <p className="text-xs font-medium text-slate-500">{labels[key] || key}</p>
                              <Input
                                value={value || ""}
                                onChange={event => updateActiveContractField(selectedActiveContractId, key, event.target.value)}
                                disabled={isLocked}
                                className={isLocked ? "bg-slate-100 text-slate-400 cursor-not-allowed" : ""}
                              />
                            </div>
                          );
                        })}
                      </>
                    );
                  })()}
                </>
              ) : (
                <>
                  {(() => {
                    const isOnTable = visibleContracts.some(c => c.id === selectedActiveContractId && getCurrentTableLabel(c.category) === "Current and Active Contracts/Purchase Order Outlook");
                    const isLocked = userRole === "contributor" && !isOnTable;
                    const labels: Record<string, string> = {
                      contractName: "Contract Name",
                      cor: "COR",
                      contractNumber: "Contract Number",
                      office: "Office",
                      nextPeriodOfPerf: "Next Period of Perf.",
                      ultimateCompletionDate: "Ultimate Completion Date",
                      co: "CO",
                      cs: "CS",
                      orderNumber: "Order Number",
                      paltProcurementType: "PALT Procurement Type",
                      paltDollarValue: "PALT Dollar Value",
                      paltBeginOitoEngagement: "Begin OITO Engagement",
                      paltOitoEngagement: "OITO Engagement",
                      paltMilestones: "PALT Milestones",
                      solicitationNumber: "Solicitation Number",
                      anticipatedAwardDate: "Anticipated Award Date",
                      notes: "Notes"
                    };
                    return (
                      <>
                        {isLocked && (
                          <div className="mb-2 flex items-center gap-2 text-amber-700 text-xs font-medium">
                            <span role="img" aria-label="locked">🔒</span> This contract is not editable in this view.
                          </div>
                        )}
                        {Object.entries(selectedActiveContract).map(([key, value]) => {
                          if (
                            [
                              "id",
                              "categorySwitch",
                              "palt",
                              "paltProcurementType",
                              "paltDollarValue",
                              "paltBeginOitoEngagement",
                              "paltOitoEngagement",
                              "paltMilestones",
                            ].includes(key)
                          ) return null;
                          return (
                            <div className="space-y-2" key={key}>
                              <p className="text-xs font-medium text-slate-500">{labels[key] || key}</p>
                              <Input
                                value={value || ""}
                                onChange={event => updateActiveContractField(selectedActiveContractId, key, event.target.value)}
                                disabled={isLocked}
                                className={isLocked ? "bg-slate-100 text-slate-400 cursor-not-allowed" : ""}
                              />
                            </div>
                          );
                        })}
                      </>
                    );
                  })()}
                </>
              )}
            </div>

            <DialogFooter>
              {activeContractSaveError && (
                <p className="mr-auto text-sm text-rose-600">{activeContractSaveError}</p>
              )}
              <Button
                type="button"
                onClick={saveActiveContractDetails}
                disabled={isSavingActiveContract}
              >
                Save
              </Button>
            </DialogFooter>
          </DialogContent>
        )}
      </Dialog>
    </TooltipProvider>
  );
}