import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/db";
import { sendWorkflowEmail } from "@/lib/notifications/email";
import { getCurrentSubmissionPeriod, isFirstOrThirdTuesday } from "@/lib/submission-periods";

export const dynamic = "force-dynamic";

function isAuthorized(request: NextRequest): boolean {
  const configuredSecret = process.env.CRON_SECRET;
  if (!configuredSecret) {
    return true;
  }

  const authHeader = request.headers.get("authorization") || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : "";
  return token === configuredSecret;
}

function shouldSendNow(now: Date): boolean {
  return isFirstOrThirdTuesday(now) && now.getHours() === 8;
}

export async function GET(request: NextRequest) {
  if (!isAuthorized(request)) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const now = new Date();
  const force = request.nextUrl.searchParams.get("force") === "1";

  if (!force && !shouldSendNow(now)) {
    return NextResponse.json({
      success: true,
      skipped: true,
      reason: "Current time is outside the first/third Tuesday 8:00 AM window.",
      timestamp: now.toISOString(),
    });
  }

  const contributors = await prisma.user.findMany({
    where: {
      role: "CONTRIBUTOR",
      isActive: true,
      email: {
        not: null,
      },
    },
    select: {
      id: true,
      name: true,
      email: true,
      projectAssignments: {
        where: {
          componentId: null,
        },
        select: {
          project: {
            select: {
              name: true,
            },
          },
        },
      },
    },
  });

  const appUrl = process.env.NEXTAUTH_URL || process.env.NEXT_PUBLIC_APP_URL || "http://localhost:3000";
  const dashboardUrl = `${appUrl}/dashboard`;
  const currentPeriod = getCurrentSubmissionPeriod(now);

  let sentCount = 0;
  const failures: Array<{ userId: string; email: string; error: string }> = [];

  for (const contributor of contributors) {
    if (!contributor.email) {
      continue;
    }

    const assignedProjects = contributor.projectAssignments.map((assignment) => assignment.project.name);
    const projectList = assignedProjects.length > 0
      ? `Assigned contracts/projects:\n- ${assignedProjects.join("\n- ")}`
      : "You have no explicit project assignments listed, but please check the dashboard for any required WAR updates.";

    const result = await sendWorkflowEmail({
      to: [contributor.email],
      subject: `WAR Reminder: Submission Due by 5:00 PM (${currentPeriod.label})`,
      textBody:
        `Hello ${contributor.name || contributor.email},\n\n` +
        `This is your automated WAR reminder for the current submission cycle (${currentPeriod.label}).\n` +
        `WAR updates are due by 5:00 PM today.\n\n` +
        `${projectList}\n\n` +
        `Open your dashboard to submit or update entries: ${dashboardUrl}\n\n` +
        `Thank you.`,
    });

    if (result.success) {
      sentCount += 1;
    } else {
      failures.push({
        userId: contributor.id,
        email: contributor.email,
        error: result.error || "Unknown send failure",
      });
    }
  }

  return NextResponse.json({
    success: true,
    period: currentPeriod.id,
    recipients: contributors.length,
    sentCount,
    failedCount: failures.length,
    failures,
  });
}
