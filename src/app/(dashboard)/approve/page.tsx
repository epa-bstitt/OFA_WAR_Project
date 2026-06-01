import { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { LayoutGrid, List } from "lucide-react";
import { PageHeader } from "@/components/shared/PageHeader";
import { OverseerSubmissionSearch } from "@/components/features/review/OverseerSubmissionSearch";
import { BiWeeklySubmissionHistory } from "@/components/features/review/BiWeeklySubmissionHistory";
import { WarOverviewExportControls } from "@/components/features/approve/WarOverviewExportControls";
import { ContractManager } from "@/components/features/contracts/ContractManager";
import { ContractLifecycleNotifier } from "@/components/features/contracts/ContractLifecycleNotifier";
import {
  getPendingSubmissions,
} from "@/app/actions/review";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { getContractsOutlookFromDb } from "@/lib/contracts-db";
import { getCurrentSubmissionPeriod, getRecentSubmissionPeriods } from "@/lib/submission-periods";

export const metadata: Metadata = {
  title: "WAR Review",
  description: "Review and manage WAR submissions",
};

export const dynamic = "force-dynamic";

interface ApprovePageProps {
  searchParams?: {
    view?: string;
  };
}

export default async function ApprovePage({ searchParams }: ApprovePageProps) {
  // Check authentication
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  // Check permissions (PROGRAM_OVERSEER+)
  const hasPermission = await hasMinimumRoleLevel("PROGRAM_OVERSEER");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  const isProgramOverseer = session.user.role === "PROGRAM_OVERSEER";
  const isListView = isProgramOverseer && searchParams?.view === "list";

  // Fetch submissions needed for pending, updated, and approved buckets.
  const submissionsResult = await getPendingSubmissions({
    statuses: ["SUBMITTED", "INFO_NEEDED", "APPROVED", "PUBLISHED"],
  });

  const submissions = submissionsResult.success ? submissionsResult.submissions : [];
  const contracts = await getContractsOutlookFromDb();
  const now = new Date();
  const currentPeriod = getCurrentSubmissionPeriod(now);
  const recentPeriods = getRecentSubmissionPeriods(now, 6);

  const overseerSubmissions = submissions.map((submission) => {
    const summary = submission.rawText.trim();

    const mappedContractBySummary = contracts.find((contract) => {
      if (!(contract.assigneeIds ?? []).includes(submission.userId)) {
        return false;
      }

      const latestHistory = contract.history[0];
      if (!latestHistory) {
        return false;
      }

      return latestHistory.summary.trim() === summary;
    });

    const mappedContract =
      mappedContractBySummary ||
      contracts.find((contract) => (contract.assigneeIds ?? []).includes(submission.userId));

    const tableLabel =
      mappedContract?.category === "New Awards and Recompetes"
        ? "New Awards and Recompetes"
        : mappedContract?.category === "Legacy Contracts"
          ? "Legacy Contracts"
          : "Current and Active Contracts/Purchase Order Outlook";

    const assigneeLabel =
      mappedContract?.assigneeIds && mappedContract.assigneeIds.length > 0
        ? mappedContract.assigneeIds
            .map((id) => {
              if (id === submission.userId) {
                return submission.user.name || submission.user.email || "Unknown User";
              }
              return id;
            })
            .join(", ")
        : submission.user.name || submission.user.email || "Unknown User";

    return {
      ...submission,
      contractName:
        mappedContract?.contractName ||
        `WAR Submission ${submission.user.name ? `- ${submission.user.name}` : ""}`,
      assigneeLabel,
      contractCategory: tableLabel,
      contractDetails: {
        contractNumber: mappedContract?.activeContract.contractNumber || "",
        office: mappedContract?.activeContract.office || "",
        cor: mappedContract?.activeContract.cor || "",
        nextPeriodOfPerf: mappedContract?.activeContract.nextPeriodOfPerf || "",
        ultimateCompletionDate: mappedContract?.activeContract.ultimateCompletionDate || "",
        co: mappedContract?.activeContract.co || "",
        cs: mappedContract?.activeContract.cs || "",
        orderNumber: mappedContract?.activeContract.orderNumber || "",
      },
      pastUpdates: (mappedContract?.history || []).map((entry) => ({
        id: entry.id,
        weekOf: entry.weekOf,
        submittedAt: entry.submittedAt,
        summary: entry.summary,
        status: entry.status,
      })),
    };
  });

  const historyPeriods = recentPeriods.map((period) => ({
    periodId: period.id,
    label: `Bi-Weekly ${period.label}${period.id === currentPeriod.id ? " (Current)" : ""}`,
    deadline: period.deadline,
    submissions: overseerSubmissions.filter((submission) => {
      const weekOf = new Date(submission.weekOf);
      return weekOf >= period.start && weekOf <= period.end;
    }),
  }));

  const exportContracts = overseerSubmissions
    .filter((submission) => {
      if (submission.status !== "APPROVED") {
        return false;
      }

      const weekOf = new Date(submission.weekOf);
      return weekOf >= currentPeriod.start && weekOf <= currentPeriod.end;
    })
    .map((submission) => ({
      id: submission.id,
      name: submission.contractName,
      category:
        submission.contractCategory === "New Awards and Recompetes" ? "recompetes" : "outlook",
      periodId: currentPeriod.id,
    }));

  return (
    <div className="space-y-6">
      <PageHeader
        title="WAR Review"
        description={
          isProgramOverseer
            ? "Review weekly activity report submissions. Use the toolbar below to export or view logs."
            : "Review and manage weekly activity report submissions"
        }
        section="Program Oversight"
        breadcrumbs={[
          { label: "Dashboard", href: "/dashboard" },
          { label: "WAR Review", href: "/approve" },
        ]}
      >
        {isProgramOverseer ? (
          <div className="flex flex-row gap-3 items-center">
            <Link
              href="/approve?view=card"
              aria-label="Switch to card view"
              className={`rounded-lg px-4 py-2 text-sm font-medium transition border ${
                !isListView
                  ? "bg-white text-slate-900 shadow-md border-slate-300"
                  : "bg-slate-50 text-slate-600 border-slate-200 hover:bg-white hover:text-slate-900"
              }`}
            >
              <LayoutGrid className="h-4 w-4 mr-2" />
              Card View
            </Link>
            <Link
              href="/approve?view=list"
              aria-label="Switch to list view"
              className={`rounded-lg px-4 py-2 text-sm font-medium transition border ${
                isListView
                  ? "bg-white text-slate-900 shadow-md border-slate-300"
                  : "bg-slate-50 text-slate-600 border-slate-200 hover:bg-white hover:text-slate-900"
              }`}
            >
              <List className="h-4 w-4 mr-2" />
              List View
            </Link>
          </div>
        ) : null}
      </PageHeader>

      {isProgramOverseer ? (
        <ContractLifecycleNotifier contracts={contracts} audience="overseer" canAutoMove={false} />
      ) : null}

      {isListView ? (
        <ContractManager initialContracts={contracts} hideFilters />
      ) : (
        <>
          <div className="space-y-4">
            <OverseerSubmissionSearch
              submissions={overseerSubmissions}
              currentUserId={session.user.id}
            />

            <div className="rounded-xl border border-slate-200 bg-white p-4">
              <BiWeeklySubmissionHistory
                periods={historyPeriods}
                currentUserId={session.user.id}
                actionSlot={
                  <WarOverviewExportControls
                    contracts={exportContracts}
                    currentPeriodId={currentPeriod.id}
                  />
                }
              />
            </div>
          </div>
        </>
      )}
    </div>
  );
}
