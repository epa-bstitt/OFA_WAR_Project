import { NextRequest, NextResponse } from "next/server";
import { auth, hasMinimumRole } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { getCurrentSubmissionPeriod } from "@/lib/submission-periods";

export const dynamic = "force-dynamic";

type ExportCategory = "recompetes" | "outlook";

function parseIncludeCategories(rawValue: string | null): Set<ExportCategory> {
  const allowed = new Set<ExportCategory>();
  if (!rawValue) {
    return allowed;
  }

  for (const value of rawValue.split(",").map((item) => item.trim().toLowerCase())) {
    if (value === "recompetes" || value === "outlook") {
      allowed.add(value);
    }
  }

  return allowed;
}

function toExportCategory(projectDescription: string | null): ExportCategory | null {
  if (!projectDescription) {
    return "outlook";
  }

  try {
    const parsed = JSON.parse(projectDescription) as { category?: string };
    if (parsed.category === "New Awards and Recompetes") {
      return "recompetes";
    }

    if (parsed.category === "Legacy Contracts") {
      return null;
    }

    return "outlook";
  } catch {
    return "outlook";
  }
}

function escapeCsvValue(value: string): string {
  if (value.includes(",") || value.includes("\n") || value.includes("\"")) {
    return `"${value.replace(/\"/g, '""')}"`;
  }

  return value;
}

export async function GET(request: NextRequest) {
  const session = await auth();
  if (!session?.user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  if (!hasMinimumRole(session.user.role, "PROGRAM_OVERSEER")) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  const contractIdsRaw = request.nextUrl.searchParams.get("contractIds") || "";
  const selectedSubmissionIds = contractIdsRaw
    .split(",")
    .map((id) => id.trim())
    .filter((id) => id.length > 0);

  if (selectedSubmissionIds.length === 0) {
    return NextResponse.json({ error: "No submissions selected for export." }, { status: 400 });
  }

  const includedCategories = parseIncludeCategories(
    request.nextUrl.searchParams.get("includeCategories")
  );

  const now = new Date();
  const currentPeriod = getCurrentSubmissionPeriod(now);

  const submissions = await prisma.submission.findMany({
    where: {
      id: { in: selectedSubmissionIds },
      status: { in: ["APPROVED", "PUBLISHED"] },
      deletedAt: null,
      weekOf: {
        gte: currentPeriod.start,
        lte: currentPeriod.end,
      },
    },
    include: {
      user: {
        select: {
          id: true,
          name: true,
          email: true,
        },
      },
      project: {
        select: {
          id: true,
          name: true,
          description: true,
        },
      },
    },
    orderBy: [
      { weekOf: "desc" },
      { updatedAt: "desc" },
    ],
  });

  const rows = submissions
    .map((submission) => {
      const category = toExportCategory(submission.project?.description ?? null);
      if (!category) {
        return null;
      }

      if (includedCategories.size > 0 && !includedCategories.has(category)) {
        return null;
      }

      return {
        category,
        contractName: submission.project?.name || `Submission ${submission.id}`,
        contributorName: submission.user.name || submission.user.email || submission.user.id,
        contributorEmail: submission.user.email,
        weekOf: submission.weekOf.toISOString(),
        status: submission.status,
        rawText: submission.rawText,
      };
    })
    .filter((row): row is NonNullable<typeof row> => Boolean(row));

  const header = [
    "category",
    "contractName",
    "contributorName",
    "contributorEmail",
    "weekOf",
    "status",
    "rawText",
  ];

  const csvLines = [header.join(",")];
  for (const row of rows) {
    csvLines.push(
      [
        row.category,
        row.contractName,
        row.contributorName,
        row.contributorEmail,
        row.weekOf,
        row.status,
        row.rawText,
      ]
        .map((value) => escapeCsvValue(value))
        .join(",")
    );
  }

  const csvBody = csvLines.join("\n");
  const filename = `war-overview-${currentPeriod.id}.csv`;

  return new NextResponse(csvBody, {
    status: 200,
    headers: {
      "Content-Type": "text/csv; charset=utf-8",
      "Content-Disposition": `attachment; filename=\"${filename}\"`,
      "Cache-Control": "no-store",
    },
  });
}
