PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- 1) Move the existing ESSET 06/02 update from 2025 to 2026.
UPDATE submissions
SET
  weekOf = CAST(strftime('%s', '2026-06-03 21:00:00') AS INTEGER) * 1000,
  createdAt = CAST(strftime('%s', '2026-06-02 00:00:00') AS INTEGER) * 1000,
  updatedAt = CAST(strftime('%s','now') AS INTEGER) * 1000
WHERE id = 'cmqqytcht002cstjkoc3q9gy0'
  AND projectId = 'import-contract-057dbdf775d573de25e7b743';

-- 2) Add the new 06/30/2026 ESSET update (idempotent).
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
  'manual-esset-2026-06-30',
  COALESCE(
    (
      SELECT pa.userId
      FROM project_assignments pa
      WHERE pa.projectId = 'import-contract-057dbdf775d573de25e7b743'
        AND pa.componentId IS NULL
      ORDER BY pa.assignedAt ASC
      LIMIT 1
    ),
    'import-michelle-cuilla'
  ),
  'import-contract-057dbdf775d573de25e7b743',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 21:00:00') AS INTEGER) * 1000,
  'Update 06/30/2026:
OIG Support:
Nothing new to report.
Invoice:
May Invoice has been submitted for payment.
DOL SCA Aduit Invoices (3) have been reviewed by EPA and GSA.
We will be using OY1, OY2 and OY3 rate adjustment to off set some of the invoices. Waiting for GovCIO us final numbers for adjustments.
Funding:
Funding run out 30 Sep.
MODS:
MOD 52 will be for incremental funding.
On-boarding:
1 contractor added to ESSET
3 Removed',
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
  FROM submissions s
  WHERE s.projectId = 'import-contract-057dbdf775d573de25e7b743'
    AND s.deletedAt IS NULL
    AND (
      s.id = 'manual-esset-2026-06-30'
      OR lower(s.rawText) LIKE '%update 06/30/2026:%'
    )
);

COMMIT;
PRAGMA foreign_keys = ON;
