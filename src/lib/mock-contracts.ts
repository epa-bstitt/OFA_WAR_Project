export interface MockContractSubmission {
  id: string;
  weekOf: string;
  submittedAt: string;
  status: "APPROVED" | "IN_REVIEW" | "DRAFT";
  summary: string;
}

export interface ActiveContractDetails {
  contractName: string;
  cor: string;
  contractNumber: string;
  office: string;
  nextPeriodOfPerf: string;
  ultimateCompletionDate: string;
  co: string;
  cs: string;
  orderNumber: string;
}

export interface MockContract {
  id: string;
  category: string;
  contractName: string;
  imageUrl: string;
  imageAlt: string;
  activeContract: ActiveContractDetails;
  previousWeekLabel: string;
  previousWeekSubmission: string;
  currentUpdatePlaceholder: string;
  history: MockContractSubmission[];
}

export interface ContractFormInput {
  contractName: string;
  cor: string;
  contractNumber: string;
  office: string;
  nextPeriodOfPerf: string;
  ultimateCompletionDate: string;
  co: string;
  cs: string;
  orderNumber: string;
  category?: string;
}

interface ContractStore {
  contracts: MockContract[];
}

const mockContractsByUser: Record<string, MockContract[]> = {
  "demo-admin": [
    {
      id: "ebusiness",
      category: "eBusiness",
      contractName: "eBusiness",
      imageUrl:
        "https://images.unsplash.com/photo-1551434678-e076c223a692?auto=format&fit=crop&w=1200&q=80",
      imageAlt:
        "People collaborating in front of analytics and digital workflow screens.",
      activeContract: {
        contractName: "eBusiness",
        cor: "TBD",
        contractNumber: "TBD",
        office: "EPA Office of Mission Support",
        nextPeriodOfPerf: "TBD",
        ultimateCompletionDate: "TBD",
        co: "TBD",
        cs: "TBD",
        orderNumber: "TBD",
      },
      previousWeekLabel: "Week of 04/08",
      previousWeekSubmission:
        "Funding: None. ATOs: urgent task order modification P00060 was signed on 04/06/2026 and additional ATOs are in development. Issues: EPA and the vendor continue negotiating line disconnect costs while the CO drafts a response to dispute ongoing compensation claims.",
      currentUpdatePlaceholder:
        "Add this week's eBusiness contract update here.",
      history: [
        {
          id: "ebusiness-2026-04-08",
          weekOf: "04/08",
          submittedAt: "2026-04-08",
          status: "APPROVED",
          summary:
            "Funding remained unchanged. AT&T ATO work continued, including P00060 execution. EPA continued disputing disconnect charges and prepared a response to the vendor's ongoing compensation request.",
        },
        {
          id: "ebusiness-2026-03-24",
          weekOf: "03/24",
          submittedAt: "2026-03-24",
          status: "APPROVED",
          summary:
            "March-April funding in the amount of $3.35M was processed, with an additional $5.1M request planned. Five ATOs remained in development. EPA continued addressing vendor charges tied to 1,100 line disconnects and IVR transition support.",
        },
        {
          id: "ebusiness-2026-02-27",
          weekOf: "02/27",
          submittedAt: "2026-02-27",
          status: "APPROVED",
          summary:
            "Funding for March-April 2026 was approved and awaited final commitment. Multiple ATOs were in progress. EPA and AT&T continued discussing NGV transition costs, including disconnects and returned hard phones.",
        },
        {
          id: "ebusiness-2026-02-10",
          weekOf: "02/10",
          submittedAt: "2026-02-10",
          status: "IN_REVIEW",
          summary:
            "A Starlink ATO and more than 10 additional ATOs were being developed. EPA reviewed disputed disconnect pricing and assessed the vendor's request for compensation related to unused hard phones.",
        },
      ],
    },
    {
      id: "hesc-ii",
      category: "HESC II",
      contractName: "HESC II",
      imageUrl:
        "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=80",
      imageAlt:
        "A team reviewing technical program data and operational updates on laptops.",
      activeContract: {
        contractName: "HESC II",
        cor: "Hayden Shock (GSA)",
        contractNumber: "47QFCA22F0020",
        office: "EPA",
        nextPeriodOfPerf: "04/04/2026",
        ultimateCompletionDate: "04/03/2030",
        co: "Brendan Miller (GSA)",
        cs: "Brendan Miller (GSA)",
        orderNumber: "",
      },
      previousWeekLabel: "Week of 04/07",
      previousWeekSubmission:
        "Current POP expiration is 4/4/2026, ultimate contract expiration is 4/3/2030, and contract number is 47QFCA22F0020. EVML project requests were received and registrations finalized while transition planning moved Heidi's work to Jamila and Brian. HPC resource requests reached 34 submitted projects plus 6 additional projects on the OASES spreadsheet, with 5 more submissions expected and 9 PIs still pending response. GDIT is following up, preparing queue shutoff and overage notifications for projects that exceed requested hours, and discussing whether the FY27 request cycle should begin in June.",
      currentUpdatePlaceholder:
        "Add this week's HESC II contract update here.",
      history: [
        {
          id: "hesc-ii-2026-04-07",
          weekOf: "04/07",
          submittedAt: "2026-04-07",
          status: "APPROVED",
          summary:
            "EVML requests were finalized and transitioned to Jamila and Brian. HPC demand rose to 34 active requests, 6 additional OASES projects, and 5 expected submissions, while GDIT prepared access shutdown and overage notifications for noncompliant or over-allocation projects.",
        },
        {
          id: "hesc-ii-2026-03-24",
          weekOf: "03/24",
          submittedAt: "2026-03-24",
          status: "APPROVED",
          summary:
            "Funding runout was projected for May 2. A $450,000 incremental funding request was sent to Garrett through June 1, FY26 EMVL funding commitments were being collected by Heidi Paulsen, and the TPOC planned follow-up outreach to SROs to avoid possible service interruptions or stop work.",
        },
        {
          id: "hesc-ii-2026-03-10",
          weekOf: "03/10",
          submittedAt: "2026-03-10",
          status: "APPROVED",
          summary:
            "Incremental funding of $448,242 for 4/1/2026 through 5/12/2026 remained pending. CPARS reviews were submitted to GSA on 3/4/2026, and letters were sent to program offices requesting EMVL project plans and funding commitments by 3/31/2026.",
        },
        {
          id: "hesc-ii-2026-02-24",
          weekOf: "02/24",
          submittedAt: "2026-02-24",
          status: "IN_REVIEW",
          summary:
            "EO Compliance approved incremental funding of $448,242 on 2/16/2026. HPC FY26 project applications were due February 27, and the EMVL MicroSAP project plan was no longer expected to receive funding because the program office did not approve it.",
        },
      ],
    },
    {
      id: "iti-iii",
      category: "ITI III",
      contractName: "ITI III",
      imageUrl:
        "https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1200&q=80",
      imageAlt:
        "Modern operations room with screens and workspace used for IT transition planning.",
      activeContract: {
        contractName: "ITI III",
        cor: "Valisha Jackson; Craig Hammel; Jon Richardson",
        contractNumber: "HHSN316201200065W",
        office: "NIH",
        nextPeriodOfPerf: "05/31/2026",
        ultimateCompletionDate: "08/27/2027",
        co: "Christopher Cunningham, NIH",
        cs: "N/A",
        orderNumber: "75N98122F00001",
      },
      previousWeekLabel: "Week of 03/10",
      previousWeekSubmission:
        "Current POP expiration is 05/31/2026, ultimate contract expiration is August 27, 2027, and the task order remains in transition. Current updates note that a fresh update is still needed, but transition planning continued through a March 2 briefing with leadership, discussion that the ATO will be extended, and planning for GSS infrastructure to move to the IT Operations Division. A contractor-led overview presentation was tentatively scheduled for April 15, 2026, the next weekly transition meeting was set for March 11, and funding for OY3Q4 remained queued in G-Invoicing while awaiting SRO signature. Approximately $891K from OY2 and $31K from OY3Q1 still needed to be de-obligated.",
      currentUpdatePlaceholder:
        "Add this week's ITI III contract update here.",
      history: [
        {
          id: "iti-iii-2026-03-10",
          weekOf: "03/10",
          submittedAt: "2026-03-10",
          status: "IN_REVIEW",
          summary:
            "Transition planning continued with a March 2 leadership briefing, notice that the ATO would be extended, and preparation for a contractor-led overview presentation on April 15. OY3Q4 funding was queued in G-Invoicing but still awaited SRO signature, and approximately $891K from OY2 plus $31K from OY3Q1 remained to be de-obligated.",
        },
        {
          id: "iti-iii-2026-02-10",
          weekOf: "02/10",
          submittedAt: "2026-02-10",
          status: "APPROVED",
          summary:
            "A transition meeting was scheduled for 2/11/2026. Ongoing risks remained around lack of ownership for the GSS system, missing technical leadership, and NIST-related security concerns, while funding actions moved through Executive Compliance and lapse planning.",
        },
        {
          id: "iti-iii-2026-01-28",
          weekOf: "01/28",
          submittedAt: "2026-01-28",
          status: "APPROVED",
          summary:
            "Weekly transition meetings were established for Wednesdays from 10:30 to 11:30 a.m. Planning focused on the transition outline, vendor access, invoice processing, and documentation, while contract period-of-performance funding and lapse planning remained active issues.",
        },
        {
          id: "iti-iii-2026-01-05",
          weekOf: "01/05",
          submittedAt: "2026-01-05",
          status: "APPROVED",
          summary:
            "The contract vehicle remained in the early stages of transition under current personnel. Risks included uncertainty around separation of duties, the current ATO expiring in June 2026, lack of a named IMO/SIO/ISO owner, and unresolved access actions tied to CBI support on the contract.",
        },
      ],
    },
  ],
  "demo-contributor": [],
  "demo-aggregator": [],
  "demo-overseer": [],
};

