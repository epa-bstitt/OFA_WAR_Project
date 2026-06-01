import { prisma } from "@/lib/db";
import { getCurrentSubmissionPeriod, isSubmissionWindowOpen } from "@/lib/submission-periods";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";
import {
  getContractsOutlook as getMockContractsOutlook,
  type ContractFormInput,
  type MockContract,
  type MockContractSubmission,
} from "@/lib/mock-contracts";
import { getCurrentBiWeek, getBiWeekDate } from "@/lib/date-utils";

interface ContractMetadata {
  category?: string;
  activeContract?: {
    contractName?: string;
    cor?: string;
    contractNumber?: string;
    office?: string;
    nextPeriodOfPerf?: string;
    ultimateCompletionDate?: string;
    co?: string;
    cs?: string;
    orderNumber?: string;
    palt?: string;
    paltProcurementType?: string;
    paltDollarValue?: string;
    paltBeginOitoEngagement?: string;
    paltOitoEngagement?: string;
    paltMilestones?: string;
  };
  imageUrl?: string;
  imageAlt?: string;
  currentUpdatePlaceholder?: string;
}

const DEFAULT_IMAGE_URL =
  "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80";
const DEFAULT_IMAGE_ALT = "Contract and acquisition planning documents on an office desk.";
const DEFAULT_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";
const DEMO_CONTRIBUTOR_ID = "demo-contributor";
const DEMO_CONTRIBUTOR_EMAIL = "contributor@demo.epa.gov";
const DEMO_CONTRIBUTOR_NAME = "Contributor";

function toIsoDate(value: Date) {
  return value.toISOString().slice(0, 10);
}

function toWeekLabel(value: Date) {
  return value.toLocaleDateString("en-US", { month: "2-digit", day: "2-digit" });
}

function parseMetadata(project: { name: string; description: string | null }): Required<ContractMetadata> {
  const fallback: Required<ContractMetadata> = {
    category: DEFAULT_CATEGORY,
    activeContract: {
      contractName: project.name,
      cor: "",
      contractNumber: "",
      office: "",
      nextPeriodOfPerf: "",
      ultimateCompletionDate: "",
      co: "",
      cs: "",
      orderNumber: "",
      palt: "",
      paltProcurementType: "",
      paltDollarValue: "",
      paltBeginOitoEngagement: "",
      paltOitoEngagement: "",
      paltMilestones: "",
    },
    imageUrl: DEFAULT_IMAGE_URL,
    imageAlt: DEFAULT_IMAGE_ALT,
    currentUpdatePlaceholder: `Add this week's ${project.name} contract update here.`,
  };

  if (!project.description) {
    return fallback;
  }

  try {
    const parsed = JSON.parse(project.description) as ContractMetadata;
    return {
      category: parsed.category ?? fallback.category,
      activeContract: {
        contractName: parsed.activeContract?.contractName ?? project.name,
        cor: parsed.activeContract?.cor ?? "",
        contractNumber: parsed.activeContract?.contractNumber ?? "",
        office: parsed.activeContract?.office ?? "",
        nextPeriodOfPerf: parsed.activeContract?.nextPeriodOfPerf ?? "",
        ultimateCompletionDate: parsed.activeContract?.ultimateCompletionDate ?? "",
        co: parsed.activeContract?.co ?? "",
        cs: parsed.activeContract?.cs ?? "",
        orderNumber: parsed.activeContract?.orderNumber ?? "",
        palt: parsed.activeContract?.palt ?? "",
        paltProcurementType: parsed.activeContract?.paltProcurementType ?? "",
        paltDollarValue: parsed.activeContract?.paltDollarValue ?? "",
        paltBeginOitoEngagement: parsed.activeContract?.paltBeginOitoEngagement ?? "",
        paltOitoEngagement: parsed.activeContract?.paltOitoEngagement ?? "",
        paltMilestones: parsed.activeContract?.paltMilestones ?? "",
      },
      imageUrl: parsed.imageUrl ?? fallback.imageUrl,
      imageAlt: parsed.imageAlt ?? fallback.imageAlt,
      currentUpdatePlaceholder: parsed.currentUpdatePlaceholder ?? fallback.currentUpdatePlaceholder,
    };
  } catch {
    return fallback;
  }
}

