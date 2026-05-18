import { NextRequest, NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import {
  getContractByIdFromDb,
  getWarEntriesForContractFromDb,
  upsertWarSubmissionForContract,
} from "@/lib/contracts-db";

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

  const entries = await getWarEntriesForContractFromDb(params.id);
  return NextResponse.json({ entries });
}

export async function POST(request: NextRequest, { params }: RouteParams) {
  try {
    const session = await auth();

    if (!session?.user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const contract = await getContractByIdFromDb(params.id);
    if (!contract) {
      return NextResponse.json({ error: "Contract not found" }, { status: 404 });
    }

    const body = await request.json();
    const summary = String(body?.summary ?? "").trim();
    const submissionId = typeof body?.submissionId === "string" ? body.submissionId : null;
    const _historyEntryId = typeof body?.historyEntryId === "string" ? body.historyEntryId : undefined;

    if (!summary) {
      return NextResponse.json({ error: "Summary is required." }, { status: 400 });
    }

    // Ensure demo/mock credential users also exist in Prisma before creating submission rows.
    await prisma.user.upsert({
      where: { id: session.user.id },
      update: {
        email: session.user.email ?? `${session.user.id}@demo.epa.gov`,
        name: session.user.name ?? undefined,
        azureAdId: session.user.azureAdId ?? session.user.id,
        role: session.user.role ?? "CONTRIBUTOR",
        isActive: true,
      },
      create: {
        id: session.user.id,
        email: session.user.email ?? `${session.user.id}@demo.epa.gov`,
        name: session.user.name ?? null,
        azureAdId: session.user.azureAdId ?? session.user.id,
        role: session.user.role ?? "CONTRIBUTOR",
        isActive: true,
      },
    });

    const { entry, submissionId: savedSubmissionId } = await upsertWarSubmissionForContract({
      contractId: params.id,
      userId: session.user.id,
      summary,
      submissionId,
    });

    revalidatePath("/dashboard");
    revalidatePath("/review");
    revalidatePath("/approve");
    revalidatePath(`/contracts/${params.id}`);

    return NextResponse.json({ entry, submissionId: savedSubmissionId }, { status: 201 });
  } catch (error) {
    if (error instanceof Error && error.message.startsWith("SUBMISSION_LOCKED:")) {
      return NextResponse.json(
        { error: error.message.replace("SUBMISSION_LOCKED:", "") },
        { status: 403 }
      );
    }

    console.error("Error creating contract WAR update:", error);
    return NextResponse.json({ error: "Failed to create WAR update." }, { status: 500 });
  }
}
