PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- MPS Recompete: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cms38sn4q0008mjzk22ieap1q';

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
  'manual-mps-recompete-2026-07-15',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-07-15 12:00:00') AS INTEGER) * 1000,
  '7/15: RECOMPETE New Contract: FITARA and SRO Approval still pending. COR following up to see if they have questions or any updates. IGCE Completed. $0.00 PR submitted on 6/24/2026: PR-OFA-26-00815. APP was submitted on 6/24/2026 (w/PR). EO Compliance approved. Market Research Completed.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30: RECOMPETE New Contract: FITARA and SRO Approval still pending. IGCE Completed. $0.00 PR submitted on 6/24/2026: PR-OFA-26-00815. APP was submitted on 6/24/2026 (w/PR). EO Compliance approved. Market Research Completed. Waiting to see if AO support for Quill can be provided under ESSET while BPA is being awarded. This will help determine milestones.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-06-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-24 12:00:00') AS INTEGER) * 1000,
  '6/24: $0.00 PR and APP was submitted together and FCO approved. Still waiting on FITARA and SRO approval.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-06-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-18 12:00:00') AS INTEGER) * 1000,
  '6/18: EO Compliance was approved on 6/12/2026. Request for SRO Approval was submitted on 6/16/2026. Request for FITARA approval was submitted on 6/17/2026. COR is currently working on APP. COR revised PWS to add task of monitoring non lexmark printers per Program''s Office request.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-06-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-02 12:00:00') AS INTEGER) * 1000,
  '6/02: 6/1: Both IT Service Branch Section and Endpoint Services Branch have concluded that the task of Print Queue Management will be added to new MPS Contract Recompete. Sent draft MPS PWS out that reflects this added PWs and waiting on everyone approval by 6/3/2026. EO Compliance was submitted for approval. COR is currently working on drafting the FITARA.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-05-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-29 12:00:00') AS INTEGER) * 1000,
  '5/29: COR revised added additional data to reflect the back billing charges for FY26 printers that was never billed. COR finalized IGCE. COR is now drafting EO Compliance form to submit by June 1, 2026. Both Endpoint Services Branch and IT Service Branch are currently determining which contract will complete task of Print Queue Management (mtg scheduled for 6/1/2026).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-05-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-27 12:00:00') AS INTEGER) * 1000,
  '5/27: COR scheduled meeting to meet with ESSET Engineering to discuss the current section of MPS PWS included a section called "EPA Service Desk Priority Levels". COR requested ESSET Engineer to update this section and to send a more recent copy of the "MPS Incident Ticket Handling Process" document by Tuesday, June 2, 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-05-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-21 12:00:00') AS INTEGER) * 1000,
  '5/21: COR scheduled a meeting to meet with the Endpoint Services Branch and IT Service Branch to resolve which Contract (MPS or ESSET) will be assigned the task of Print Queue Management. Some discussion was skill set and cost. That is could cost more for ESSET to complete task. Program Office found the task was success having ESSET complete the task. Conclusion to meeting indicated more discussions were needed as it was still not determined which contract will be completing this task. COR asked for a resolution soon so recompete milestones are not delayed. Separate discussion was made between Branch Chiefs. COR scheduled a meeting for Monday, June 1, 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-30 12:00:00') AS INTEGER) * 1000,
  '4/30: COR is pulling data from previous FY and analyzing data, while creating a draft IGCE. COR requested from Service Management team data on non Lexmark printers for FY24, FY25, and FY26.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-04-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-23 12:00:00') AS INTEGER) * 1000,
  '4/23: COR is working on market research. COR is researching GSA for Managed Print Service vendors. COR will reach out to vendors if not enough information is listed.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-04-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-18 12:00:00') AS INTEGER) * 1000,
  '4/18: COR Submitted PWS to the Program office to get their review and edits.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-recompete-2026-03-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38sn4q0008mjzk22ieap1q' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38sn4q0008mjzk22ieap1q',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-27 12:00:00') AS INTEGER) * 1000,
  '03/27: COR made minor edits to PWS. COR is reviewing older notes and meeting with ESSET COR to discuss moving printers.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;