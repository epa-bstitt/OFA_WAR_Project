import { Metadata } from "next";
import { redirect } from "next/navigation";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractUpdateCards } from "@/components/features/dashboard/ContractUpdateCards";
import { ContractLifecycleNotifier } from "@/components/features/contracts/ContractLifecycleNotifier";
import { Card, CardContent } from "@/components/ui/card";
import { auth } from "@/lib/auth";
import { isEnhancedContractSubmissionsEnabled } from "@/lib/feature-flags";
import { getMockContractsForUserFromDb } from "@/lib/contracts-db";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";
import type { Role } from "@/config/navigation";
import { getServerWorkMode } from "@/lib/server-work-mode";

function isContributorVisibleContract(category: string) {
  return category !== "Legacy Contracts" && category !== "Completed";
}

export const metadata: Metadata = {
  title: "Dashboard",
  description: "View and manage your contract updates",
};

export const dynamic = "force-dynamic";

export default async function DashboardPage() {
  const session = await auth();
  const sessionUserId = session?.user?.id ?? "demo-admin";
  const sessionUserEmail = session?.user?.email ?? null;
  const sessionUserRole = session?.user?.role ?? "ADMINISTRATOR";
  const workMode = getServerWorkMode(sessionUserRole as Role, sessionUserId, sessionUserEmail);
  const isContributorMode = workMode === "CONTRIBUTOR";

  if (workMode === "PROGRAM_OVERSEER") {
    redirect("/approve");
  }

  if (workMode === "AGGREGATOR") {
    redirect("/review");
  }

  const contracts = await getMockContractsForUserFromDb(sessionUserId);
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
      />

      {isContributorMode ? (
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
