PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Authoritative replacement for MAINES contract updates provided by user.

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-3a6aa924799c90ebc86046d3';

INSERT INTO submissions (
  id,
  userId,
  projectId,
  componentId,
  contractId,
  weekOf,
  rawText,
  terseText,
  terseVersion,
  aiConfidence,
  status,
  isAiGenerated,
  editedBy,
  publishedAt,
  oneNotePageId,
  deletedAt,
  createdAt,
  updatedAt
)
VALUES
(
  'manual-maines-2026-06-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-29 12:00:00') AS INTEGER) * 1000,
  '6/29/2026:
Invoice:
- Invoice for May is being reviewed.
Funding:
- Current funding will fully fund labor through September.
- CISRC balance: ~$900K expected to last through September; explore moving CISRC into WCF.
Mods:
- Mod 48 expected to be awarded 6/30/2026.
New Contractor/Personnel:
- Two onboarding requests received 6/29/2026.
TZ Projects:
- No issues.
RIPS:
- No issues.
- NOTE: new OP4 buy in FY27 (~$2.4M). Tools CLIN ceiling is sufficient.
Misc:
- Cross funding question:
  - Can we pay WCF expenses with CSIRC funds?
  - We have done the opposite (using WCF to cover CISRC).
  - Concern: CISRC is appropriated funding obligated to one CLIN.
- Prior year funds: Ask how to use prior year appropriations to fund current CISRC needs.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '5/4/2026:
Invoice:
- Invoice for March has been reviewed and submitted for GSA approval. April''s is expected to be delivered in the first week of May.
Funding:
- Current funding is expected to last through 30 June now that Mod 45 has been awarded.
- Requesting $30.5M to fully fund FY26.
Mods:
- Mod 46 is realigning CSIRC appropriated 25/26 funding from OY3 to OY4.
- Mod 47 will increase the MAINES total ceiling by $90M. Anything higher will require Senior Procurement Executive review and approval and add months to the modification review.
- Mod 48 will add funding (hopefully for the remainder of FY26).
- One of the above mods will also include the Award Fee for the previous period and a revision to the number of monthly deliverables.
New Contractor/Personnel:
- No new contractor personnel were added to the task order in the past two weeks.
TZ Projects:
- Increase in TZ service questions due to role changes across EPA; slide deck in progress.
RIPS:
- 3 RIPs approved, including ~$3M in Cisco equipment to be delivered/invoiced by end of FY26.
- This ~$3M was not included in tools budget but will be paid with Capital Asset funds.
Misc:
- Award Fee Evaluation Board was held 23 April. GSA is working on final documentation.
- SLAs will be reviewed and revised in May.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '4/21/2026:
Invoice:
- Invoice for March has been reviewed and submitted for GSA approval. April''s is expected to be delivered in first week of May.
Funding:
- Current funding is expected to last through 30 June now that Mod 45 has been awarded.
- Clarification requested and revised runout date noted.
Mods:
- Mod 45 has been awarded and funding by $25M has been added to the task order.
- Mod 46 will increase MAINES total ceiling by $90M; higher requires Senior Procurement Executive review.
New Contractor/Personnel:
- No new contractor personnel in the past two weeks.
TZ Projects:
- Increased questions due to role changes; working on basic intro slide deck.
- New projects get TZ Reg ID and tracking, including ITOD projects.
- TZ O&M projects will move to different cost center in FY28.
- New RACI chart and policies reduced registrations exceeding budget.
- Customer outreach for FY27 estimates and EOC reviews planned for May/June.
RIPS:
- 2 RIPs pending approval including ~$3M Cisco equipment requiring delivery/invoice by end of FY.
Misc:
- Award Fee Evaluation Board scheduled for 23 April.
- 31 deliverables targeted for approval by 23 April; reduction in deliverables being coordinated with GSA for Mod 47.
- SLAs will be reviewed and revised in May.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-04-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-07 12:00:00') AS INTEGER) * 1000,
  '4/7/2026:
