import { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { LayoutGrid, List } from "lucide-react";
import { PageHeader } from "@/components/shared/PageHeader";
import { OverseerReviewDeck } from "@/components/features/review/OverseerReviewDeck";
import { OverseerSubmissionSearch } from "@/components/features/review/OverseerSubmissionSearch";
import { BiWeeklySubmissionHistory } from "@/components/features/review/BiWeeklySubmissionHistory";
import { ContractManager } from "@/components/features/contracts/ContractManager";
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

  return (
    <div className="space-y-6">
      <PageHeader
        title="WAR Review"
        description={
          isProgramOverseer
            ? "Review weekly activity report submissions in card view or switch to the contract list view from the icons on the right."
            : "Review and manage weekly activity report submissions"
        }
        section="Program Oversight"
        breadcrumbs={[
          { label: "Dashboard", href: "/dashboard" },
          { label: "WAR Review", href: "/approve" },
        ]}
      >
        {isProgramOverseer ? (
          <div className="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-slate-50 p-1">
            <Link
              href="/approve?view=card"
              aria-label="Switch to card view"
              className={`inline-flex items-center gap-2 rounded-full px-3 py-1.5 text-xs font-medium transition ${
                !isListView
                  ? "bg-white text-slate-900 shadow-sm"
                  : "text-slate-600 hover:bg-white hover:text-slate-900"
              }`}
            >
              <LayoutGrid className="h-3.5 w-3.5" />
              Card View
            </Link>
            <Link
              href="/approve?view=list"
              aria-label="Switch to list view"
              className={`inline-flex items-center gap-2 rounded-full px-3 py-1.5 text-xs font-medium transition ${
                isListView
                  ? "bg-white text-slate-900 shadow-sm"
                  : "text-slate-600 hover:bg-white hover:text-slate-900"
              }`}
            >
              <List className="h-3.5 w-3.5" />
              List View
            </Link>
          </div>
        ) : null}
      </PageHeader>

      {isListView ? (
        <ContractManager initialContracts={contracts} hideFilters />
      ) : (
        <>
          {isProgramOverseer ? (
            <OverseerSubmissionSearch
              submissions={overseerSubmissions}
              currentUserId={session.user.id}
            />
          ) : null}

          <BiWeeklySubmissionHistory
            periods={historyPeriods}
            currentUserId={session.user.id}
          />
        </>
      )}
    </div>
  );
}
