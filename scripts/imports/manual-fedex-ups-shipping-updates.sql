PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- FedEx and UPS Shipping: authoritative current + past updates replacement for the active New Awards and Recompetes contract.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'cms38qp3c0002mjzkocyro4we';

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
  'manual-fedex-ups-shipping-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30/2026: Adam requested additional ordering information from BPA COR on 7/1/26.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fedex-ups-shipping-2026-06-01',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
  '06/01/2026: Updated CMS Forecast Dates.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fedex-ups-shipping-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '05/04/2026: Adam reviewed proposed changes to the SOW template. This review generated more process questions for the BPA COR. Adam to submit additional questions to BPA COR (Rob Fox) by end of week.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fedex-ups-shipping-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '04/21/2026: Adam met with Terri 3/17/2026 to address questions, discuss BPA Call Order requirement, and pay current shipping invoices via CC. Adam to submit questions to BPA COR (Rob Fox) by end of week.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fedex-ups-shipping-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '03/24/2026: Adam met with Terri 3/17/2026 to address questions, discuss BPA Call Order requirement, and pay current shipping invoices via CC. Adam to submit questions to BPA COR (Rob Fox) by end of week.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-fedex-ups-shipping-2026-03-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'cms38qp3c0002mjzkocyro4we' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'cms38qp3c0002mjzkocyro4we',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-02 12:00:00') AS INTEGER) * 1000,
  '03/02/2026: Adam met with Terri''s team 2/25/2026 to address questions, discuss BPA Call Order requirement. Terri''s team to review notes and confirm questions for BPA COR. Once questions are confirmed/formalized, Adam will send to BPA COR (Rob Fox).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;