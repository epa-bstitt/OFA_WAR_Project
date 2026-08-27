import { NextRequest, NextResponse } from "next/server";
import { auth, hasMinimumRole } from "@/lib/auth";
import {
  deleteContractInDb,
  getContractByIdFromDb,
  updateContractInDb,
} from "@/lib/contracts-db";
import { revalidatePath } from "next/cache";
import { prisma } from "@/lib/db";

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

  const body = await request.json();
  const canManage = hasMinimumRole(session.user.role, "AGGREGATOR");

  let updated = null;

  if (canManage) {
    const contractName = String(body?.contractName ?? "").trim();

    if (!contractName) {
      return NextResponse.json({ error: "Contract name is required." }, { status: 400 });
    }

    updated = await updateContractInDb(params.id, {
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
  } else if (session.user.role === "CONTRIBUTOR") {
    const assignment = await prisma.projectAssignment.findFirst({
      where: {
        projectId: params.id,
        userId: session.user.id,
        componentId: null,
      },
      select: { id: true },
    });

    if (!assignment) {
      return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    const existingContract = await getContractByIdFromDb(params.id);
    if (!existingContract) {
      return NextResponse.json({ error: "Contract not found" }, { status: 404 });
    }

    updated = await updateContractInDb(params.id, {
      contractName: String(body?.contractName ?? existingContract.contractName).trim(),
      cor: String(body?.cor ?? existingContract.activeContract.cor ?? ""),
      contractNumber: String(body?.contractNumber ?? existingContract.activeContract.contractNumber ?? ""),
      office: String(body?.office ?? existingContract.activeContract.office ?? ""),
      nextPeriodOfPerf: String(body?.nextPeriodOfPerf ?? existingContract.activeContract.nextPeriodOfPerf ?? ""),
      ultimateCompletionDate: String(body?.ultimateCompletionDate ?? existingContract.activeContract.ultimateCompletionDate ?? ""),
      co: String(body?.co ?? existingContract.activeContract.co ?? ""),
      cs: String(body?.cs ?? existingContract.activeContract.cs ?? ""),
      orderNumber: String(body?.orderNumber ?? existingContract.activeContract.orderNumber ?? ""),
      palt: String(body?.palt ?? existingContract.activeContract.palt ?? ""),
      paltProcurementType: String(body?.paltProcurementType ?? existingContract.activeContract.paltProcurementType ?? ""),
      paltDollarValue: String(body?.paltDollarValue ?? existingContract.activeContract.paltDollarValue ?? ""),
      paltBeginOitoEngagement: String(body?.paltBeginOitoEngagement ?? existingContract.activeContract.paltBeginOitoEngagement ?? ""),
      paltOitoEngagement: String(body?.paltOitoEngagement ?? existingContract.activeContract.paltOitoEngagement ?? ""),
      paltMilestones: String(body?.paltMilestones ?? existingContract.activeContract.paltMilestones ?? ""),
      category: existingContract.category,
      assigneeIds: existingContract.assigneeIds,
    });
  } else {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  if (!updated) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  revalidatePath("/settings");
  revalidatePath("/dashboard");
  revalidatePath("/submit");

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