function slugifyContractName(value: string): string {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 36);
}

function createContractId(contractName: string): string {
  const slug = slugifyContractName(contractName);
  const suffix = Math.random().toString(36).slice(2, 7);
  return `${slug || "contract"}-${suffix}`;
}

function normalizeContractInput(input: ContractFormInput): ContractFormInput {
  return {
    contractName: input.contractName.trim(),
    cor: input.cor.trim(),
    contractNumber: input.contractNumber.trim(),
    office: input.office.trim(),
    nextPeriodOfPerf: input.nextPeriodOfPerf.trim(),
    ultimateCompletionDate: input.ultimateCompletionDate.trim(),
    co: input.co.trim(),
    cs: input.cs.trim(),
    orderNumber: input.orderNumber.trim(),
    category: (input.category ?? "Contract").trim() || "Contract",
  };
}

function createContractRecord(input: ContractFormInput): MockContract {
  const normalized = normalizeContractInput(input);

  return {
    id: createContractId(normalized.contractName),
    category: normalized.category ?? "Contract",
    contractName: normalized.contractName,
    imageUrl:
      "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80",
    imageAlt: "Contract and acquisition planning documents on an office desk.",
    activeContract: {
      contractName: normalized.contractName,
      cor: normalized.cor,
      contractNumber: normalized.contractNumber,
      office: normalized.office,
      nextPeriodOfPerf: normalized.nextPeriodOfPerf,
      ultimateCompletionDate: normalized.ultimateCompletionDate,
      co: normalized.co,
      cs: normalized.cs,
      orderNumber: normalized.orderNumber,
    },
    previousWeekLabel: "Week of N/A",
    previousWeekSubmission: "No prior submission yet.",
    currentUpdatePlaceholder: `Add this week's ${normalized.contractName} contract update here.`,
    history: [],
  };
}

