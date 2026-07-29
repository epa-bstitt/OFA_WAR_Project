import { NextRequest, NextResponse } from "next/server";
import { auth, hasMinimumRole } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { getCurrentSubmissionPeriod } from "@/lib/submission-periods";
import {
  AlignmentType,
  BorderStyle,
  Document,
  HeadingLevel,
  Packer,
  Paragraph,
  Table,
  TableCell,
  TableRow,
  TextRun,
  WidthType,
} from "docx";

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

interface ExportRow {
  category: ExportCategory;
  contractName: string;
  contributorName: string;
  contributorEmail: string | null;
  weekOf: Date;
  updatedAt: Date;
  status: string;
  rawText: string;
}

function normalizeLines(rawText: string): string[] {
  return rawText
    .replace(/\r\n/g, "\n")
    .replace(/\r/g, "\n")
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line.length > 0);
}

function formatDateLabel(value: Date): string {
  return value.toLocaleDateString("en-US", {
    month: "short",
    day: "numeric",
    year: "numeric",
  });
}

function collapseToLatestCurrentUpdate(rows: ExportRow[]): ExportRow[] {
  const latestByContract = new Map<string, ExportRow>();

  for (const row of rows) {
    const key = `${row.category}::${row.contractName}`;
    const existing = latestByContract.get(key);

    if (!existing || row.updatedAt.getTime() > existing.updatedAt.getTime()) {
      latestByContract.set(key, row);
    }
  }

  return Array.from(latestByContract.values()).sort((a, b) => a.contractName.localeCompare(b.contractName));
}

function buildUpdateParagraphs(rawText: string): Paragraph[] {
  const lines = normalizeLines(rawText);

  if (lines.length === 0) {
    return [
      new Paragraph({
        children: [new TextRun({ text: "No update content provided.", italics: true, color: "6B7280" })],
      }),
    ];
  }

  return lines.map((line) => {
    const isSectionLine = /:$/.test(line) || /^[A-Za-z][A-Za-z0-9\s&\-\/]{1,40}:$/.test(line);
    const bulletMatch = line.match(/^[\-\u2022\u25AA\u25CF\u00A7o]\s*(.+)$/i);

    if (isSectionLine) {
      return new Paragraph({
        spacing: { before: 140, after: 80 },
        children: [new TextRun({ text: line, bold: true, color: "1F2937" })],
      });
    }

    if (bulletMatch) {
      return new Paragraph({
        bullet: { level: 0 },
        spacing: { after: 50 },
        children: [new TextRun({ text: bulletMatch[1] })],
      });
    }

    return new Paragraph({
      spacing: { after: 50 },
      children: [new TextRun({ text: line })],
    });
  });
}

function buildShadedUpdateContainer(rawText: string): Table {
  const border = {
    style: BorderStyle.SINGLE,
    color: "E2E8F0",
    size: 4,
  };

  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        children: [
          new TableCell({
            children: buildUpdateParagraphs(rawText),
            shading: { fill: "F8FAFC" },
            margins: { top: 120, bottom: 120, left: 120, right: 120 },
          }),
        ],
      }),
    ],
    borders: {
      top: border,
      bottom: border,
      left: border,
      right: border,
      insideHorizontal: border,
      insideVertical: border,
    },
  });
}

function buildDocxBuffer(rows: ExportRow[], currentPeriodId: string): Promise<Buffer> {
  const latestRows = collapseToLatestCurrentUpdate(rows);

  const byCategory = {
    recompetes: latestRows.filter((row) => row.category === "recompetes"),
    outlook: latestRows.filter((row) => row.category === "outlook"),
  };

  const sectionTitle = (title: string) =>
    new Paragraph({
      text: title,
      heading: HeadingLevel.HEADING_1,
      thematicBreak: true,
      spacing: { before: 280, after: 140 },
    });

  const children: Array<Paragraph | Table> = [
    new Paragraph({
      text: "WAR Overview Export",
      heading: HeadingLevel.TITLE,
      alignment: AlignmentType.LEFT,
      spacing: { after: 120 },
    }),
    new Paragraph({
      children: [
        new TextRun({ text: "Biweekly Period: ", bold: true }),
        new TextRun({ text: currentPeriodId }),
      ],
      spacing: { after: 60 },
    }),
    new Paragraph({
      children: [
        new TextRun({ text: "Generated: ", bold: true }),
        new TextRun({
          text: new Date().toLocaleString("en-US", {
            month: "short",
            day: "numeric",
            year: "numeric",
            hour: "numeric",
            minute: "2-digit",
          }),
        }),
      ],
      spacing: { after: 240 },
    }),
  ];

  const addCategoryBlock = (title: string, categoryRows: ExportRow[]) => {
    if (categoryRows.length === 0) {
      return;
    }

    children.push(sectionTitle(title));

    for (const [index, row] of categoryRows.entries()) {
      children.push(
        new Paragraph({
          text: row.contractName,
          heading: HeadingLevel.HEADING_2,
          spacing: { before: 180, after: 40 },
        })
      );

      children.push(
        new Paragraph({
          children: [
            new TextRun({ text: "Current Update", bold: true }),
            new TextRun({
              text: `  (${formatDateLabel(row.weekOf)} by ${row.contributorName})`,
              italics: true,
              color: "6B7280",
            }),
          ],
          heading: HeadingLevel.HEADING_3,
          spacing: { before: 20, after: 70 },
        })
      );

      children.push(buildShadedUpdateContainer(row.rawText));

      if (index < categoryRows.length - 1) {
        children.push(
          new Paragraph({
            text: "",
            thematicBreak: true,
            spacing: { before: 180, after: 140 },
          })
        );
      }
    }
  };

  addCategoryBlock("New Awards and Recompetes", byCategory.recompetes);
  addCategoryBlock("Current and Active Contracts/Purchase Order Outlook", byCategory.outlook);

  if (byCategory.recompetes.length === 0 && byCategory.outlook.length === 0) {
    children.push(
      new Paragraph({
        text: "No approved or published submissions were found for the selected filters in this biweekly period.",
        spacing: { before: 160, after: 60 },
      })
    );
  }

  const doc = new Document({
    sections: [
      {
        properties: {},
        children,
      },
    ],
  });

  return Packer.toBuffer(doc);
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

  const rows: ExportRow[] = submissions
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
        weekOf: submission.weekOf,
        updatedAt: submission.updatedAt,
        status: submission.status,
        rawText: submission.rawText,
      };
    })
    .filter((row): row is NonNullable<typeof row> => Boolean(row));

  const docBuffer = await buildDocxBuffer(rows, currentPeriod.id);
  const filename = `war-overview-${currentPeriod.id}.docx`;

  return new NextResponse(docBuffer, {
    status: 200,
    headers: {
      "Content-Type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "Content-Disposition": `attachment; filename=\"${filename}\"`,
      "Cache-Control": "no-store",
    },
  });
}
