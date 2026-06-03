import { createHash } from "crypto";
import JSZip from "jszip";
import mammoth from "mammoth";
import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { prisma } from "@/lib/db";
import { logAuditEvent } from "@/lib/audit/logger";

export const runtime = "nodejs";

const DEFAULT_CATEGORY = "Current and Active Contracts/Purchase Order Outlook";

type ParsedImportDoc = {
  sourcePath: string;
  category: string;
  title: string;
  assigneeNames: string[];
  rawText: string;
  projectId: string;
};

type ImportSummary = {
  filesProcessed: number;
  projectsUpserted: number;
  usersUpserted: number;
  assignmentsCreated: number;
  submissionsCreated: number;
  warnings: string[];
};

type FileImportResult = {
  sourcePath: string;
  category: string;
  title: string;
  projectId: string;
  status: "DRY_RUN" | "IMPORTED" | "SKIPPED" | "FAILED";
  message: string | null;
  usersUpserted: number;
  assignmentsCreated: number;
  submissionsCreated: number;
  warnings: string[];
};

function isUnsafeZipPath(path: string) {
  const normalized = path.replace(/\\/g, "/");
  return normalized.startsWith("/") || normalized.includes("../") || normalized.includes("..\\");
}

function toSlug(value: string) {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 64);
}

function parseAssigneeNames(baseNameWithoutExt: string): { title: string; assigneeNames: string[] } {
  const match = baseNameWithoutExt.match(/^(.*)\(([^)]+)\)\s*$/);
  if (!match) {
    return {
      title: baseNameWithoutExt.trim(),
      assigneeNames: [],
    };
  }

  const title = match[1].trim();
  const namesBlock = match[2];
  const assigneeNames = namesBlock
    .split(/,|;| and | & /i)
    .map((name) => name.trim())
    .filter(Boolean);

  return { title, assigneeNames };
}

function buildProjectDescription(doc: ParsedImportDoc) {
  return JSON.stringify({
    category: doc.category,
    activeContract: {
      contractName: doc.title,
      cor: "",
      contractNumber: "",
      office: "",
      nextPeriodOfPerf: "",
      ultimateCompletionDate: "",
      co: "",
      cs: "",
      orderNumber: "",
    },
    imageUrl: "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80",
    imageAlt: "Contract and acquisition planning documents on an office desk.",
    currentUpdatePlaceholder: `Imported from ${doc.sourcePath}`,
    importSourcePath: doc.sourcePath,
  });
}

function getCategoryFromPath(path: string) {
  const normalized = path.replace(/\\/g, "/");
  const parts = normalized.split("/").filter(Boolean);
  return parts.length > 1 ? parts[0] : DEFAULT_CATEGORY;
}

function buildProjectIdFromPath(path: string) {
  const digest = createHash("sha1").update(path.toLowerCase()).digest("hex").slice(0, 24);
  return `import-${digest}`;
}

async function parseZipArchive(zipBuffer: Buffer): Promise<ParsedImportDoc[]> {
  const zip = await JSZip.loadAsync(zipBuffer);
  const parsedDocs: ParsedImportDoc[] = [];

  for (const [entryPath, entry] of Object.entries(zip.files)) {
    if (entry.dir) {
      continue;
    }

    if (isUnsafeZipPath(entryPath)) {
      continue;
    }

    const normalized = entryPath.replace(/\\/g, "/");
    if (!normalized.toLowerCase().endsWith(".docx")) {
      continue;
    }

    const pathParts = normalized.split("/").filter(Boolean);
    const fileName = pathParts[pathParts.length - 1] ?? "";
    const baseName = fileName.replace(/\.docx$/i, "");
    const parsedName = parseAssigneeNames(baseName);
    const docxBuffer = await entry.async("nodebuffer");
    const rawText = (await mammoth.extractRawText({ buffer: docxBuffer })).value.trim();

    parsedDocs.push({
      sourcePath: normalized,
      category: getCategoryFromPath(normalized),
      title: parsedName.title || baseName,
      assigneeNames: parsedName.assigneeNames,
      rawText,
      projectId: buildProjectIdFromPath(normalized),
    });
  }

  return parsedDocs;
}

async function upsertImportedUser(name: string) {
  const slug = toSlug(name);
  const safeSlug = slug || `import-user-${createHash("sha1").update(name).digest("hex").slice(0, 8)}`;
  const userId = `import-${safeSlug}`;
  const email = `${safeSlug}@import.local`;

  await prisma.user.upsert({
    where: { id: userId },
    update: {
      name,
      email,
      azureAdId: userId,
      role: "CONTRIBUTOR",
      isActive: true,
    },
    create: {
      id: userId,
      name,
      email,
      azureAdId: userId,
      role: "CONTRIBUTOR",
      isActive: true,
    },
  });

  return userId;
}

