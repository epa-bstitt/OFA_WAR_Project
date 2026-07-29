PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- FY27 Adobe ELA: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cms38q2gx0000mjzk6w9yqvzx';

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
  'manual-fy27-adobe-ela-2026-07-14',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38q2gx0000mjzk6w9yqvzx' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38q2gx0000mjzk6w9yqvzx',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-07-14 12:00:00') AS INTEGER) * 1000,
  '7/14/2026: FITARA Approved. IGCE Completed. Zero dollar PR submitted: PR-OFA-26-00304. EO Compliance Form Approved. Market Research Completed. SRO Approval - Approved 6/2. APP was sent on 6/16. COR Submitting 1900-65b to transition recompete',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fy27-adobe-ela-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38q2gx0000mjzk6w9yqvzx' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38q2gx0000mjzk6w9yqvzx',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026: FITARA Approved. IGCE Completed. Zero dollar PR submitted: PR-OFA-26-00304. EO Compliance Form Approved. Market Research Completed. SRO Approval - Approved 6/2. APP was sent on 6/16.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fy27-adobe-ela-2026-06-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38q2gx0000mjzk6w9yqvzx' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38q2gx0000mjzk6w9yqvzx',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-02 12:00:00') AS INTEGER) * 1000,
  '6/2/2026: FITARA Approved. IGCE Completed. Zero dollar PR created: PR-OFA-26-00304. EO Compliance Form Approved. Market Research Completed. SRO Approval - Approved 6/2. APP was sent on 6/16.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fy27-adobe-ela-2026-05-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38q2gx0000mjzk6w9yqvzx' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38q2gx0000mjzk6w9yqvzx',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-19 12:00:00') AS INTEGER) * 1000,
  '5/19/2026: FITARA Approved. IGCE Completed. Zero dollar PR completed. EO Compliance Form Approved. Market Research Completed. SRO being reviewed by Garrett 5/19. Meeting with Contracts 5/13.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;