PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- IMCS V- Abaco Blackfish: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cmrjd4a5t0000ixym7ae1v59z';

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
  'manual-imcs-v-abaco-blackfish-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
Monthly report received; no problems detected.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-04-15',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-15 12:00:00') AS INTEGER) * 1000,
  '4/15/2026:
Received the Award of Modification P00008 to Task Order 68HERD23F0103 (Web Support for the Office of the Chief Financial Office) under Contract 68HERD23D0002, which exercises Option Period 3 (OP 3), provides funding in the amount of $107,223.60, fully funding CLIN 3001, and extends the period of performance until 04/30/2027.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '3/24/2026:
80% funding notification was sent on 3/6.

Financial Summary
D0002 Financial Summary: Total Ceiling $4,515,094.59, amount obligated $3,902,816.83, amount originally invoiced $3,653,311.37, amount paid $3,653,311.37. Remaining approved amount $260,978.94, % of funds used 94%, ODC funds obligated $47,067.29, funds remaining $13,973.48.
No significant difficulties encountered during this reporting period.

F0052 Financial Summary: Total Ceiling $117,054.46, amount obligated $105,056.64, amount invoiced $105,056.64, amount paid $105,056.64, % of funds used 100%, ODC funds obligated $11,997.82, ODC fund invoiced $10,882.99, ODC funds remaining $1,114.83, remaining approved amount $1,114.83.
Difficulties Encountered:
On February 2, access to the EPA Network server was down for most of the day, making it impossible to search the EPA Library Catalog. Eventually it was restored. This has happened 2 other times, both for a shorter duration during this reporting period.
On February 24, access to EPA Duluth''s American Chemical Society journals (Analytical Chemistry, Chemical Research in Toxicology, and Journal of Agricultural and Food Chemistry) was temporarily blocked but was restored within hours after the Librarian sent an email to ACS''s Sales Department and a phone call to ACS''s technical support.

F0103 Financial Summary: Total Ceiling $105,174.48, amount obligated $105,174.48, amount invoiced $87,645.40, amount paid $87,645.40, % of funds used 83%, remaining approved amount $17,529.08.
Difficulties Encountered:
No significant difficulties encountered during this reporting period.

Anticipated Activity:
OCFO was recently reorganized into a new office (OFA), and the Information Specialist will continue to assist in merging web content for this process. The Information Specialist is involved with a project to move policy content into an agency-wide policy catalog.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-02-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-27 12:00:00') AS INTEGER) * 1000,
  '2/27/2026:
OCFO, OY2 is funded through 4/30/25. We are still waiting on a modification to exercise/fund OY3. Abaco will be sending the 85% funding notification by 3/6.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-02-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-24 12:00:00') AS INTEGER) * 1000,
  '2/24/2026:
This is for the IMCS V Contract concerning record keeping and storage.
From Ryan Philbrick, this is a follow-up email to the conversation from the previous day about potential cost savings at the agency. As part of an ongoing effort to quantify and document agency-wide cost savings associated with centralizing paper records management activities at the National Digitization Centers (NDCs), we are requesting assistance in obtaining some acquisition documents for the ICMS contract.
Specifically, we are requesting copies of the Performance Work Statements and Independent Government Cost Estimates for all active and recently completed task orders under the ICMS vehicle. We want to analyze the material in order to try to quantify the cost savings we could potentially realize by centralizing the management of paper records storage, handling, file room operations, cataloging, and other records management services.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '2/10/2026:
No updates to present.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-01-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-28 12:00:00') AS INTEGER) * 1000,
  '1/28/2026:
Information emailed and received for updates within the task orders of the Contract Abaco from the CO.
Abaco Blackfish (Library Services, Records and Web Support) – 68HERD23D0002, the original amount of Abaco contract was $4,515,094.59, with pop of 11/01/2022 – 10/31/2027.
Two (2) task orders under Abaco Blackfish, which are as follows:
68HERD23F0052, pop 3/1/2025 – 2/28/2026, total amount is $117,054.46, funding remaining - $18,679.31.
68HERD23F0103, pop 5/1/2025 – 4/30/2026, total amount is $105,174.48, funding remaining - $35,058.16.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-03-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-09 12:00:00') AS INTEGER) * 1000,
  '3/9/2026:
Financial Summary.
No significant difficulties encountered during this reporting period.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-04-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
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
  'manual-imcs-v-abaco-blackfish-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
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
  'manual-imcs-v-abaco-blackfish-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-30 12:00:00') AS INTEGER) * 1000,
  '4/30/2026:
We met with the CO on the IMCS V contract to discuss some procedural issues and the upcoming re-compete. I will be sending out info on the re-compete early next year. I was asked by the CO to gently remind the TCORs of the following:
All PRs for option exercise should be submitted 90 days prior to end of current PoP.
Once a task order expires, the option cannot be exercised.
Lack of an option exercise does not result in a stop work; it results in a task order ending.
A stop work cannot be used in lieu of an option exercise.
If the option is not exercised by end of current PoP, the task order must be re-competed, and no work will be done until a new task order is awarded.
TOCORs are responsible for tracking their funding and submitting PRs prior to funding deficit. Incremental funding should be submitted 45 days prior to required obligation.
All PRs should be routed to COR for review before submitting to CO.
Approved Compliance memos are required to be submitted as attachments to all EAS actions.
I intend to set up a monthly "Office Hours" meeting in Teams soon, to allow for any issues, concerns or questions you may have. You do not need to wait for Teams office hours if you have an immediate question, feel free to call, Teams chat or email me any time. Thank you so much for your ongoing support.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-v-abaco-blackfish-2026-05-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
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
  'manual-imcs-v-abaco-blackfish-2026-06-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cmrjd4a5t0000ixym7ae1v59z' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-shela-poke-williams'),
  'cmrjd4a5t0000ixym7ae1v59z',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-10 12:00:00') AS INTEGER) * 1000,
  '6/10/2026:
No updates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
