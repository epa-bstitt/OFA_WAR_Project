"use client";

import { useEffect, useMemo, useState } from "react";
import { Search, UserRound, Briefcase } from "lucide-react";
import { Input } from "@/components/ui/input";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { OverseerReviewDeck, type OverseerSubmission } from "@/components/features/review/OverseerReviewDeck";

type OverseerSubmissionSearchProps = {
  submissions: OverseerSubmission[];
  currentUserId: string;
};

type PersonResult = {
  key: string;
  label: string;
  contracts: OverseerSubmission[];
};

type PersonCandidate = {
  key: string;
  label: string;
  searchText: string;
};

function normalizeText(value: string) {
  return value.trim().toLowerCase();
}

function normalizePersonKey(value: string) {
  return normalizeText(value)
    .replace(/@.*$/, "")
    .replace(/[^a-z0-9]/g, "");
}

function getEmailLocalPart(email?: string | null) {
  const normalizedEmail = normalizeText(email || "");
  if (!normalizedEmail.includes("@")) {
    return normalizedEmail;
  }

  return normalizedEmail.split("@")[0] || "";
}

function contractSearchText(submission: OverseerSubmission): string {
  return normalizeText(
    [
      submission.contractName,
      submission.contractDetails.contractNumber,
      submission.id,
      submission.contractDetails.cor,
      submission.contractDetails.co,
      submission.contractDetails.cs,
      submission.assigneeLabel,
      submission.user.name || "",
      submission.user.email || "",
      submission.rawText,
      submission.terseVersion || "",
    ].join(" ")
  );
}

function getSubmissionPeople(submission: OverseerSubmission) {
  const people = new Map<string, PersonCandidate>();

  const contributorName = submission.user.name?.trim() || submission.user.email || "Unknown Contributor";
  const contributorEmailLocal = getEmailLocalPart(submission.user.email);
  const contributorKey = normalizePersonKey(
    submission.user.name?.trim() || contributorEmailLocal || submission.user.email || contributorName
  );
  people.set(contributorKey, {
    key: contributorKey,
    label: contributorName,
    searchText: normalizeText(`${contributorName} ${submission.user.email || ""} ${contributorEmailLocal}`),
  });

  const assignees = submission.assigneeLabel
    .split(",")
    .map((name) => name.trim())
    .filter((name) => name && normalizeText(name) !== "unassigned");

  for (const assignee of assignees) {
    const assigneeKey = normalizePersonKey(assignee);
    if (!people.has(assigneeKey)) {
      people.set(assigneeKey, {
        key: assigneeKey,
        label: assignee,
        searchText: normalizeText(assignee),
      });
    }
  }

  return Array.from(people.values());
}

function isLegacySubmission(submission: OverseerSubmission) {
  return submission.contractCategory === "Legacy Contracts";
}

function dedupeContractsForPerson(personContracts: OverseerSubmission[]) {
  const latestByContract = new Map<string, OverseerSubmission>();

  for (const contract of personContracts) {
    const contractKey = `${normalizeText(contract.contractName)}|${normalizeText(contract.contractDetails.contractNumber || contract.id)}`;
    const existing = latestByContract.get(contractKey);

    if (!existing || new Date(contract.createdAt).getTime() > new Date(existing.createdAt).getTime()) {
      latestByContract.set(contractKey, contract);
    }
  }

  return Array.from(latestByContract.values()).sort((a, b) =>
    a.contractName.localeCompare(b.contractName)
  );
}

function dedupeContracts(submissions: OverseerSubmission[]) {
  const latestByContract = new Map<string, OverseerSubmission>();

  for (const submission of submissions) {
    const contractKey = `${normalizeText(submission.contractName)}|${normalizeText(submission.contractDetails.contractNumber || submission.id)}`;
    const existing = latestByContract.get(contractKey);

    if (!existing || new Date(submission.createdAt).getTime() > new Date(existing.createdAt).getTime()) {
      latestByContract.set(contractKey, submission);
    }
  }

  return Array.from(latestByContract.values());
}

