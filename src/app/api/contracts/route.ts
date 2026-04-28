import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { hasMinimumRole } from "@/lib/auth";
import { createContract, getContractsOutlook } from "@/lib/mock-contracts";

export const dynamic = "force-dynamic";

export async function GET() {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  return NextResponse.json({ contracts: getContractsOutlook() });
}

export async function POST(request: NextRequest) {
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

  const contract = createContract({
    contractName,
    cor: String(body?.cor ?? ""),
    contractNumber: String(body?.contractNumber ?? ""),
    office: String(body?.office ?? ""),
    nextPeriodOfPerf: String(body?.nextPeriodOfPerf ?? ""),
    ultimateCompletionDate: String(body?.ultimateCompletionDate ?? ""),
    co: String(body?.co ?? ""),
    cs: String(body?.cs ?? ""),
    orderNumber: String(body?.orderNumber ?? ""),
    category: String(body?.category ?? "Contract"),
  });

  return NextResponse.json({ contract }, { status: 201 });
}
