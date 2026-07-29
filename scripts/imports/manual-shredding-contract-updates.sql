PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Shredding Contract: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cms38rfa80004mjzk3195pt3f';

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
  'manual-shredding-contract-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38rfa80004mjzk3195pt3f' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38rfa80004mjzk3195pt3f',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/26: Adam sent Azsjenny instructions for shredding bin delivery on 6/24.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-shredding-contract-2026-06-22',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38rfa80004mjzk3195pt3f' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38rfa80004mjzk3195pt3f',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-22 12:00:00') AS INTEGER) * 1000,
  '6/22/26: on Hold.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-shredding-contract-2026-06-01',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38rfa80004mjzk3195pt3f' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38rfa80004mjzk3195pt3f',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
  '6/01/26: No new update.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-shredding-contract-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38rfa80004mjzk3195pt3f' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38rfa80004mjzk3195pt3f',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '5/04/26: No contract or purchase order anticipated at this time. RTP Facilities has a shredding event planned for NCC in July. COR confirmed with Facilities that the shredding event planned for the NCC will apply to confidential business information.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-shredding-contract-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38rfa80004mjzk3195pt3f' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38rfa80004mjzk3195pt3f',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '4/21/26: RTP Facilities has a shredding event planned for NCC in July. COR reached out to confirm event can accommodate confidential documents. Awaiting confirmation.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;