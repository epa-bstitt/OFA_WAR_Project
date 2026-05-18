import { NextRequest, NextResponse } from "next/server";
import { auth, hasMinimumRole } from "@/lib/auth";
import { deleteContractInDb, getContractByIdFromDb, updateContractInDb } from "@/lib/contracts-db";
import { revalidatePath } from "next/cache";

export const dynamic = "force-dynamic";

interface RouteParams {
  params: { id: string };
}

export async function GET(_: NextRequest, { params }: RouteParams) {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const contract = await getContractByIdFromDb(params.id);
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

  const updated = await updateContractInDb(params.id, {
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
    assigneeIds: Array.isArray(body?.assigneeIds)
      ? body.assigneeIds.map((value: unknown) => String(value))
      : undefined,
  });

  if (!updated) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  revalidatePath("/settings");

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

  const deleted = await deleteContractInDb(params.id);

  if (!deleted) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  revalidatePath("/settings");

  return NextResponse.json({ success: true });
}
