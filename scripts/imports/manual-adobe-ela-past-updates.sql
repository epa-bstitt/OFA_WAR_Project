PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Normalize Adobe ELA contract header fields from source-of-truth notes.
UPDATE projects
SET description = json_set(
  description,
  '$.activeContract.contractName', 'Adobe ELA',
  '$.activeContract.contractNumber', 'NNG15SD38B',
  '$.activeContract.orderNumber', '68HERD26F0002',
  '$.activeContract.nextPeriodOfPerf', '11/26/2026',
  '$.activeContract.ultimateCompletionDate', '11/26/2026',
  '$.activeContract.cor', 'Garrett Hayes/Alt: Michelle Cuilla',
  '$.activeContract.co', 'Kaela Back',
  '$.activeContract.cs', 'Sarah Langlois'
)
WHERE id = 'import-contract-832e8c8ddb89f3f257fe9c8e';

-- Ensure 6/30/2026 past update exists.
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
SELECT
  'manual-adobe-ela-2026-06-30',
  COALESCE(
    (SELECT userId FROM project_assignments WHERE projectId = 'import-contract-832e8c8ddb89f3f257fe9c8e' ORDER BY assignedAt ASC LIMIT 1),
    'import-garrett-hayes'
  ),
  'import-contract-832e8c8ddb89f3f257fe9c8e',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
Alt. COR working on PR
- Mod. 003: De-obligation of majority of T&M (CLIN 0002) funding
First true-up for additional licenses in-progress
Alt. COR working to update EPA (Adobe web page)',
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
WHERE NOT EXISTS (
  SELECT 1
  FROM submissions
  WHERE projectId = 'import-contract-832e8c8ddb89f3f257fe9c8e'
    AND deletedAt IS NULL
    AND (lower(rawText) LIKE '%6/30/2026%' OR lower(rawText) LIKE '%06/30/2026%')
);

-- Ensure 1/13/2026 past update exists.
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
SELECT
  'manual-adobe-ela-2026-01-13',
  COALESCE(
    (SELECT userId FROM project_assignments WHERE projectId = 'import-contract-832e8c8ddb89f3f257fe9c8e' ORDER BY assignedAt ASC LIMIT 1),
    'import-garrett-hayes'
  ),
  'import-contract-832e8c8ddb89f3f257fe9c8e',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-13 12:00:00') AS INTEGER) * 1000,
  '1/13/2026: No changes/updates',
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
WHERE NOT EXISTS (
  SELECT 1
  FROM submissions
  WHERE projectId = 'import-contract-832e8c8ddb89f3f257fe9c8e'
    AND deletedAt IS NULL
    AND lower(rawText) LIKE '%1/13/2026%'
);

COMMIT;
PRAGMA foreign_keys = ON;
