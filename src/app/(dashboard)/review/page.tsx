import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ReviewStats } from "@/components/features/review/ReviewStats";
import { ReviewQueue } from "@/components/features/review/ReviewQueue";
import {
  getPendingSubmissions,
  getReviewStats,
  createReview,
} from "@/app/actions/review";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";

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

  // Fetch data
  const [submissionsResult, statsResult] = await Promise.all([
    getPendingSubmissions(),
    getReviewStats(),
  ]);

  if (!submissionsResult.success || !statsResult.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load review data</p>
      </div>
    );
  }

  const submissions = submissionsResult.submissions;
  const stats = statsResult.stats;

  return (
    <div className="space-y-6">
      <PageHeader
        title="Review Dashboard"
        description="Review and manage weekly activity report submissions"
      />

      <ReviewStats
        pending={stats.pending}
        reviewedToday={stats.reviewedToday}
        overdue={stats.overdue}
        totalThisWeek={stats.totalThisWeek}
      />

      <ReviewQueue submissions={submissions} />
    </div>
  );
}
