import { Metadata } from "next";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractUpdateCards } from "@/components/features/dashboard/ContractUpdateCards";
import { auth } from "@/lib/auth";
import { isEnhancedContractSubmissionsEnabled } from "@/lib/feature-flags";
import { getContractsOutlookFromDb, getMockContractsForUserFromDb } from "@/lib/contracts-db";
import { getStoredSettings } from "@/app/api/admin/settings/store";
import { getOverseerSettings } from "@/lib/overseer-settings";

function isContributorVisibleContract(category: string) {
  return category !== "Legacy Contracts" && category !== "Completed";
}

export const metadata: Metadata = {
  title: "Submit Weekly Activity Report",
  description: "Submit your weekly status update",
};

export const dynamic = "force-dynamic";

export default async function SubmitPage() {
  const session = await auth();
  const allContracts = await getContractsOutlookFromDb();
  const contracts = await getMockContractsForUserFromDb(session?.user?.id ?? "demo-admin");
  const submitContracts = contracts.filter((contract) => isContributorVisibleContract(contract.category));
  const contributorDirectory = Array.from(
    new Map(
      allContracts.flatMap((contract) =>
        (contract.assignees ?? []).map((assignee) => [
          assignee.id,
          {
            id: assignee.id,
            name: assignee.name || assignee.id,
            email: assignee.email || "",
          },
        ])
      )
    ).values()
  );
  const storedSettings = await getStoredSettings();
  const contributorAccess = getOverseerSettings(storedSettings).contributorAccess;
  const enhancedEditorEnabled =
    contributorAccess.enhancedEditorEnabled && isEnhancedContractSubmissionsEnabled();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Submit Weekly Activity Report"
        description="Open a project card to enter this week's update, carry forward prior items, and submit the contracts that need changes."
      />
      <ContractUpdateCards
        contracts={submitContracts}
        contributorDirectory={contributorDirectory}
        enhancedEditorEnabled={enhancedEditorEnabled}
        submissionsEnabled={contributorAccess.submissionEnabled}
        deadlineOverrideEnabled={contributorAccess.deadlineOverrideEnabled}
      />
    </div>
  );
}
