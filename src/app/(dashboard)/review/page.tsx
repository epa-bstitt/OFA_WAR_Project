import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { AutoRefresh } from "@/components/shared/AutoRefresh";
import { ReviewStats } from "@/components/features/review/ReviewStats";
import { ReviewQueue } from "@/components/features/review/ReviewQueue";
import { BiWeeklyStaffCards } from "@/components/features/review/BiWeeklyStaffCards";
import { Card, CardContent } from "@/components/ui/card";
import {
  getPendingSubmissions,
  getBiWeeklyStaffSubmissionStatus,
  getReviewStats,
} from "@/app/actions/review";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";

export const metadata: Metadata = {
  title: "Review Dashboard",
  description: "Review and manage WAR submissions",
};

export const dynamic = "force-dynamic";

export default async function ReviewDashboardPage() {
  // Check permissions
  const session = await auth();
  if (!session?.user?.id) {
    redirect("/login");
  }

  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/unauthorized");
  }

  const storedSettings = await getStoredSettings();
  const aggregatorAccess = getOverseerSettings(storedSettings).aggregatorAccess;
  const isAggregator = session.user.role === "AGGREGATOR";

  if (isAggregator && !aggregatorAccess.reviewDashboardEnabled) {
    return (
      <div className="space-y-6">
        <PageHeader
          title="Review Dashboard"
          description="Review and manage weekly activity report submissions"
        />

        <Card>
          <CardContent className="py-10 text-center text-sm text-slate-600">
            WAR Review is currently unavailable for Aggregator users. Contact the program overseer to restore access.
          </CardContent>
        </Card>
      </div>
    );
  }

  // Fetch data
  const [submissionsResult, statsResult, staffStatusResult] = await Promise.all([
    getPendingSubmissions(),
    getReviewStats(),
    getBiWeeklyStaffSubmissionStatus(),
  ]);

  const submissions = submissionsResult.success ? submissionsResult.submissions : [];
  const stats = statsResult.success
    ? statsResult.stats
    : {
        pending: 0,
        reviewedToday: 0,
        overdue: 0,
        totalThisWeek: 0,
      };
  const staffPeriods = staffStatusResult.success ? staffStatusResult.periods : [];
  const hasLoadFailure =
    !submissionsResult.success || !statsResult.success || !staffStatusResult.success;
  const reviewQuickLinks = isAggregator
    ? undefined
    : [
        { label: "Contract Management Section", href: "/contracts" },
        { label: "Dashboard", href: "/dashboard" },
      ];

  return (
    <div className="space-y-6">
      {isAggregator ? <AutoRefresh intervalMs={45000} /> : null}

      <PageHeader
        title="Review Dashboard"
        description="Review and manage weekly activity report submissions"
        quickLinks={reviewQuickLinks}
      />

      {hasLoadFailure && !isAggregator && (
        <div className="rounded-md border border-amber-300 bg-amber-50 px-4 py-3 text-sm text-amber-900">
          Some review data could not be loaded. Available sections are shown below.
        </div>
      )}

      {!isAggregator && (
        <ReviewStats
          pending={stats.pending}
          updated={stats.reviewedToday}
          approved={stats.totalThisWeek}
        />
      )}

      {staffPeriods.length > 0 && <BiWeeklyStaffCards periods={staffPeriods} />}

      {!isAggregator && <ReviewQueue submissions={submissions} />}
    </div>
  );
}
