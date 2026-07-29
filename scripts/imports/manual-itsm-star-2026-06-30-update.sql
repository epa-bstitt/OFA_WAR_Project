PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- ITSM / STAR Support: add/update current-period (06/30/2026) entry.
DELETE FROM submissions
WHERE id = 'manual-itsm-star-2026-06-30';

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
VALUES (
  'manual-itsm-star-2026-06-30',
  COALESCE(
    (
      SELECT userId
      FROM project_assignments
      WHERE projectId = 'import-contract-3cca6c65f4f89588245aa152'
        AND componentId IS NULL
      ORDER BY assignedAt ASC
      LIMIT 1
    ),
    'import-garrett-hayes'
  ),
  'import-contract-3cca6c65f4f89588245aa152',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30: No Updates. Contract funded through 11/30.',
  NULL,
  NULL,
  NULL,
  'APPROVED',
  0,
  NULL,
  NULL,
  NULL,
  NULL,
  CAST(strftime('%s', 'now') AS INTEGER) * 1000,
  CAST(strftime('%s', 'now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