function buildMetadata(input: ContractFormInput) {
  return JSON.stringify({
    category: input.category ?? DEFAULT_CATEGORY,
    activeContract: {
      contractName: input.contractName,
      cor: input.cor,
      contractNumber: input.contractNumber,
      office: input.office,
      nextPeriodOfPerf: input.nextPeriodOfPerf,
      ultimateCompletionDate: input.ultimateCompletionDate,
      co: input.co,
      cs: input.cs,
      orderNumber: input.orderNumber,
      palt: input.palt ?? "",
      paltProcurementType: input.paltProcurementType ?? "",
      paltDollarValue: input.paltDollarValue ?? "",
      paltBeginOitoEngagement: input.paltBeginOitoEngagement ?? "",
      paltOitoEngagement: input.paltOitoEngagement ?? "",
      paltMilestones: input.paltMilestones ?? "",
    },
    imageUrl: DEFAULT_IMAGE_URL,
    imageAlt: DEFAULT_IMAGE_ALT,
    currentUpdatePlaceholder: `Add this week's ${input.contractName} contract update here.`,
  });
}

function normalizeAssigneeIds(assigneeIds?: string[]) {
  const seen = new Set<string>();
  const normalized: string[] = [];

  for (const value of assigneeIds ?? []) {
    const id = value.trim();
    if (!id || seen.has(id)) {
      continue;
    }

    seen.add(id);
    normalized.push(id);
  }

  return normalized;
}

function mapSubmissionToWarEntry(submission: {
  id: string;
  weekOf: Date;
  createdAt: Date;
  rawText: string;
  status: string;
}): MockContractSubmission {
  return {
    id: submission.id,
    weekOf: toWeekLabel(submission.weekOf),
    submittedAt: toIsoDate(submission.createdAt),
    status: submission.status === "APPROVED" ? "APPROVED" : "IN_REVIEW",
    summary: submission.rawText,
  };
}

function sortByMostRecent<T extends { createdAt: Date; updatedAt?: Date }>(entries: T[]): T[] {
  return [...entries].sort((a, b) => {
    const aTime = (a.updatedAt ?? a.createdAt).getTime();
    const bTime = (b.updatedAt ?? b.createdAt).getTime();
    return bTime - aTime;
  });
}

function collapseToLatestBiWeeklySubmission<
  T extends { weekOf: Date; createdAt: Date; updatedAt?: Date }
>(submissions: T[]): T[] {
  const ordered = sortByMostRecent(submissions);
  const seenPeriodIds = new Set<string>();
  const collapsed: T[] = [];

  for (const submission of ordered) {
    const periodId = getCurrentSubmissionPeriod(submission.weekOf).id;
    if (seenPeriodIds.has(periodId)) {
      continue;
    }

    seenPeriodIds.add(periodId);
    collapsed.push(submission);
  }

  return collapsed;
}

function parseLatestFeedback(submission: {
  reviews?: Array<{ status: string; comment: string | null; createdAt: Date }>;
}) {
  const latestReview = submission.reviews?.[0];
  if (!latestReview?.comment?.trim()) {
    return null;
  }

  return {
    comment: latestReview.comment.trim(),
    status: latestReview.status,
    createdAt: latestReview.createdAt.toISOString(),
  };
}

async function ensureUserRecord(userId: string, name?: string | null, email?: string | null) {
  const normalizedId = userId.trim();
  if (!normalizedId) {
    return;
  }

  const userEmail = email?.trim() || `${normalizedId}@demo.epa.gov`;

  await prisma.user.upsert({
    where: { id: normalizedId },
    update: {
      email: userEmail,
      name: name ?? undefined,
      azureAdId: normalizedId,
      role: "CONTRIBUTOR",
      isActive: true,
    },
    create: {
      id: normalizedId,
      email: userEmail,
      name: name ?? null,
      azureAdId: normalizedId,
      role: "CONTRIBUTOR",
      isActive: true,
    },
  });
}

