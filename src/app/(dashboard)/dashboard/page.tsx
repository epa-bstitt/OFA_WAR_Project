import { Metadata } from "next";
import { PageHeader } from "@/components/shared/PageHeader";
import { ContractUpdateCards } from "@/components/features/dashboard/ContractUpdateCards";
import { auth } from "@/lib/auth";
import { isEnhancedContractSubmissionsEnabled } from "@/lib/feature-flags";
import { getMockContractsForUser } from "@/lib/mock-contracts";

export const metadata: Metadata = {
  title: "Dashboard",
  description: "View and manage your contract updates",
};

export const dynamic = "force-dynamic";

export default async function DashboardPage() {
  const session = await auth();
  const contracts = getMockContractsForUser(session?.user?.id ?? "demo-admin");
  const enhancedEditorEnabled = isEnhancedContractSubmissionsEnabled();

  return (
    <div className="space-y-6">
      <PageHeader
        title="Contract Updates"
        description="Edit this week's updates by contract. Open any card to review its full submission history."
      />

      <ContractUpdateCards
        contracts={contracts}
        enhancedEditorEnabled={enhancedEditorEnabled}
      />
    </div>
  );
}
