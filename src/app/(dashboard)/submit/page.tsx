import { Metadata } from "next";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractUpdateCards } from "@/components/features/dashboard/ContractUpdateCards";
import { auth } from "@/lib/auth";
import { isEnhancedContractSubmissionsEnabled } from "@/lib/feature-flags";
import { getMockContractsForUser } from "@/lib/mock-contracts";

export const metadata: Metadata = {
  title: "Submit Weekly Activity Report",
  description: "Submit your weekly status update",
};

export const dynamic = "force-dynamic";

export default async function SubmitPage() {
  const session = await auth();
  const contracts = getMockContractsForUser(session?.user?.id ?? "demo-admin");
  const enhancedEditorEnabled = isEnhancedContractSubmissionsEnabled();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Submit Weekly Activity Report"
        description="Open a project card to enter this week's update, carry forward prior items, and submit the contracts that need changes."
      />
      <ContractUpdateCards
        contracts={contracts}
        enhancedEditorEnabled={enhancedEditorEnabled}
      />
    </div>
  );
}