export function OverseerSubmissionSearch({
  submissions,
  currentUserId,
}: OverseerSubmissionSearchProps) {
  const [query, setQuery] = useState("");
  const [debouncedQuery, setDebouncedQuery] = useState("");
  const [selectedSubmission, setSelectedSubmission] = useState<OverseerSubmission | null>(null);
  const [selectedPerson, setSelectedPerson] = useState<PersonResult | null>(null);

  useEffect(() => {
    const timer = window.setTimeout(() => {
      setDebouncedQuery(query);
    }, 300);

    return () => {
      window.clearTimeout(timer);
    };
  }, [query]);

  const normalizedQuery = normalizeText(debouncedQuery);

  const activeSubmissions = useMemo(
    () => submissions.filter((submission) => !isLegacySubmission(submission)),
    [submissions]
  );

  const contractResults = useMemo(() => {
    if (!normalizedQuery) {
      return [];
    }

    return dedupeContracts(
      activeSubmissions.filter((submission) => contractSearchText(submission).includes(normalizedQuery))
    )
      .sort((a, b) => a.contractName.localeCompare(b.contractName))
      .slice(0, 10);
  }, [activeSubmissions, normalizedQuery]);

  const personResults = useMemo(() => {
    if (!normalizedQuery) {
      return [];
    }

    const peopleMap = new Map<string, PersonResult>();

    for (const submission of activeSubmissions) {
      for (const person of getSubmissionPeople(submission)) {
        if (!person.searchText.includes(normalizedQuery)) {
          continue;
        }

        const existing = peopleMap.get(person.key);
        if (existing) {
          existing.contracts.push(submission);
          continue;
        }

        peopleMap.set(person.key, {
          key: person.key,
          label: person.label,
          contracts: [submission],
        });
      }
    }

    return Array.from(peopleMap.values())
      .map((person) => ({
        ...person,
        contracts: dedupeContractsForPerson(person.contracts),
      }))
      .sort((a, b) => a.label.localeCompare(b.label))
      .slice(0, 10);
  }, [activeSubmissions, normalizedQuery]);

  const hasResults = contractResults.length > 0 || personResults.length > 0;

  return (
    <>
      <section className="rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
        <div className="mb-3 flex items-center gap-2">
          <Search className="h-4 w-4 text-slate-500" />
          <h2 className="text-sm font-semibold text-slate-900">Search Contract or Person</h2>
        </div>

        <div className="relative">
          <Input
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder="Search contract, contract number, person, or WAR text"
            aria-label="Search contracts or people"
          />
        </div>

        {normalizedQuery ? (
          <div className="mt-3 max-h-72 overflow-auto rounded-lg border border-slate-200">
            {hasResults ? (
              <div className="space-y-3 p-2">
                <div>
                  <p className="px-1 pb-1 text-xs font-semibold uppercase tracking-wide text-slate-500">Contracts</p>
                  {contractResults.length > 0 ? (
                    <ul className="divide-y divide-slate-100 rounded-md border border-slate-100">
                      {contractResults.map((submission) => (
                        <li key={submission.id}>
                          <button
                            type="button"
                            onClick={() => {
                              setSelectedPerson(null);
                              setSelectedSubmission(submission);
                            }}
                            className="w-full px-3 py-2 text-left transition hover:bg-slate-50"
                          >
                            <div className="flex flex-wrap items-center gap-3">
                              <span className="inline-flex items-center gap-1 text-xs text-slate-700">
                                <Briefcase className="h-3.5 w-3.5" />
                                {submission.contractName}
                              </span>
                              <span className="inline-flex items-center gap-1 text-xs text-slate-600">
                                <UserRound className="h-3.5 w-3.5" />
                                {submission.assigneeLabel}
                              </span>
                            </div>
                            <p className="mt-1 text-xs text-slate-500">
                              {submission.contractDetails.contractNumber || "No Contract Number"} | {submission.contractDetails.office || "No Office"}
                            </p>
                          </button>
                        </li>
                      ))}
                    </ul>
                  ) : (
                    <p className="rounded-md border border-slate-100 px-3 py-2 text-xs text-slate-500">No contract matches.</p>
                  )}
                </div>

                <div>
                  <p className="px-1 pb-1 text-xs font-semibold uppercase tracking-wide text-slate-500">People</p>
                  {personResults.length > 0 ? (
                    <ul className="divide-y divide-slate-100 rounded-md border border-slate-100">
                      {personResults.map((person) => (
                        <li key={person.key}>
                          <button
                            type="button"
                            onClick={() => setSelectedPerson(person)}
                            className="w-full px-3 py-2 text-left transition hover:bg-slate-50"
                          >
                            <div className="flex items-center justify-between gap-3">
                              <span className="inline-flex items-center gap-1 text-xs text-slate-700">
                                <UserRound className="h-3.5 w-3.5" />
                                {person.label}
                              </span>
                              <span className="text-xs text-slate-500">
                                {person.contracts.length} contract{person.contracts.length === 1 ? "" : "s"}
                              </span>
                            </div>
                          </button>
                        </li>
                      ))}
                    </ul>
                  ) : (
                    <p className="rounded-md border border-slate-100 px-3 py-2 text-xs text-slate-500">No people match.</p>
                  )}
                </div>
              </div>
            ) : (
              <p className="px-3 py-4 text-sm text-slate-500">No matching contracts or people found.</p>
            )}
          </div>
        ) : null}
      </section>

      <Dialog
        open={Boolean(selectedPerson)}
        onOpenChange={(open) => {
          if (!open) {
            setSelectedPerson(null);
          }
        }}
      >
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{selectedPerson?.label || "Person"}</DialogTitle>
            <DialogDescription>
              Select a contract to open its submission card preview.
            </DialogDescription>
          </DialogHeader>

          <div className="max-h-[60vh] overflow-auto rounded-lg border border-slate-200">
            {selectedPerson?.contracts.length ? (
              <ul className="divide-y divide-slate-100">
                {selectedPerson.contracts.map((submission) => (
                  <li key={`person-${selectedPerson.key}-${submission.id}`}>
                    <button
                      type="button"
                      onClick={() => {
                        setSelectedSubmission(submission);
                        setSelectedPerson(null);
                      }}
                      className="w-full px-3 py-2 text-left transition hover:bg-slate-50"
                    >
                      <div className="flex flex-wrap items-center gap-3">
                        <span className="inline-flex items-center gap-1 text-xs text-slate-700">
                          <Briefcase className="h-3.5 w-3.5" />
                          {submission.contractName}
                        </span>
                        <span className="text-xs text-slate-500">
                          {submission.contractDetails.contractNumber || "No Contract Number"}
                        </span>
                      </div>
                    </button>
                  </li>
                ))}
              </ul>
            ) : (
              <p className="px-3 py-4 text-sm text-slate-500">No contracts assigned to this person.</p>
            )}
          </div>
        </DialogContent>
      </Dialog>

      <Dialog
        open={Boolean(selectedSubmission)}
        onOpenChange={(open) => {
          if (!open) {
            setSelectedSubmission(null);
          }
        }}
      >
        <DialogContent className="max-w-5xl">
          <DialogHeader>
            <DialogTitle>Submission Card Preview</DialogTitle>
            <DialogDescription>
              Review this selected contract/person entry in the same card format.
            </DialogDescription>
          </DialogHeader>

          <div className="max-h-[72vh] overflow-auto pr-1">
            {selectedSubmission ? (
              <OverseerReviewDeck
                submissions={[selectedSubmission]}
                currentUserId={currentUserId}
                reviewMode="readonly"
              />
            ) : null}
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
