import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractUpdateCards } from "@/components/features/dashboard/ContractUpdateCards";
import { ContributorUserSwitcher } from "@/components/features/dashboard/ContributorUserSwitcher";
import { ContractLifecycleNotifier } from "@/components/features/contracts/ContractLifecycleNotifier";
import { Card, CardContent } from "@/components/ui/card";
import { auth } from "@/lib/auth";
import { prisma } from "@/lib/db";
import { isEnhancedContractSubmissionsEnabled } from "@/lib/feature-flags";
import { getMockContractsForUserFromDb } from "@/lib/contracts-db";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";

function isContributorVisibleContract(category: string) {
  return category !== "Legacy Contracts" && category !== "Completed";
}

export const metadata: Metadata = {
  title: "Dashboard",
  description: "View and manage your contract updates",
};

export const dynamic = "force-dynamic";

interface DashboardPageProps {
  searchParams?: {
    asUser?: string;
  };
}

export default async function DashboardPage({ searchParams }: DashboardPageProps) {
  const session = await auth();
  const sessionUserId = session?.user?.id ?? "demo-admin";
  const sessionUserRole = session?.user?.role ?? "ADMINISTRATOR";

  if (sessionUserRole === "PROGRAM_OVERSEER") {
    redirect("/approve");
  }

  if (sessionUserRole === "AGGREGATOR") {
    redirect("/review");
  }

  const contributorUsers = sessionUserRole === "CONTRIBUTOR"
    ? await prisma.user.findMany({
      where: {
        role: "CONTRIBUTOR",
        isActive: true,
      },
      orderBy: [
        { name: "asc" },
        { email: "asc" },
      ],
      select: {
        id: true,
        name: true,
        email: true,
      },
    })
    : [];

  const selectedContributorId = searchParams?.asUser;
  const isAllowedContributorSelection =
    sessionUserRole === "CONTRIBUTOR" &&
    !!selectedContributorId &&
    contributorUsers.some((user) => user.id === selectedContributorId);

  const activeUserId = isAllowedContributorSelection ? selectedContributorId : sessionUserId;

  const contracts = await getMockContractsForUserFromDb(activeUserId);
  const dashboardContracts = contracts.filter((contract) => isContributorVisibleContract(contract.category));
  const storedSettings = await getStoredSettings();
  const contributorAccess = getOverseerSettings(storedSettings).contributorAccess;
  const enhancedEditorEnabled =
    contributorAccess.enhancedEditorEnabled && isEnhancedContractSubmissionsEnabled();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Contract Updates"
        description="Edit this week's updates by contract. Open any card to review its full submission history."
        section="Contributor Workspace"
        breadcrumbs={[
          { label: "Dashboard", href: "/dashboard" },
        ]}
      />

      {sessionUserRole === "CONTRIBUTOR" && contributorUsers.length > 0 ? (
        <ContributorUserSwitcher
          users={contributorUsers}
          selectedUserId={activeUserId}
        />
      ) : null}

      {sessionUserRole === "CONTRIBUTOR" ? (
        <ContractLifecycleNotifier
          contracts={dashboardContracts}
          audience="contributor"
          canAutoMove={false}
        />
      ) : null}

      {!contributorAccess.dashboardEnabled ? (
        <Card>
          <CardContent className="py-10 text-center text-sm text-slate-600">
            Your dashboard is currently unavailable. Contact the program overseer if you need access restored.
          </CardContent>
        </Card>
      ) : contributorAccess.contractCardsVisible ? (
        <ContractUpdateCards
          contracts={dashboardContracts}
          enhancedEditorEnabled={enhancedEditorEnabled}
          submissionsEnabled={contributorAccess.submissionEnabled}
          deadlineOverrideEnabled={contributorAccess.deadlineOverrideEnabled}
        />
      ) : (
        <Card>
          <CardContent className="py-10 text-center text-sm text-slate-600">
            Contract update cards are currently hidden for contributors.
          </CardContent>
        </Card>
      )}
    </div>
  );
}