const globalForContractStore = globalThis as unknown as {
  contractStore: ContractStore | undefined;
};

function buildInitialStore(): ContractStore {
  const primaryContracts = mockContractsByUser["demo-admin"];
  const clonedContracts = primaryContracts.map((contract) => ({
    ...contract,
    activeContract: { ...contract.activeContract },
    history: contract.history.map((entry) => ({ ...entry })),
  }));

  return { contracts: clonedContracts };
}

function getContractStore(): ContractStore {
  if (!globalForContractStore.contractStore) {
    globalForContractStore.contractStore = buildInitialStore();
  }

  return globalForContractStore.contractStore;
}

function cloneContract(contract: MockContract): MockContract {
  return {
    ...contract,
    activeContract: { ...contract.activeContract },
    history: contract.history.map((entry) => ({ ...entry })),
  };
}

export function getContractsOutlook(): MockContract[] {
  return getContractStore().contracts.map(cloneContract);
}

export function createContract(input: ContractFormInput): MockContract {
  const contract = createContractRecord(input);
  getContractStore().contracts.unshift(contract);
  return cloneContract(contract);
}

export function updateContract(contractId: string, input: ContractFormInput): MockContract | null {
  const store = getContractStore();
  const index = store.contracts.findIndex((contract) => contract.id === contractId);

  if (index === -1) {
    return null;
  }

  const current = store.contracts[index];
  const normalized = normalizeContractInput(input);
  const updated: MockContract = {
    ...current,
    category: normalized.category ?? current.category,
    contractName: normalized.contractName,
    activeContract: {
      contractName: normalized.contractName,
      cor: normalized.cor,
      contractNumber: normalized.contractNumber,
      office: normalized.office,
      nextPeriodOfPerf: normalized.nextPeriodOfPerf,
      ultimateCompletionDate: normalized.ultimateCompletionDate,
      co: normalized.co,
      cs: normalized.cs,
      orderNumber: normalized.orderNumber,
    },
    currentUpdatePlaceholder: `Add this week's ${normalized.contractName} contract update here.`,
  };

  store.contracts[index] = updated;
  return cloneContract(updated);
}

