PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Microsoft Consulting Services: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cms38s6so0006mjzkkgwdzwh8';

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
  'manual-microsoft-consulting-services-2026-07-14',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38s6so0006mjzkkgwdzwh8' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38s6so0006mjzkkgwdzwh8',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-07-14 12:00:00') AS INTEGER) * 1000,
  '07/14: PWS and IGCE complete. CGER submitted, FITARA ready to submit when CGER approval is received. APP in-progress and will be ready to submit when CGER and FITARA approval received. 6 months of AO support for Quill under ESSET approved. COR will work with ITS-EPA TPOC to begin process of getting support set up. New target award for Microsoft Consulting Services is 04/15/27.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-microsoft-consulting-services-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38s6so0006mjzkkgwdzwh8' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38s6so0006mjzkkgwdzwh8',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30: PWS and IGCE complete. CGER submitted, FITARA ready to submit when CGER approval is received. APP in-progress and will be ready to submit when CGER approval is received. Waiting to see if AO support for Quill can be provided under ESSET while BPA is being awarded. This will help determine milestones.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;