async function importDocs(
  docs: ParsedImportDoc[],
  actorId: string,
  dryRun: boolean
): Promise<{ summary: ImportSummary; fileResults: FileImportResult[] }> {
  const summary: ImportSummary = {
    filesProcessed: docs.length,
    projectsUpserted: 0,
    usersUpserted: 0,
    assignmentsCreated: 0,
    submissionsCreated: 0,
    warnings: [],
  };
  const fileResults: FileImportResult[] = [];

  for (const doc of docs) {
    const uniqueNames = [...new Set(doc.assigneeNames.map((name) => name.trim()).filter(Boolean))];
    const assigneeNames = uniqueNames.length > 0 ? uniqueNames : ["Unassigned"];
    const fileWarnings: string[] = [];

    if (uniqueNames.length === 0) {
      const warning = `${doc.sourcePath}: no assignee names found, assigned to import fallback user.`;
      summary.warnings.push(warning);
      fileWarnings.push(warning);
    }

    if (dryRun) {
      summary.projectsUpserted += 1;
      summary.usersUpserted += assigneeNames.length;
      summary.assignmentsCreated += assigneeNames.length;
      summary.submissionsCreated += doc.rawText ? 1 : 0;

      if (!doc.rawText) {
        const warning = `${doc.sourcePath}: DOCX text was empty and no baseline submission was created.`;
        summary.warnings.push(warning);
        fileWarnings.push(warning);
      }

      fileResults.push({
        sourcePath: doc.sourcePath,
        category: doc.category,
        title: doc.title,
        projectId: doc.projectId,
        status: "DRY_RUN",
        message: "Dry run: changes were not written to the database.",
        usersUpserted: assigneeNames.length,
        assignmentsCreated: assigneeNames.length,
        submissionsCreated: doc.rawText ? 1 : 0,
        warnings: fileWarnings,
      });
      continue;
    }

    try {
      await prisma.project.upsert({
        where: { id: doc.projectId },
        update: {
          name: doc.title,
          description: buildProjectDescription(doc),
          status: "ACTIVE",
        },
        create: {
          id: doc.projectId,
          name: doc.title,
          description: buildProjectDescription(doc),
          status: "ACTIVE",
        },
      });
      summary.projectsUpserted += 1;

      const assigneeIds: string[] = [];
      for (const name of assigneeNames) {
        const id = await upsertImportedUser(name);
        assigneeIds.push(id);
        summary.usersUpserted += 1;
      }

      await prisma.projectAssignment.deleteMany({
        where: {
          projectId: doc.projectId,
          componentId: null,
        },
      });

      if (assigneeIds.length > 0) {
        await prisma.projectAssignment.createMany({
          data: assigneeIds.map((userId) => ({
            userId,
            projectId: doc.projectId,
            componentId: null,
            assignedBy: actorId,
          })),
        });
        summary.assignmentsCreated += assigneeIds.length;
      }

      let submissionsCreatedForFile = 0;
      if (doc.rawText) {
        const existing = await prisma.submission.findFirst({
          where: {
            projectId: doc.projectId,
            rawText: doc.rawText,
          },
          select: { id: true },
        });

        if (!existing) {
          await prisma.submission.create({
            data: {
              userId: assigneeIds[0] ?? actorId,
              projectId: doc.projectId,
              componentId: null,
              contractId: null,
              weekOf: new Date(),
              rawText: doc.rawText,
              status: "SUBMITTED",
              isAiGenerated: false,
            },
          });
          summary.submissionsCreated += 1;
          submissionsCreatedForFile = 1;
        }
      } else {
        const warning = `${doc.sourcePath}: DOCX text was empty and no baseline submission was created.`;
        summary.warnings.push(warning);
        fileWarnings.push(warning);
      }

      fileResults.push({
        sourcePath: doc.sourcePath,
        category: doc.category,
        title: doc.title,
        projectId: doc.projectId,
        status: "IMPORTED",
        message: null,
        usersUpserted: assigneeIds.length,
        assignmentsCreated: assigneeIds.length,
        submissionsCreated: submissionsCreatedForFile,
        warnings: fileWarnings,
      });
    } catch (error) {
      const message = error instanceof Error ? error.message : "Import failed for file";
      summary.warnings.push(`${doc.sourcePath}: ${message}`);
      fileResults.push({
        sourcePath: doc.sourcePath,
        category: doc.category,
        title: doc.title,
        projectId: doc.projectId,
        status: "FAILED",
        message,
        usersUpserted: 0,
        assignmentsCreated: 0,
        submissionsCreated: 0,
        warnings: fileWarnings,
      });
    }
  }

  return { summary, fileResults };
}

