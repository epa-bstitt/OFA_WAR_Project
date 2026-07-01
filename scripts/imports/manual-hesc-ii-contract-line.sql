PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Update HESC II contract line details and rebuild timeline from provided updates.
UPDATE projects
SET
  name = 'HESC II',
  description = json_set(
    description,
    '$.activeContract.contractName', 'HESC II',
    '$.activeContract.contractNumber', '47QFCA22F0020',
    '$.activeContract.nextPeriodOfPerf', '4/4/2027',
    '$.activeContract.ultimateCompletionDate', '4/3/2030',
    '$.activeContract.tpoc', 'Dawn Lamb',
    '$.activeContract.altTpoc', 'Michelle Cuilla',
    '$.activeContract.cor', 'Hayden Shock (GSA)',
    '$.activeContract.co', 'Brendan Miller (GSA)',
    '$.activeContract.cs', 'Brendan Miller (GSA)',
    '$.currentUpdatePlaceholder', 'Add this week''s HESC II update here.'
  )
WHERE id = 'hesc-ii';

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'hesc-ii';

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
  'manual-hesc-ii-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
HESC II Deliverables - Invoice and Monthly Status reports
- Still pending all approvals.
EVML:
- Deliverable 42 - EMVL Project Progress Report approved (pending J. Dunn)
HPC:
- Nothing new
Funding:
- The current funding run out date is (8 Oct 26).
MODS:
- MOD 31 - will be the next MOD for incremental funding.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-06-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-06-16 12:00:00') AS INTEGER) * 1000,
  'Update 6/16/2026
EVML:
- Nothing new
HPC:
- Nothing new
Funding:
- The current funding run out date is (8 Oct 26).
MODS:
- MOD 30 - will be the next MOD for incremental funding.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-10-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-10-07 12:00:00') AS INTEGER) * 1000,
  'Update 10/7/2025
- Deliverable 26 reviewed and approved.
- GDIT has shutdown plans in place. Contractors are currently working during the shutdown as the contract is funded through December.
- SLURM, RHEL, and GPFS renewals verified.
- Four research requests for FY26 received. Current guidance is to continue projects into FY26 until given more detail.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-10-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
  'Update 10/21/2025
Invoice and Deliverables:
- Received all deliverables on time for September 2025.
Funding:
- Funding in the amount of $950,000.00 has been approved to fund the contract through December 31, 2025.
Mods:
- NA',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-11-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-11-04 12:00:00') AS INTEGER) * 1000,
  'Update 11/4/2025
Invoice and Deliverables:
- No new submittals.
Funding:
- Waiting on signed EO compliance form.
- EPA HESC Program Manager (Heidi Paulsen) working on FY26 requested projects forecasting. Heidi was furloughed 10/27/25.
Mods:
- Partial Shutdown Notice received from GSA on 10/27/25.
- Heidi proposed pausing work on HEXSIM and TrackMyAir.
- Waiting for MOD for incremental funding.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-11-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-11-18 12:00:00') AS INTEGER) * 1000,
  'Update 11/18/2025
Invoice and Deliverables:
- October Deliverables received and concurrence sent to GSA.
- October Invoice received and concurrence sent to GSA.
Funding:
- Need remains at $950,000,000 to fund from 12/24 through 12/31, 2025.
Mods:
- No new Mods.
Contractor Staff Onboarding and Offboarding:
- (1) onboard
- (2) offboard',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-12-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-12-02 12:00:00') AS INTEGER) * 1000,
  'Update 12/2/2025
Invoice and Deliverables:
- No changes.
Funding:
- Need remains at $950,000,000 to fund from 12/24 through 12/31, 2025.
- $600,000 for organizational and $350,000 for GSA costs.
- Funding commitments required by 12/3 from organization SROs.
- GSA has been notified of possible stop work order resulting in lack of funding.
- GSA requires December funding from the EPA by 12/17/25 to process before runout date of 12/24.
Mods:
- No new Mods.
Contractor Staff Onboarding and Offboarding:
- (1) onboard
- (0) offboard',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-12-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-12-16 12:00:00') AS INTEGER) * 1000,
  'Update 12/16/2025
Invoice and Deliverables:
- CCDR and all monthly deliverables received for November 2025.
Funding:
- Incremental Funding received for period through end of January 2026.
Mods:
- No new Mods.
Contractor Staff Onboarding and Offboarding:
- (0) onboard
- (0) offboard',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2025-12-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2025-12-30 12:00:00') AS INTEGER) * 1000,
  'Update 12/30/2025
