PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Ensure ESRI 06/30/2026 past update exists.
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
  'manual-esri-2026-06-30',
  COALESCE(
    (
      SELECT pa.userId
      FROM project_assignments pa
      WHERE pa.projectId = p.id
        AND pa.componentId IS NULL
      ORDER BY pa.assignedAt ASC
      LIMIT 1
    ),
    'import-garrett-hayes'
  ),
  p.id,
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30/2026: No update from GSA. Funding, CGER approved. Waiting for OCPO to confirm if ITOD should include IA fees in funding package. Waiting for OCPO to confirm other documentation necessary for IA package.',
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
FROM projects p
WHERE lower(p.name) = 'esri'
  AND NOT EXISTS (
    SELECT 1
    FROM submissions s
    WHERE s.projectId = p.id
      AND s.deletedAt IS NULL
      AND (
        s.id = 'manual-esri-2026-06-30'
        OR lower(s.rawText) LIKE '%06/30/2026: no update from gsa%'
      )
  )
LIMIT 1;

COMMIT;
PRAGMA foreign_keys = ON;
