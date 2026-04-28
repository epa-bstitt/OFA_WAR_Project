import { Metadata } from "next";
import Link from "next/link";
import { notFound, redirect } from "next/navigation";
import { ArrowLeft } from "lucide-react";
import { PageHeader } from "@/components/shared/PageHeader";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { auth } from "@/lib/auth";
import { hasMinimumRoleLevel } from "@/lib/auth-helpers";
import { getMockContractById, getWarEntriesForContract } from "@/lib/mock-contracts";

interface ContractWarEntriesPageProps {
  params: { id: string };
}

export async function generateMetadata({ params }: ContractWarEntriesPageProps): Promise<Metadata> {
  const contract = getMockContractById(params.id);

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

  const contract = getMockContractById(params.id);

  if (!contract) {
    notFound();
  }

  const warEntries = getWarEntriesForContract(params.id);

  return (
    <div className="space-y-6">
      <PageHeader
        title={`${contract.contractName} WAR Entries`}
        description="All WAR updates submitted for this contract."
      >
        <Link href="/contracts/outlook">
          <Button variant="outline">
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to Outlook
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
        <div className="space-y-4">
          {warEntries.map((entry) => (
            <Card key={entry.id}>
              <CardHeader>
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <CardTitle className="text-base">Week of {entry.weekOf}</CardTitle>
                  <Badge variant="secondary">{entry.status.replace("_", " ")}</Badge>
                </div>
              </CardHeader>
              <CardContent className="space-y-2">
                <p className="text-xs text-slate-500">Submitted: {entry.submittedAt}</p>
                <p className="text-sm leading-6 text-slate-700">{entry.summary}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
