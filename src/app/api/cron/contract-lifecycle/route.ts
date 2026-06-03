import { NextRequest, NextResponse } from "next/server";
import { getContractsOutlookFromDb, updateContractInDb } from "@/lib/contracts-db";

export const dynamic = "force-dynamic";

const RECOMPETES_CATEGORY = "New Awards and Recompetes";
const OUTLOOK_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";
const LEGACY_CATEGORY = "Legacy Contracts";

function isAuthorized(request: NextRequest): boolean {
  const configuredSecret = process.env.CRON_SECRET;
  if (!configuredSecret) {
    return process.env.NODE_ENV !== "production";
  }

  const authHeader = request.headers.get("authorization") || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  return token === configuredSecret;
}

function toTimestamp(value: string) {
  const trimmed = value.trim();
  if (!trimmed) {
    return Number.NaN;
  }

  const parsed = new Date(trimmed).getTime();
  return Number.isNaN(parsed) ? Number.NaN : parsed;
}

function getTargetCategory(currentCategory: string) {
  if (currentCategory === RECOMPETES_CATEGORY) {
    return OUTLOOK_CATEGORY;
  }

  if (currentCategory === OUTLOOK_CATEGORY) {
    return LEGACY_CATEGORY;
  }

  return null;
}

export async function GET(request: NextRequest) {
  if (!isAuthorized(request)) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const contracts = await getContractsOutlookFromDb();
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const dueContracts = contracts.filter((contract) => {
    const isLifecycleCategory =
      contract.category === RECOMPETES_CATEGORY || contract.category === OUTLOOK_CATEGORY;

    if (!isLifecycleCategory) {
      return false;
    }

    const endTs = toTimestamp(contract.activeContract.ultimateCompletionDate);
    return !Number.isNaN(endTs) && endTs <= today.getTime();
  });

  const moved: Array<{ contractId: string; contractName: string; from: string; to: string }> = [];
  const failures: Array<{ contractId: string; contractName: string; error: string }> = [];

  for (const contract of dueContracts) {
    const targetCategory = getTargetCategory(contract.category);
    if (!targetCategory) {
      continue;
    }

    try {
      await updateContractInDb(contract.id, {
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
        assigneeIds: contract.assigneeIds ?? [],
      });

      moved.push({
        contractId: contract.id,
        contractName: contract.contractName,
        from: contract.category,
        to: targetCategory,
      });
    } catch (error) {
      failures.push({
        contractId: contract.id,
        contractName: contract.contractName,
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }

  return NextResponse.json({
    success: true,
    checkedCount: contracts.length,
    dueCount: dueContracts.length,
    movedCount: moved.length,
    failedCount: failures.length,
    moved,
    failures,
  });
}