async function seedIfEmpty() {
  const count = await prisma.project.count();
  if (count > 0) {
    return;
  }

  const seedContracts = getMockContractsOutlook();

  for (const contract of seedContracts) {
    const primaryAssigneeId = contract.assigneeIds?.[0] ?? null;
    if (primaryAssigneeId) {
      await ensureUserRecord(primaryAssigneeId, primaryAssigneeId, null);
    }

    const created = await prisma.project.create({
      data: {
        id: contract.id,
        name: contract.contractName,
        description: JSON.stringify({
          category: contract.category,
          activeContract: contract.activeContract,
          imageUrl: contract.imageUrl,
          imageAlt: contract.imageAlt,
          currentUpdatePlaceholder: contract.currentUpdatePlaceholder,
        }),
        status: "ACTIVE",
      },
    });

    if (primaryAssigneeId) {
      await prisma.projectAssignment.create({
        data: {
          userId: primaryAssigneeId,
          projectId: created.id,
          componentId: null,
        },
      });
    }

    for (const history of contract.history) {
      const historyUserId = primaryAssigneeId ?? "demo-contributor";
      await ensureUserRecord(historyUserId, historyUserId, null);
      const createdAt = new Date(history.submittedAt);
      await prisma.submission.create({
        data: {
          userId: historyUserId,
          projectId: created.id,
          weekOf: createdAt,
          rawText: history.summary,
          status: history.status === "APPROVED" ? "APPROVED" : "IN_REVIEW",
          isAiGenerated: false,
          createdAt,
          updatedAt: createdAt,
        },
      });
    }
  }
}

async function ensureDemoContributorData() {
  await ensureUserRecord(DEMO_CONTRIBUTOR_ID, DEMO_CONTRIBUTOR_NAME, DEMO_CONTRIBUTOR_EMAIL);

  const projects = await prisma.project.findMany({
    where: {
      status: { not: "COMPLETED" },
    },
    orderBy: {
      name: "asc",
    },
    select: {
      id: true,
      name: true,
    },
    take: 3,
  });

  if (projects.length === 0) {
    return;
  }

  for (const [index, project] of projects.entries()) {
    const existingAssignment = await prisma.projectAssignment.findFirst({
      where: {
        projectId: project.id,
        userId: DEMO_CONTRIBUTOR_ID,
        componentId: null,
      },
      select: { id: true },
    });

    if (!existingAssignment) {
      await prisma.projectAssignment.create({
        data: {
          userId: DEMO_CONTRIBUTOR_ID,
          projectId: project.id,
          componentId: null,
        },
      });
    }

    const existingUserWarCount = await prisma.submission.count({
      where: {
        userId: DEMO_CONTRIBUTOR_ID,
        projectId: project.id,
        deletedAt: null,
      },
    });

    if (existingUserWarCount > 0) {
      continue;
    }

    const currentYear = new Date().getFullYear();
    const biWeek = getCurrentBiWeek();
    const mostRecentWeek = getBiWeekDate(Math.max(1, biWeek), currentYear);
    const previousWeek = getBiWeekDate(Math.max(1, biWeek - 1), currentYear);

    await prisma.submission.createMany({
      data: [
        {
          userId: DEMO_CONTRIBUTOR_ID,
          projectId: project.id,
          weekOf: previousWeek,
          rawText: `Status update for ${project.name}: requirements review and milestone planning completed.`,
          status: "IN_REVIEW",
          isAiGenerated: false,
        },
        {
          userId: DEMO_CONTRIBUTOR_ID,
          projectId: project.id,
          weekOf: mostRecentWeek,
          rawText: `WAR update for ${project.name}: draft deliverables submitted and awaiting Program Overseer review.`,
          status: index % 2 === 0 ? "SUBMITTED" : "IN_REVIEW",
          isAiGenerated: false,
        },
      ],
    });
  }
}