Invoice:
- Invoice for March is expected by 10 April.
Funding:
- Current funding is expected to last through 24 April with Mod 44 and realignment of prior OY remaining funds.
- $25M requested to get MAINES through June.
Mods:
- Mod 44 awarded and realigned almost all prior year funding to OY4.
- Mod 45 will increase funding by $25M once funding is received.
- Mod 46 will increase MAINES total ceiling by ~$150M.
New Contractor/Personnel:
- 2 contractors onboarded (1 backfill Task 2, 1 TZ support).
TZ Projects:
- Escalation with a federal PM creating risk of inappropriate contractor direction; active management/oversight in progress.
- New project tracking with TZ Reg ID including ITOD projects.
- TZ O&M projects move to new cost center in FY28.
RIPS:
- 6 RIPs pending approval.
- Travel expected to rise due to regional server consolidation; estimated ~$175K in OY4.
Misc:
- Award Fee Evaluation Board set for 23 April; section feedback review in progress.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '3/24/2026:
Invoice:
- Invoice for February approved by EPA and sent to GSA.
Funding:
- Runout expected through 17 April, possibly 24 April with realignment of prior OY remaining funds.
- A little over $3M in Labor (CLIN X001) possibly available for realignment.
- $16M requested to get MAINES through May.
Mods:
- Mod 43 awarded; incorporated $4.8M for April and exercised OY4.
New Contractor/Personnel:
- 2 new contractors onboarded for TZ support.
TZ Projects:
- Increased new customers after reorg/ORD dismantling causing TZ process confusion; training/process improvements in progress.
- Continued work to reduce TZ overhead and move continuous TZ projects to O&M; FY28 implementation target.
RIPS:
- 1 RIP pending approval.
- Travel expected to increase due to regional server consolidation (~$175K OY4 estimate).
Misc:
- Tools CLIN X002 ceiling increase estimated at ~$150M; concurrence and request to GSA planned this week.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-03-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-10 12:00:00') AS INTEGER) * 1000,
  '3/10/2026:
Invoice:
- Invoice for February expected by 13 March and to be sent to GSA by 27 March.
Funding:
- Runout expected through 17 April, possibly 24 April with realignment of prior OY remaining funds.
- Slightly over $3M in Labor (CLIN 0001) potentially available for realignment.
- $11M requested to get MAINES through May.
Mods:
- Mod 43 awarded; incorporated $4.8M for April and exercised OY4.
New Contractor/Personnel:
- 1 contractor onboarded to support TZ.
TZ Projects:
- Increased customer volume after reorg and ORD dismantling causing confusion about TZ service model.
- Process improvements and TZ overhead reduction work continues.
- O&M migration discussions with accountants underway for FY28.
RIPS:
- 2 RIPs pending approval.
- 4 TARs pending approval.
- Travel expected to increase due to regional server consolidation.
Misc:
- Tools CLIN 0002 ceiling increase estimated at ~$130M; awaiting GDIT recommendation and formal GSA request package.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-24 12:00:00') AS INTEGER) * 1000,
  '2/24/2026:
Invoice:
- Invoice for January received 17 February and to be sent to GSA by 27 February.
Funding:
- Runout expected through 17 April, possibly 24 April with realignment of prior OY remaining funds.
Mods:
- Mod 43 will incorporate $4.8M for April funding and exercise OY4.
New Contractor/Personnel:
- 2 new contractors onboarded.
TZ Projects:
- No issues.
- Process improvement and TZ overhead reduction work continues.
- O&M migration planning with accountants underway for FY28.
RIPS:
- 0 RIPs pending approval.
Misc:
- No additional updates.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '2/10/2026:
Invoice:
- Invoice for January anticipated by 13 February.
Funding:
- Current funding expected to last through 17 April; possibly 24 April with realignment of previous OY remaining funds.
Mods:
- Mod 42 awarded and incorporated award fee plus $18M incremental funding.
- Ceiling increase modification required before exercising OY4 in April.
New Contractor/Personnel:
- 2 contractors onboarded.
TZ Projects:
- No issues.
- Ongoing work with GDIT on process improvements, overhead reduction, and migration of continuous TZ projects to O&M.
RIPS:
- 1 RIP awaiting approval pending EOC review.
Misc:
- Salesforce meeting cancelled and will not be rescheduled.
- Award Fee Board voting members being updated due to reorg.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2026-01-13',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-13 12:00:00') AS INTEGER) * 1000,
  '1/13/2026:
Invoice:
- Invoice for December received and to be submitted to GSA by 21 January.
Funding:
- Current funding anticipated through 21 January.
- Funding for February and March should be incorporated into Mod 42 by 16 January with award fee included.
Mods:
- Mod 42 should be signed and awarded by 16 January.
- Ceiling increase modification required in next couple of months before exercising OY4 in April.
New Contractor/Personnel:
- 8 contractors onboarded from a contract absorbed into TZ.
TZ Projects:
- Running smoothly.
RIPS:
- Approved through March.
- Scope review underway; out-of-scope RIPs to get one-year offboarding notice before non-renewal.
Misc:
- Salesforce onsite meeting planned for 22 January with BAP, GDIT, GovCIO, Salesforce, and COR to maximize environment and funding usage.
- Work underway to move TZ projects now considered O&M to other services.
- Award Fee Board voting member list being updated for reorg.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2025-12-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-12-02 12:00:00') AS INTEGER) * 1000,
  '12/2/2025:
