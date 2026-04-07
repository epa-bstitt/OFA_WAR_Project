import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ApprovalDashboard } from "@/components/features/approve/ApprovalDashboard";
import {
  getInReviewSubmissions,
  getApprovalStats,
  approveSubmission,
  rejectSubmission,
  exportSubmissionsToCSV,
} from "@/app/actions/approve";
import { batchApprove, batchReject } from "@/app/actions/batch-approve";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { auth } from "@/lib/auth";

export const metadata: Metadata = {
  title: "Approve WARs",
  description: "Review and approve submissions for publication",
};

export const dynamic = "force-dynamic";

export default async function ApprovePage() {
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

  // Fetch data
  const [submissionsResult, statsResult] = await Promise.all([
    getInReviewSubmissions(),
    getApprovalStats(),
  ]);

  if (!submissionsResult.success || !statsResult.success) {
    return (
      <div className="p-8 text-center">
        <p className="text-red-600">Failed to load approval data</p>
      </div>
    );
  }

  // Server actions for client component
  async function handleApprove(id: string, notes?: string) {
    "use server";
    const result = await approveSubmission(id, notes);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleReject(id: string, reason: string) {
    "use server";
    const result = await rejectSubmission(id, reason);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleExport(ids?: string[]) {
    "use server";
    const result = await exportSubmissionsToCSV(ids);
    if (!result.success) {
      throw new Error(result.error);
    }
    return { csv: result.csv, filename: result.filename };
  }

  async function handleBatchApprove(ids: string[], notes?: string) {
    "use server";
    const result = await batchApprove(ids, notes);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  async function handleBatchReject(ids: string[], reason: string) {
    "use server";
    const result = await batchReject(ids, reason);
    if (!result.success) {
      throw new Error(result.error);
    }
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Approve WARs"
        description="Review and approve submissions for publication. View edit history, filter by criteria, and export to CSV."
      />

      <ApprovalDashboard
        submissions={submissionsResult.submissions}
        stats={statsResult.stats}
        onApprove={handleApprove}
        onReject={handleReject}
        onBatchApprove={handleBatchApprove}
        onBatchReject={handleBatchReject}
        onExport={handleExport}
      />
    </div>
  );
}