async function fetchContracts() {
  await seedIfEmpty();
  await ensureDemoContributorData();

  const projects = await prisma.project.findMany({
    where: {
      status: { not: "COMPLETED" },
    },
    include: {
      assignments: {
        where: {
          componentId: null,
        },
        orderBy: {
          assignedAt: "asc",
        },
        select: {
          userId: true,
        },
      },
      submissions: {
        where: {
          deletedAt: null,
        },
        orderBy: {
          createdAt: "desc",
        },
        select: {
          id: true,
          weekOf: true,
          createdAt: true,
          updatedAt: true,
          rawText: true,
          status: true,
          reviews: {
            orderBy: {
              createdAt: "desc",
            },
            take: 1,
            select: {
              status: true,
              comment: true,
              createdAt: true,
            },
          },
        },
      },
    },
    orderBy: {
      name: "asc",
    },
  });

  return projects.map((project) => {
    const metadata = parseMetadata(project);
    const latestPerBiWeek = collapseToLatestBiWeeklySubmission(project.submissions);
    const history = latestPerBiWeek.map(mapSubmissionToWarEntry);
    const latest = history[0];
    const latestFeedback = parseLatestFeedback(latestPerBiWeek[0]);

    return {
      id: project.id,
      category: metadata.category,
      assigneeIds: project.assignments.map((assignment) => assignment.userId),
      contractName: project.name,
      imageUrl: metadata.imageUrl,
      imageAlt: metadata.imageAlt,
      activeContract: {
        contractName: metadata.activeContract.contractName,
        cor: metadata.activeContract.cor,
        contractNumber: metadata.activeContract.contractNumber,
        office: metadata.activeContract.office,
        nextPeriodOfPerf: metadata.activeContract.nextPeriodOfPerf,
        ultimateCompletionDate: metadata.activeContract.ultimateCompletionDate,
        co: metadata.activeContract.co,
        cs: metadata.activeContract.cs,
        orderNumber: metadata.activeContract.orderNumber,
        palt: metadata.activeContract.palt,
        paltProcurementType: metadata.activeContract.paltProcurementType,
        paltDollarValue: metadata.activeContract.paltDollarValue,
        paltBeginOitoEngagement: metadata.activeContract.paltBeginOitoEngagement,
        paltOitoEngagement: metadata.activeContract.paltOitoEngagement,
        paltMilestones: metadata.activeContract.paltMilestones,
      },
      previousWeekLabel: latest ? `Week of ${latest.weekOf}` : "Week of N/A",
      previousWeekSubmission: latest?.summary ?? "No prior submission yet.",
      currentUpdatePlaceholder: metadata.currentUpdatePlaceholder,
      history,
      latestFeedback,
    } satisfies MockContract;
  });
}

export async function getContractsOutlookFromDb(): Promise<MockContract[]> {
  return fetchContracts();
}

export async function getMockContractsForUserFromDb(userId: string): Promise<MockContract[]> {
  const contracts = await fetchContracts();
  if (userId === "demo-admin" || userId === "demo-overseer" || userId === "demo-aggregator") {
    return contracts;
  }

  // Contributor-facing cards should only include active non-legacy assignments.
  return contracts.filter(
    (contract) =>
      contract.category !== "Legacy Contracts" &&
      contract.category !== "Completed" &&
      (contract.assigneeIds ?? []).includes(userId)
  );
}

export async function getContractByIdFromDb(contractId: string): Promise<MockContract | null> {
  const contracts = await fetchContracts();
  return contracts.find((contract) => contract.id === contractId) ?? null;
}