export function deleteContract(contractId: string): boolean {
  const store = getContractStore();
  const initialLength = store.contracts.length;
  store.contracts = store.contracts.filter((contract) => contract.id !== contractId);
  return store.contracts.length < initialLength;
}

export function addWarEntryToContract(
  contractId: string,
  update: { summary: string; weekOf?: string; status?: MockContractSubmission["status"] }
): MockContractSubmission | null {
  const store = getContractStore();
  const contract = store.contracts.find((item) => item.id === contractId);

  if (!contract) {
    return null;
  }

  const now = new Date();
  const isoDate = now.toISOString().slice(0, 10);
  const weekOf = update.weekOf?.trim() || now.toLocaleDateString("en-US", {
    month: "2-digit",
    day: "2-digit",
  });
  const summary = update.summary.trim();

  if (!summary) {
    return null;
  }

  const entry: MockContractSubmission = {
    id: `${contractId}-${now.getTime()}`,
    weekOf,
    submittedAt: isoDate,
    status: update.status ?? "IN_REVIEW",
    summary,
  };

  contract.history.unshift(entry);
  contract.previousWeekLabel = `Week of ${entry.weekOf}`;
  contract.previousWeekSubmission = entry.summary;

  return { ...entry };
}

export function getWarEntriesForContract(contractId: string): MockContractSubmission[] {
  const contract = getContractStore().contracts.find((item) => item.id === contractId);
  if (!contract) {
    return [];
  }

  return contract.history.map((entry) => ({ ...entry }));
}

export function getMockContractsForUser(userId: string): MockContract[] {
  if (userId === "demo-admin") {
    return getContractsOutlook();
  }

  const contracts = mockContractsByUser[userId];
  if (contracts && contracts.length > 0) {
    return contracts.map(cloneContract);
  }

  return getContractsOutlook();
}

export function getMockContractById(contractId: string): MockContract | undefined {
  return getContractsOutlook().find((contract) => contract.id === contractId);
}