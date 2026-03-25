import { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Button } from "@/components/ui/button";
import { PageHeader } from "@/components/shared/PageHeader";
import { CardGrid } from "@/components/shared/CardGrid";
import { RecentSubmissions } from "@/components/features/dashboard/RecentSubmissions";
import { SubmissionStats } from "@/components/features/dashboard/SubmissionStats";
import { getMySubmissions } from "@/app/actions/submissions";
import { isMockModeEnabled } from "@/lib/admin/mock-mode-server";
import { Plus } from "lucide-react";

export const metadata: Metadata = {
  title: "Dashboard",
  description: "View and manage your weekly activity reports",
};

export const dynamic = "force-dynamic";

// Mock submissions for demo mode
const mockSubmissions = [
  {
    id: "mock-sub-1",
    rawText: "Completed API integration and fixed authentication bugs.",
    terseText: "API integration complete; auth bugs fixed.",
    status: "APPROVED" as const,
    createdAt: new Date("2024-02-19"),
    updatedAt: new Date("2024-02-19"),
    confidence: 0.92,
    userId: "demo-contributor",
    weekOf: new Date("2024-02-19"),
    isAiGenerated: true,
    review: null,
  },
  {
    id: "mock-sub-2",
    rawText: "Attended team meeting and reviewed PRs.",
    terseText: "Team meeting attended; PRs reviewed.",
    status: "IN_REVIEW" as const,
    createdAt: new Date("2024-02-18"),
    updatedAt: new Date("2024-02-18"),
    confidence: 0.88,
    userId: "demo-contributor",
    weekOf: new Date("2024-02-18"),
    isAiGenerated: true,
    review: null,
  },
];

export default async function DashboardPage() {
  const useMockData = isMockModeEnabled();
  
  let submissions;
  
  if (useMockData) {
    // Use mock data
    submissions = mockSubmissions;
  } else {
    // Fetch from real database
    const result = await getMySubmissions();
    if (!result.success) {
      redirect("/login");
    }
    submissions = result.submissions;
  }

  return (
    <div className="space-y-6">
      <PageHeader
        title="Dashboard"
        description="Welcome back! Here's an overview of your WAR submissions."
      >
        <Link href="/submit">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            Submit WAR
          </Button>
        </Link>
      </PageHeader>

      <SubmissionStats submissions={submissions} />

      <CardGrid columns={1}>
        <RecentSubmissions submissions={submissions} />
      </CardGrid>
    </div>
  );
}