export async function createContractInDb(input: ContractFormInput): Promise<MockContract> {
  const normalizedAssigneeIds = normalizeAssigneeIds(input.assigneeIds);
  for (const assigneeId of normalizedAssigneeIds) {
    await ensureUserRecord(assigneeId, assigneeId, null);
  }

  const created = await prisma.project.create({
    data: {
      name: input.contractName,
      description: buildMetadata(input),
      status: "ACTIVE",
    },
  });

  if (normalizedAssigneeIds.length > 0) {
    await prisma.projectAssignment.createMany({
      data: normalizedAssigneeIds.map((assigneeId) => ({
        userId: assigneeId,
        projectId: created.id,
        componentId: null,
      })),
      skipDuplicates: true,
    });
  }

  const contract = await getContractByIdFromDb(created.id);
  if (!contract) {
    throw new Error("Failed to read created contract.");
  }

  return contract;
}

export async function updateContractInDb(contractId: string, input: ContractFormInput): Promise<MockContract | null> {
  const existing = await prisma.project.findUnique({ where: { id: contractId }, select: { id: true } });
  if (!existing) {
    return null;
  }

  const normalizedAssigneeIds = normalizeAssigneeIds(input.assigneeIds);
  for (const assigneeId of normalizedAssigneeIds) {
    await ensureUserRecord(assigneeId, assigneeId, null);
  }

  await prisma.project.update({
    where: { id: contractId },
    data: {
      name: input.contractName,
      description: buildMetadata(input),
    },
  });

  await prisma.projectAssignment.deleteMany({
    where: {
      projectId: contractId,
      componentId: null,
    },
  });

  if (normalizedAssigneeIds.length > 0) {
    await prisma.projectAssignment.createMany({
      data: normalizedAssigneeIds.map((assigneeId) => ({
        userId: assigneeId,
        projectId: contractId,
        componentId: null,
      })),
      skipDuplicates: true,
    });
  }

  return getContractByIdFromDb(contractId);
}

export async function updateContractPaltTrackingInDb(
  contractId: string,
  input: Pick<
    ContractFormInput,
    "palt" | "paltProcurementType" | "paltDollarValue" | "paltBeginOitoEngagement" | "paltOitoEngagement" | "paltMilestones"
  >
): Promise<MockContract | null> {
  const existing = await prisma.project.findUnique({
    where: { id: contractId },
    select: { id: true, name: true, description: true },
  });

  if (!existing) {
    return null;
  }

  const metadata = parseMetadata({ name: existing.name, description: existing.description });
  const nextMetadata = {
    ...metadata,
    activeContract: {
      ...metadata.activeContract,
      palt: input.palt ?? metadata.activeContract.palt,
      paltProcurementType: input.paltProcurementType ?? metadata.activeContract.paltProcurementType,
      paltDollarValue: input.paltDollarValue ?? metadata.activeContract.paltDollarValue,
      paltBeginOitoEngagement:
        input.paltBeginOitoEngagement ?? metadata.activeContract.paltBeginOitoEngagement,
      paltOitoEngagement: input.paltOitoEngagement ?? metadata.activeContract.paltOitoEngagement,
      paltMilestones: input.paltMilestones ?? metadata.activeContract.paltMilestones,
    },
  };

  await prisma.project.update({
    where: { id: contractId },
    data: {
      description: JSON.stringify(nextMetadata),
    },
  });

  return getContractByIdFromDb(contractId);
}

export async function deleteContractInDb(contractId: string): Promise<boolean> {
  const existing = await prisma.project.findUnique({ where: { id: contractId }, select: { id: true } });
  if (!existing) {
    return false;
  }

  await prisma.project.update({
    where: { id: contractId },
    data: {
      status: "COMPLETED",
    },
  });

  return true;
}

export async function getWarEntriesForContractFromDb(contractId: string): Promise<MockContractSubmission[]> {
  await seedIfEmpty();
  const submissions = await prisma.submission.findMany({
    where: {
      projectId: contractId,
      deletedAt: null,
    },
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      weekOf: true,
      createdAt: true,
      updatedAt: true,
      rawText: true,
      status: true,
    },
  });

  return collapseToLatestBiWeeklySubmission(submissions).map(mapSubmissionToWarEntry);
}

