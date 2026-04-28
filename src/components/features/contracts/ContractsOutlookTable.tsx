import Link from "next/link";
import type { MockContract } from "@/lib/mock-contracts";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

interface ContractsOutlookTableProps {
  contracts: MockContract[];
}

export function ContractsOutlookTable({ contracts }: ContractsOutlookTableProps) {
  return (
    <div className="rounded-xl border border-slate-200 bg-white shadow-sm">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Contracts</TableHead>
            <TableHead>COR</TableHead>
            <TableHead>Contract Number</TableHead>
            <TableHead>Office</TableHead>
            <TableHead>Next Period of Performance</TableHead>
            <TableHead>Ultimate Completion Date</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {contracts.map((contract) => (
            <TableRow key={contract.id}>
              <TableCell className="font-medium">
                <Link
                  href={`/contracts/${contract.id}/wars`}
                  className="text-[#005ea2] underline-offset-2 hover:underline"
                >
                  {contract.contractName}
                </Link>
              </TableCell>
              <TableCell>{contract.activeContract.cor || "-"}</TableCell>
              <TableCell>{contract.activeContract.contractNumber || "-"}</TableCell>
              <TableCell>{contract.activeContract.office || "-"}</TableCell>
              <TableCell>{contract.activeContract.nextPeriodOfPerf || "-"}</TableCell>
              <TableCell>{contract.activeContract.ultimateCompletionDate || "-"}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
