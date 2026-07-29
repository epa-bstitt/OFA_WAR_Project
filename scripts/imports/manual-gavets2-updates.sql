PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- GAVETS 2: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-8bdd5dee44f90d09fd873e19';

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
  'manual-gavets2-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30/2026:
Funding:
TPOC requesting from program offices.
Incremental Funding (13B) - applying previously approved $407K - in progress, funding documentation sent to GSA to process.
Funding B funding requests through 09/30 (14) - in progress.
Goal: fund all projects through 09/30 and prepare program offices to forward-fund projects at least through 11/30.
Funding TT/TC projects through 09/30 (15) - in progress.
Transition to G-Invoicing: complete.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-06-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-16 12:00:00') AS INTEGER) * 1000,
  '06/16/2026:
Funding:
TPOC requesting from program offices.
Incremental Funding (14) - applying previously approved $407K - in progress.
Funding unfunded projects / all funding requests through 09/30 (15) - in progress.
Goal: fund all projects through 09/30 and prepare program offices to forward-fund projects at least through 11/30.
Transition to G-Invoicing:
EPA generated GT&C - with GSA now for action.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-06-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-02 12:00:00') AS INTEGER) * 1000,
  '06/02/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project (12) - DONE.
Exercising/incrementally funding OP1 (13) - DONE.
Incremental Funding (14) - applying previously approved $407K - in progress.
Funding unfunded projects / all funding requests through 09/30 (15) - in progress.
Goal: fund all projects through 09/30 and prepare program offices to forward-fund projects at least through 11/30.
Transition to G-Invoicing:
EPA generated GT&C - with GSA now for action.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-05-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-19 12:00:00') AS INTEGER) * 1000,
  '05/19/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project - DONE.
Exercising/incrementally funding OP1 - DONE.
Funding unfunded projects / all funding requests through 09/30 - in progress.
Goal: fund all projects through 09/30 and prepare program offices to forward-fund projects at least through 11/30.
Transition to G-Invoicing:
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-05-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-05 12:00:00') AS INTEGER) * 1000,
  '05/05/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project - DONE.
Funds for OP1 per project:
TPOC working on funding package to send to OCPO - only outstanding requirement is Multiple Appropriations Memo (with SRO for approval).
Anticipate submitting funding package next week (week of 05/03).
Total Dollar Value: $834K. $834K + $250K balance from base year will fund about 2 months.
TPOC will work with OCPO/GSA to move any remaining funds from GAVETS 1 to GAVETS 2.
Next Option Period is 05/13/26.
Transition to G-Invoicing:
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '04/21/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project: funding package sent to GSA.
TPOC will work with OCPO/GSA to update 7600B/LOA Funding Spreadsheet if required.
Total Dollar Value: $513K.
Around $300K required for balance of base. Remainder will roll over to OP1 after invoicing for base period is complete.
Funds for OP1 per project:
TPOC working on funding package to send to OCPO - only outstanding requirement is Multiple Appropriations Memo.
Anticipate submitting funding package next week (week of 04/27).
Total Dollar Value: $1.2M - will fund about 2 months.
Next Option Period is 05/13/26.
Transition to G-Invoicing:
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-04-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-07 12:00:00') AS INTEGER) * 1000,
  '04/07/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project:
Waiting on SRO approval.
Due to TPOC 04/03, will go to GSA week of 04/06.
Total Dollar Value: $275,115.75.
Funds for OP1 per project:
Waiting on SRO approval.
Due to TPOC 04/10, will go to GSA week of 04/13.
Total Dollar Value: $1,874,314.62.
Next Option Period is 05/13/26.
Transition to G-Invoicing:
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-03-25',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-25 12:00:00') AS INTEGER) * 1000,
  '03/25/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from program offices.
Funds for balance of base period per project:
Due to TPOC 04/03, will go to GSA week of 04/06.
Total Dollar Value: $275,115.75.
Funds for OP1 per project:
Due to TPOC 04/10, will go to GSA week of 04/13.
Total Dollar Value: $1,874,314.62.
TPOC submitted CGER; will need for SRO approval.
Next Option Period is 05/13/26.
Transition to G-Invoicing:
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-03-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-10 12:00:00') AS INTEGER) * 1000,
  '03/10/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
TPOC requesting from contractor:
Status of funds for balance of base period per project.
LOE for OP1 per project.
Next Option Period is 05/13/26 - EPA can provide whatever funding it is able to put on contract.
TPOC will use status of funds and LOE to work with program offices on funding documents for balance of base period and OP1 exercise.
Transition to G-Invoicing:
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-24 12:00:00') AS INTEGER) * 1000,
  '02/24/2026:
Transition:
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding:
Next funding action will be this month. Should require funds for the balance of the Period of Performance.
Next Option Period is 05/13/26 - GSA was requesting ~30% of Option Period. This turned out to be incorrect, and EPA can provide whatever funding it is able to put on contract.
Transition to G-Invoicing:
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '02/10/2026:
Transition:
Transition in process. Garrett Hayes will be TPOC, Michelle Cuilla will be alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Paperwork has been submitted but will not be processed until after next funding action is complete. Should be sometime this month.
Official transition date has not yet been finalized.
Funding:
Next funding action will be this month. Should be requiring funds for the balance of the Period of Performance.
Next Option Period is 05/13/26 - GSA is requesting ~30% of Option Period.
Transition to G-Invoicing:
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-01-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-29 12:00:00') AS INTEGER) * 1000,
  '01/29/2026:
Transition in process. Garrett Hayes will be TPOC, Michelle Cuilla will be alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg. GSA is beginning paperwork to process transition.
Next funding action will be in February.
Official transition date has not yet been finalized.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-gavets2-2026-01-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-8bdd5dee44f90d09fd873e19' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-garrett-hayes'),
  'import-contract-8bdd5dee44f90d09fd873e19',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
  '01/05/2026:
High-level transition kickoff meeting held 12/15. Both ITOD TPOC and current TPOC were out of office 12/19 - 01/05.
Detailed transition meetings scheduled to begin week of 01/05.
Official transition date has not yet been finalized.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