export async function upsertWarSubmissionForContract(params: {
  contractId: string;
  userId: string;
  summary: string;
  submissionId?: string | null;
}): Promise<{ entry: MockContractSubmission; submissionId: string }> {
  const contractProject = await prisma.project.findUnique({
    where: { id: params.contractId },
    select: { name: true, description: true },
  });

  if (!contractProject) {
    throw new Error("SUBMISSION_LOCKED:Contract not found.");
  }

  const contractMetadata = parseMetadata(contractProject);
  if (contractMetadata.category === "Legacy Contracts") {
    throw new Error(
      "SUBMISSION_LOCKED:This contract is in Legacy (retired) mode and no longer accepts updates."
    );
  }

  await ensureUserRecord(params.userId, params.userId, null);

  const currentPeriod = getCurrentSubmissionPeriod();
  const weekOf = new Date(currentPeriod.start);
  const now = new Date();
  const submissionWindowOpen = isSubmissionWindowOpen(now);
  const storedSettings = await getStoredSettings();
  const deadlineOverrideEnabled = getOverseerSettings(storedSettings).contributorAccess.deadlineOverrideEnabled;
  weekOf.setHours(now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds());

  let submission = null;

  if (params.submissionId) {
    submission = await prisma.submission.findFirst({
      where: {
        id: params.submissionId,
        userId: params.userId,
        projectId: params.contractId,
        deletedAt: null,
      },
      include: {
        reviews: {
          orderBy: { createdAt: "desc" },
          take: 1,
          select: {
            status: true,
            comment: true,
          },
        },
      },
    });

    if (submission) {
      submission = await prisma.submission.update({
        where: { id: submission.id },
        data: {
          rawText: params.summary,
          status: "SUBMITTED",
          weekOf,
          updatedAt: now,
          isAiGenerated: false,
        },
      });
    }
  }

  if (!submission) {
    submission = await prisma.submission.findFirst({
      where: {
        userId: params.userId,
        projectId: params.contractId,
        deletedAt: null,
        weekOf: {
          gte: currentPeriod.start,
          lte: currentPeriod.end,
        },
      },
      orderBy: {
        updatedAt: "desc",
      },
      include: {
        reviews: {
          orderBy: { createdAt: "desc" },
          take: 1,
          select: {
            status: true,
            comment: true,
          },
        },
      },
    });

    if (submission) {
      const latestReview = submission.reviews?.[0];
      const reopenedByReviewer =
        latestReview?.status === "CHANGES_REQUESTED" || latestReview?.status === "INFO_NEEDED";

      if (!submissionWindowOpen && !deadlineOverrideEnabled && !reopenedByReviewer) {
        throw new Error(
          "SUBMISSION_LOCKED:Submission window is closed. This card can only be edited after deadline when reopened by an Aggregator or Program Overseer comment."
        );
      }

      submission = await prisma.submission.update({
        where: { id: submission.id },
        data: {
          rawText: params.summary,
          status: "SUBMITTED",
          weekOf,
          updatedAt: now,
          isAiGenerated: false,
        },
      });
    }
  }

  if (!submission) {
    if (!submissionWindowOpen && !deadlineOverrideEnabled) {
      throw new Error(
        "SUBMISSION_LOCKED:Submissions are only allowed on the 1st and 3rd Tuesday between 8:00 AM and 5:00 PM."
      );
    }

    submission = await prisma.submission.create({
      data: {
        userId: params.userId,
        projectId: params.contractId,
        weekOf,
        rawText: params.summary,
        status: "SUBMITTED",
        isAiGenerated: false,
      },
    });
  }

  return {
    entry: mapSubmissionToWarEntry(submission),
    submissionId: submission.id,
  };
}
