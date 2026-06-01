import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { hasMinimumRole } from "@/lib/auth";
import { createContractInDb, getContractsOutlookFromDb } from "@/lib/contracts-db";
import { revalidatePath } from "next/cache";

export const dynamic = "force-dynamic";

export async function GET() {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const contracts = await getContractsOutlookFromDb();
  return NextResponse.json({ contracts });
}

export async function POST(request: NextRequest) {
  try {
    const session = await auth();
    if (!session?.user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const canManage = hasMinimumRole(session.user.role, "AGGREGATOR");
    if (!canManage) {
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    const body = await request.json();
    const contractName = String(body?.contractName ?? "").trim();
    if (!contractName) {
      return NextResponse.json({ error: "Contract name is required." }, { status: 400 });
    }

    let contract;
    try {
      contract = await createContractInDb({
        contractName,
        cor: String(body?.cor ?? ""),
        contractNumber: String(body?.contractNumber ?? ""),
        office: String(body?.office ?? ""),
        nextPeriodOfPerf: String(body?.nextPeriodOfPerf ?? ""),
        ultimateCompletionDate: String(body?.ultimateCompletionDate ?? ""),
        co: String(body?.co ?? ""),
        cs: String(body?.cs ?? ""),
        orderNumber: String(body?.orderNumber ?? ""),
        palt: String(body?.palt ?? ""),
        paltProcurementType: String(body?.paltProcurementType ?? ""),
        paltDollarValue: String(body?.paltDollarValue ?? ""),
        paltBeginOitoEngagement: String(body?.paltBeginOitoEngagement ?? ""),
        paltOitoEngagement: String(body?.paltOitoEngagement ?? ""),
        paltMilestones: String(body?.paltMilestones ?? ""),
        category: String(body?.category ?? "Contract"),
        assigneeIds: Array.isArray(body?.assigneeIds)
          ? body.assigneeIds.map((value: unknown) => String(value))
          : undefined,
      });
    } catch (err) {
      console.error("Error in createContractInDb:", err);
      return NextResponse.json({ error: "Failed to create contract." }, { status: 500 });
    }

    revalidatePath("/settings");

    return NextResponse.json({ contract }, { status: 201 });
  } catch (err) {
    console.error("Contract POST API error:", err);
    return NextResponse.json({ error: "Unexpected server error." }, { status: 500 });
  }
}
