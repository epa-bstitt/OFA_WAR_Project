import { Metadata } from "next";
import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { ArrowLeft } from "lucide-react";
import { PageHeader } from "@/components/shared/PageHeader";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { WarEntriesList } from "@/components/features/contracts/WarEntriesList";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getContractByIdFromDb, getWarEntriesForContractFromDb } from "@/lib/contracts-db";

interface ContractWarEntriesPageProps {
  params: { id: string };
}

export async function generateMetadata({ params }: ContractWarEntriesPageProps): Promise<Metadata> {
  const contract = await getContractByIdFromDb(params.id);

  return {
    title: contract ? `${contract.contractName} WAR Entries` : "Contract WAR Entries",
    description: "List of WAR entries tied to a contract",
  };
}

export const dynamic = "force-dynamic";

export default async function ContractWarEntriesPage({ params }: ContractWarEntriesPageProps) {
  const session = await auth();
  if (!session?.user) {
    redirect("/login");
  }

  const hasPermission = await hasMinimumRoleLevel("AGGREGATOR");
  if (!hasPermission) {
    redirect("/dashboard");
  }

  const contract = await getContractByIdFromDb(params.id);

  if (!contract) {
    notFound();
  }

  const warEntries = await getWarEntriesForContractFromDb(params.id);

  return (
    <div className="space-y-6">
      <PageHeader
        title={`${contract.contractName} WAR Entries`}
        description="All WAR updates submitted for this contract."
      >
        <Link href="/contracts">
          <Button variant="outline">
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to Contract Management
          </Button>
        </Link>
      </PageHeader>

      {warEntries.length === 0 ? (
        <Card>
          <CardContent className="py-8 text-sm text-slate-600">
            No WAR entries yet for this contract.
          </CardContent>
        </Card>
      ) : (
        <WarEntriesList entries={warEntries} />
      )}
    </div>
  );
}