export async function GET() {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
    if (!hasPermission) {
      return NextResponse.json({ error: "Forbidden - Administrator access required" }, { status: 403 });
    }

    const jobs = await prisma.importJob.findMany({
      orderBy: { createdAt: "desc" },
      take: 25,
      include: {
        initiatedBy: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
        fileResults: {
          orderBy: { createdAt: "asc" },
          select: {
            id: true,
            sourcePath: true,
            status: true,
            message: true,
            warnings: true,
            usersUpserted: true,
            assignmentsCreated: true,
            submissionsCreated: true,
          },
        },
      },
    });

    return NextResponse.json({ jobs });
  } catch (error) {
    console.error("Failed to fetch import jobs", error);
    return NextResponse.json({ error: "Failed to fetch import jobs." }, { status: 500 });
  }
}

export async function POST(request: Request) {
  let jobId: string | null = null;

  try {
    const session = await auth();
    const actorId = session?.user?.id;
    if (!actorId) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const hasPermission = await hasMinimumRoleLevel("ADMINISTRATOR");
    if (!hasPermission) {
      return NextResponse.json({ error: "Forbidden - Administrator access required" }, { status: 403 });
    }

    const formData = await request.formData();
    const archive = formData.get("archive");
    const dryRunValue = formData.get("dryRun");
    const dryRun = String(dryRunValue).toLowerCase() === "true";

    if (!(archive instanceof File)) {
      return NextResponse.json({ error: "Missing ZIP archive file." }, { status: 400 });
    }

    if (!archive.name.toLowerCase().endsWith(".zip")) {
      return NextResponse.json({ error: "Only .zip uploads are supported." }, { status: 400 });
    }

    const archiveBuffer = Buffer.from(await archive.arrayBuffer());
    const archiveHash = createHash("sha1").update(archiveBuffer).digest("hex");

    const createdJob = await prisma.importJob.create({
      data: {
        initiatedById: actorId,
        archiveName: archive.name,
        archiveHash,
        dryRun,
        status: "RUNNING",
      },
      select: { id: true },
    });
    jobId = createdJob.id;

    const docs = await parseZipArchive(archiveBuffer);
    if (docs.length === 0) {
      await prisma.importJob.update({
        where: { id: jobId },
        data: {
          status: "FAILED",
          errorMessage: "No DOCX files found in uploaded archive.",
          completedAt: new Date(),
        },
      });
      return NextResponse.json({ error: "No DOCX files found in uploaded archive." }, { status: 400 });
    }

    const { summary, fileResults } = await importDocs(docs, actorId, dryRun);

    await prisma.importJobFileResult.createMany({
      data: fileResults.map((fileResult) => ({
        jobId,
        sourcePath: fileResult.sourcePath,
        category: fileResult.category,
        title: fileResult.title,
        projectId: fileResult.projectId,
        status: fileResult.status,
        message: fileResult.message,
        usersUpserted: fileResult.usersUpserted,
        assignmentsCreated: fileResult.assignmentsCreated,
        submissionsCreated: fileResult.submissionsCreated,
        warnings: fileResult.warnings.length > 0 ? fileResult.warnings.join(" | ") : null,
      })),
    });

    await prisma.importJob.update({
      where: { id: jobId },
      data: {
        status: "COMPLETED",
        filesProcessed: summary.filesProcessed,
        projectsUpserted: summary.projectsUpserted,
        usersUpserted: summary.usersUpserted,
        assignmentsCreated: summary.assignmentsCreated,
        submissionsCreated: summary.submissionsCreated,
        warnings: summary.warnings.length > 0 ? summary.warnings.join(" | ") : null,
        completedAt: new Date(),
      },
    });

    await logAuditEvent({
      action: "DATA_IMPORTED",
      userId: actorId,
      resourceType: "system",
      resourceId: jobId,
      metadata: {
        jobId,
        mode: dryRun ? "dry-run" : "apply",
        filesProcessed: summary.filesProcessed,
        projectsUpserted: summary.projectsUpserted,
        assignmentsCreated: summary.assignmentsCreated,
        submissionsCreated: summary.submissionsCreated,
      },
    });

    return NextResponse.json({
      success: true,
      jobId,
      summary,
    });
  } catch (error) {
    if (jobId) {
      await prisma.importJob.update({
        where: { id: jobId },
        data: {
          status: "FAILED",
          errorMessage: error instanceof Error ? error.message : "Unknown import failure",
          completedAt: new Date(),
        },
      });
    }

    console.error("WAR import failed", error);
    return NextResponse.json({ error: "Import failed." }, { status: 500 });
  }
}