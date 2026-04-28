import { NextRequest, NextResponse } from "next/server";
import { auth, hasMinimumRole } from "@/lib/auth";
import { deleteContract, getMockContractById, updateContract } from "@/lib/mock-contracts";

export const dynamic = "force-dynamic";

interface RouteParams {
  params: { id: string };
}

export async function GET(_: NextRequest, { params }: RouteParams) {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const contract = getMockContractById(params.id);
  if (!contract) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  return NextResponse.json({ contract });
}

export async function PUT(request: NextRequest, { params }: RouteParams) {
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

  const updated = updateContract(params.id, {
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

  if (!updated) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  return NextResponse.json({ contract: updated });
}

export async function DELETE(_: NextRequest, { params }: RouteParams) {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const canManage = hasMinimumRole(session.user.role, "AGGREGATOR");
  if (!canManage) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const deleted = deleteContract(params.id);

  if (!deleted) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  return NextResponse.json({ success: true });
}
