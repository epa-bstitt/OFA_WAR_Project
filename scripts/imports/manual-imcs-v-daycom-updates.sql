PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- IMCS V-Daycom: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cmrjd4cam0000ixymq3f9h2a0';

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
  'manual-imcs-v-daycom-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
No update.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-05-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-19 12:00:00') AS INTEGER) * 1000,
  '5/19/2026:
No updates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-30 12:00:00') AS INTEGER) * 1000,
  '4/30/2026:
We meet with the CO on the IMCS V contract to discuss some procedural issues, and the upcoming re-compete. I will be sending out info on the re-compete early next year. I was asked by the CO to gently remind the TCORs of the following:
All PRs for option exercise should be submitted 90 days prior to end of current POP.
Once a task order expires, the option cannot be exercised.
Lack of an option exercise does not result in a stop work; it results in a task order ending.
A stop work cannot be used in leu of an option exercise.
If the option is not exercised by end of current POP, the task order must be re-competed, and no work will be done until a new task order is awarded.
TOCORs are responsible for tracking their funding and submitting PRs prior to funding deficit. Incremental funding should be submitted 45 days prior to required obligation.
All PRs should be routed to COR for review before submitting to CO.
Approved Compliance memos are required to be submitted as attachments to all EAS actions.
I intend to set up a monthly “Office Hours” meeting in Teams soon, to allow for any issues, concerns or questions you may have. You do not need to wait for Teams office hours if you have an immediate question, feel free to call, teams chat or email me any time. Thank you so much for your ongoing support.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '4/21/2026:
No update.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-04-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-09 12:00:00') AS INTEGER) * 1000,
  '4/09/2026:
No Update.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '3/24/2026:
No Update.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-03-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-09 12:00:00') AS INTEGER) * 1000,
  '3/9/2026:
1 CLIN 2001 – 01 January 2026 – 31 January 2026 $49,219.58 $49,219.58.
TOTAL DUE $49,219.58.
Option Year 2:
5/1/2025-4/30/2026.
Remaining Funds Allocations $147,658.78.
Total Contract Amount $590,635.00.
Funds Allocated 33.33%.
Total Funded $590,635.00. Total Amount Billed $49,219.58.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-24 12:00:00') AS INTEGER) * 1000,
  '2/24/2026:
This is for the IMCS V Contract concerning record keeping and storage.
From Ryan Philbrick, this is a follow up email to the conversation that we had yesterday, about potential cost savings at the agency. As part of an ongoing effort to quantify and document agency wide cost savings associated with centralizing paper records management activities at the National Digitization Centers (NDCs), we are requesting some assistance in obtaining some acquisition documents for the ICMS contract.
Specifically, we are requesting copies of the Performance Work Statements and Independent Government Cost Estimates for all active and recently completed task orders under the ICMS vehicle. We want to analyze the material in order to try to quantify the cost savings we could potentially realize by centralizing the management of paper records storage, handling, file room operations, cataloging, and other records management services.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '2/10/2026:
No update to present.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-daycom-2026-01-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0000ixymq3f9h2a0' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0000ixymq3f9h2a0',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-28 12:00:00') AS INTEGER) * 1000,
  '1/28/2026:
Information emailed and received for updates within the task orders of the Contract Daycom from the CO.
Daycom (Records Management Services Superfund, and Library Services) – 68HERD23D0001; the original amount of Daycom contract was $203,052,645.00, with a period of performance of 11/01/2022 – 10/31/2027.
As of 1/28/2026, there are six task orders under Daycom:
68HE0523F0013 Region 5 GLNPO, period of performance 2/1/2023 - 12/31/2027, total amount $437,292.96, funding remaining $184,335.84.
68HE0523F0031 Region 5 Superfund, period of performance 3/20/2023 - 2/29/2028, total amount $2,784,814.11, funding remaining $1,246,318.32.
68HERD23F0112 Region 4 Superfund, period of performance 5/1/2023 - 4/30/2028, total amount $2,954,240.64, funding remaining $1,413,771.96.
68HE0823F0030 Region 8 Records Management, period of performance 5/15/2023 - 5/14/2028, total amount $4,525,040.52, funding remaining $2,028,368.21.
68HE0325F0103 Region 3 Records Management, period of performance 12/1/2025 - 11/30/2027, total amount $2,119,163.04, funding remaining $2,041,443.87.
68HE0726F0017 Region 10 Library Services, period of performance 12/1/2025 - 4/30/2028, total amount $397,011.30, funding remaining $384,478.75.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