Invoice and Deliverables:
- December 2025 deliverables due by 1/15/26.
Funding:
- Incremental Funding received for period through end of January 2026.
Mods:
- No new Mods.
Contractor Staff Onboarding and Offboarding:
- (0) onboard
- (0) offboard',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-01-13',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-01-13 12:00:00') AS INTEGER) * 1000,
  'Update 1/13/2026
No changes to report.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-01-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-01-27 12:00:00') AS INTEGER) * 1000,
  'Update 1/27/2026
- Invoice and deliverables for December approved.
- Tasked with reducing deliverables to obtain cost savings - in progress.
- Contractor staff changes: One FTE removed.
- De-obligation of 350k brings funding runout date to early March. Incremental funding through April 30 received $448,424.
- Tiffany sending out letter to HPC users and management that if they are using the service they will need to pay for using the service.
- As a result of ORD no longer existing, centrally funded projects will be ended in the next 6 months when there is no more funding.
- Project Highlights in progress: Voluntary ASM cleanup; FY26 HPC proposals due in February; SYSCat Moderate ATO; EMVL project plans.
- ASM database reconciliation.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  'Update 2/10/2026
- The current performance period (OY3) is due to end on April 3, 2026.
- GSA requires funding no later than March 15, 2026.
- Program Manager (PM) Justification for postponing HESC Restructuring:
- HPC: Will Lominack sent out an email on January 28 to all the HPC PIs and their top managers, with a requirement to start paying for HPC services by the end of Feb; setting up new SC accounts for new offices is in progress.
- EMVL: Heidi Paulsen has been meeting with EPA divisions (OCSPP, OW, etc.) to help them learn about HESC services and drive new business; there are 3 potential new projects.
- PM office waiting for responses from all offices on HPC needs and funding.
- PM office has spoken with more relevant divisions, brought in additional projects, and pivoted to new program offices.
- PM office agrees changes are needed, but has OSIM funding for EMVL projects for the first half of this FY and OAR funding for HPC until May.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-02-24 12:00:00') AS INTEGER) * 1000,
  'Update 2/24/2026
- Incremental funding $448,242 EO Compliance approved 2/16/26.
- HPC FY26 project applications due February 27.
- EMVL MicroSAP project may no longer be funded due to lack of program office approval.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-03-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-03-10 12:00:00') AS INTEGER) * 1000,
  'Update 3/10/2026
- Incremental funding pending $448,242 for 4/1/26 through 5/12/26.
- CPARS reviews submitted to GSA 3/4/26.
- Letters sent out to Program Information offices requesting EMVL project plans and funding by 3/31/26.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  'Update 3/24/2026
- Funding runout date currently May 2.
- Incremental funding request to Garrett on 3/24/26 in the amount of $450,000 through June 1.
- EMVL funding commitments for FY26 have been coming in to Heidi Paulisen with a requested commitment date of 3/31/26.
- TPOC will be sending out a follow-up to Heidi''s funding commitment letter to the SROs encouraging funding commitments and advising of possible service interruptions or stop work.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-04-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-04-07 12:00:00') AS INTEGER) * 1000,
  'Update 4/7/2026
- EVML project requests are received and registrations finalized. Meeting for transitioning Heidi''s work to Jamila and Brian.
- HPC Resource requests: 34 project requests so far, plus an OASES spreadsheet that lists 6 more projects. Five more submissions expected, and 5 projects that will not submit applications but do want to keep their data. Approximately 9 PIs have not responded yet. GDIT is following up.
- Come April 1st, GDIT will turn off access to queues for anyone who has not applied and send automatic notifications to anyone who goes over requested computing hours. They can turn off projects that exceed allocation.
- GDIT is starting the FY27 request process in June; timing of system use application deadlines remains open for Heidi or Jamila.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-hesc-ii-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'hesc-ii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'hesc-ii', NULL, NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  'Update 4/21/2026
EVML:
- Projects are currently transitioning from Heidi''s work to Jamila Guy and Brian Stitt.
HPC:
- Resource requests: 34 project requests so far, plus an OASES spreadsheet that lists 6 more projects. Five more submissions expected, and 5 projects that will not submit applications but do want to keep their data. Approximately 9 PIs have not responded yet. GDIT is following up.
Funding:
- The current funding run out date is (1 June 26).
MODS:
- MOD 27 - exercised Option Year 4 (4 April 26)
- MOD 28 - will be for incremental funding',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
