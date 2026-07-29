PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- IMCS V- Agile Decision Sciences: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cmrjd4cam0001ixymo32muhv4';

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
  'manual-imcs-v-agile-decision-sciences-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
Monthly report received, no problems detected.
Agile monthly technical report 3/28 - 4/24, no task orders - 68HERD23D0003.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-agile-decision-sciences-2026-05-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
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
  'manual-imcs-v-agile-decision-sciences-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
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
  'manual-imcs-v-agile-decision-sciences-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '4/21/2026:
No updates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-agile-decision-sciences-2026-04-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-09 12:00:00') AS INTEGER) * 1000,
  '4/09/2026:
No updates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-agile-decision-sciences-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '3/24/2026:
No updates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-agile-decision-sciences-2026-03-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-09 12:00:00') AS INTEGER) * 1000,
  '3/9/2026:
Task Order Contract Value $687,978.70.
Task Order Funding Value $210,000.00.
% of Funding Spent 35.71%.
Funding Required to Complete EAC $477,978.70.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-agile-decision-sciences-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
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
  'manual-imcs-v-agile-decision-sciences-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
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
  'manual-imcs-v-agile-decision-sciences-2026-01-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4cam0001ixymo32muhv4' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4cam0001ixymo32muhv4',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-28 12:00:00') AS INTEGER) * 1000,
  '1/28/2026:
Information emailed and received for updates within the task orders of the Contract Agile from the CO.
Agile Decision Sciences supports (Library and Records Management) - 68HERD23D0003; the original amount of the contract is $160,086,284, with a period of performance of 11/1/2022 - 10/31/2027.
As of 1/28/2026, there are twenty-two task orders under Agile, listed below:
68HERD23F0041, period of performance 2/1/2023 - 1/31/2026, total amount $2,298,050.00, funding remaining $925,326.00.
68HERD23F0043, period of performance 2/1/2023 - 1/31/2026, total amount $291,583.00, funding remaining $82,231.00.
68HERD23F0044, period of performance 4/1/2023 - 3/31/2026, total amount $13,066,044.00, funding remaining $163,719.00.
68HERD23F0060, period of performance 3/1/2023 - 2/28/2026, total amount $3,316,107.00, funding remaining $1,351,210.00.
68HERD23F0072, period of performance 4/1/2023 - 3/31/2026, total amount $413,296.00, funding remaining $167,536.00.
68HERD23F0073, period of performance 4/1/2023 - 3/31/2026, total amount $201,492.00, funding remaining $8,903.00.
68HERD23F0086, period of performance 5/1/2025 - 4/30/2026, total amount $291,607.00, funding remaining $44,135.00.
68HERD23F0087, period of performance 4/1/2023 - 3/31/2026, total amount $1,897,218.00, funding remaining $793,699.00.
68HERD23F0090, period of performance 4/1/2023 - 3/31/2025, total amount $1,273,655.00, funding remaining $776,942.00.
68HERD23F0091, period of performance 4/1/2023 - 4/30/2026, total amount $603,135.00, funding remaining $244,503.00.
68HERD23F0100, period of performance 5/1/2023 - 4/30/2026, total amount $598,925.00, funding remaining $267,569.00.
68HERD23F0101, period of performance 5/1/2023 - 4/30/2026, total amount $4,208,928.00, funding remaining $1,687,237.00.
68HERD23F0102, period of performance 5/1/2023 - 4/30/2026, total amount $1,519,356.00, funding remaining $837,846.00.
68HERD23F0107, period of performance 5/1/2023 - 4/30/2026, total amount $1,238,192.00, funding remaining $565,528.00.
68HERD23F0111, period of performance 5/1/2023 - 4/30/2026, total amount $1,146,698.00, funding remaining $476,660.00.
68HERD23F0113, period of performance 5/1/2023 - 4/30/2026, total amount $3,166,074.00, funding remaining $1,330,144.00.
68HERD23F0117, period of performance 5/1/2023 - 4/30/2026, total amount $656,547.00, funding remaining $309,929.00.
68HERD23F0123, period of performance 6/1/2023 - 5/31/2025, total amount $609,589.00, funding remaining $370,480.00.
68HERD24F0012, period of performance 12/4/2023 - 1/3/2026, total amount $947,661.00, funding remaining $573,681.00.
68HERD25F0083, period of performance 6/25/2025 - 6/24/2026, total amount $6,770,712.00, funding remaining $6,325,207.00.
68HERD26F0008, period of performance 4/30/2026 - 4/30/2028, total amount $6,046,514.00, funding remaining $5,976,514.00.
68HERF26F0001, period of performance 1/1/2026 - 4/30/2026, total amount $2,351,787.20, funding remaining $2,256,787.20.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