Invoice:
- Invoice for October received and to be submitted to GSA by 19 December.
Funding:
- Current funding anticipated through December. December funding mod bilaterally signed 4 December.
- January/February funding in progress and expected in Mod 42 or 43, with award fee affecting sequencing.
Mods:
- Mod 41 awarded adding funding through December.
- Mod 42 should add ~18M through February, incorporate award fee, or both.
New Contractor/Personnel:
- 0 contractors onboarded.
TZ Projects:
- Running smoothly.
- Underfunded by $2.9M based on EAC vs invoiced/funding snapshot.
RIPS:
- Approved through January.
Misc:
- MAINES contractor caused analog line outage at HQ; repair compensation request to GSA planned after AT&T pricing is obtained.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2025-11-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
  '11/3/2025:
Invoice:
- September invoice approved and submitted to GSA. October invoice expected by 7 November.
Funding:
- Current funding anticipated through November.
- Additional funding (~$10M) with GSA to fund through December.
Mods:
- Mod 40 awarded through November.
- Mod 41 will add ~10M through December.
New Contractor/Personnel:
- 4 new contractors onboarded.
TZ Projects:
- Requests continue to move; no issues.
- MAINES tracker totals: Approved 347; Pending Customer Approval 1; Pending Customer FITARA Review 7; Pending EO Compliance Form 39; Pending FITARA Approval 22; Pending FITARA Data Entry 3; Pending WCF Account Manager 4; Grand Total 423.
RIPS:
- Metabase RIP issued; licenses provisioned.
- Unfunded total snapshot: $2,694,547.92.
Misc:
- GDIT shutdown SOP in place; POCs/processes communicated for absence coverage.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2025-10-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
  '10/21/2025:
Invoice:
- September invoice submitted and expected approved by 24 October.
Funding:
- Current funding anticipated through November.
- Additional funding (~$10M) to be added through December.
Mods:
- Mod 40 awarded adding funding through November.
- Mod 41 to add ~10M through December.
New Contractor/Personnel:
- 0 new contractors; 0 net new FTE.
TZ Projects:
- Requests continue moving; no issues.
- MAINES tracker totals: Approved 340; Pending Customer Approval 1; Pending Customer FITARA Review 2; Pending EO Compliance Form 42; Pending FITARA Approval 22; Pending FITARA Data Entry 8; Pending WCF Account Manager 5; Grand Total 420.
RIPS:
- Cisco Smartnet Renewal RIP issued.
- Metabase RIP issued.
- Expected procurements through 31 January with unfunded total $2,863,051.82.
Misc:
- TZ PMO cost reduction tracking with GDIT continues.
- FY26 focus remains stopping underfunded work and improving accountability/processes.
- GDIT shutdown SOP remains in place; key POCs/processes communicated.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-maines-2025-10-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-3a6aa924799c90ebc86046d3' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-3a6aa924799c90ebc86046d3',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-07 12:00:00') AS INTEGER) * 1000,
  '10/7/2025:
Invoice:
- September invoice expected by 10 Oct.
Funding:
- Current funding anticipated through November.
Mods:
- Mod 40 will add funding; GSA expected to execute by 10 Oct.
New Contractor/Personnel:
- 2 new contractors hired. 0 net new FTE.
TZ Projects:
- 382 FY26 TZ registrations totaling $42,160,353.25; work stopped for requests not approved prior to 1 October. No issues.
- MAINES tracker totals: Approved 331; Pending Customer Approval 1; Pending EO Compliance Form 42; Pending Product Manager Review 1; Pending WCF Account Manager 7; Grand Total 382.
RIPS:
- OY3 RIP estimates ~$32M, about +$1M from OY2 and +$5.5M from OY1.
- AWS growth continues; Bedrock initiative estimates at least +$50K and likely more with expanded AI use.
- Cisco Smartnet Renewal RIP (~$3.2M) expired 7 October; service continues through 31 Oct while GDIT finalizes order.
- Metabase purchase expected before month end via reseller path.
Misc:
- GDIT notified of TZ PMO cost reduction target (~$2M to ~$2.5M).
- FY26 focus: stop underfunded projects, improve accountability, align structures to OITO reorg, and modernize relevant policies.
- GDIT shutdown SOP noted; GSA No Impact memo or Partial Stop Work memo path documented based on funding outcomes.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
