PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- IMCS-VI: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-65355f1c5465ef3091ebbb1b';

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
  'manual-imcs-vi-2026-07-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-07-02 12:00:00') AS INTEGER) * 1000,
  '7/2/2026: dates are very fluid, award date is firm.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026: will be able to update and adjust current rough milestone estimates when compliance is done and initial SOW is drafted.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-23 12:00:00') AS INTEGER) * 1000,
  '6/23/2026: emails sent to SME for records and SME for Libraries to submit requirements for new SOW, COR working on new SOW for new contracts. COR requested input be submitted by 7/15',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-16 12:00:00') AS INTEGER) * 1000,
  '6/16/2026: Compliance memo Submitted',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-14',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-14 12:00:00') AS INTEGER) * 1000,
  '6/14/2026: IGCE complete',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-13',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-13 12:00:00') AS INTEGER) * 1000,
  '6/13/2026: Kim Farmer was assigned as Lead COR for recompete',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-12',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-12 12:00:00') AS INTEGER) * 1000,
  '6/12/2026: Library SEMs agreed to continue with one contract for both',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-10 12:00:00') AS INTEGER) * 1000,
  '6/10/2026: Meeting held with Libraries POCs/SME''s to discuss keeping two parts together',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-10-fitara',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-10 12:01:00') AS INTEGER) * 1000,
  '6/10/2026: No FITARA needed this is a consulting contract',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-01-igce',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
  '6/1/2026: Working on IGCE to get compliance memo started.  There are 7 task orders that did not transfer to Brad Werwick''s office and we do not have access to them in EAS.  We are working to get the documentation for them in order to complete the IGCE.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-imcs-vi-2026-06-01-fitara',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-65355f1c5465ef3091ebbb1b' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-65355f1c5465ef3091ebbb1b',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:01:00') AS INTEGER) * 1000,
  '6/1/2026: FITARA is not required for this recompete, determined in previous recompete that this was not an IT program',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;