import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { addWarEntryToContract, getWarEntriesForContract, getMockContractById } from "@/lib/mock-contracts";

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

  return NextResponse.json({ entries: getWarEntriesForContract(params.id) });
}

export async function POST(request: NextRequest, { params }: RouteParams) {
  const session = await auth();

  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const contract = getMockContractById(params.id);
  if (!contract) {
    return NextResponse.json({ error: "Contract not found" }, { status: 404 });
  }

  const body = await request.json();
  const summary = String(body?.summary ?? "").trim();

  if (!summary) {
    return NextResponse.json({ error: "Summary is required." }, { status: 400 });
  }

  const entry = addWarEntryToContract(params.id, {
    summary,
    weekOf: typeof body?.weekOf === "string" ? body.weekOf : undefined,
    status: body?.status,
  });

  if (!entry) {
    return NextResponse.json({ error: "Could not create WAR entry." }, { status: 400 });
  }

  return NextResponse.json({ entry }, { status: 201 });
}
