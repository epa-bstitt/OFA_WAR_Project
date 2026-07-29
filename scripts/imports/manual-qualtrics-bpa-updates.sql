PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Qualtrics (via Carahsoft) BPA: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-5f48f8cdadd6d7029a70c638';

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
  'manual-qualtrics-2026-06-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-29 12:00:00') AS INTEGER) * 1000,
  '06/29/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OCEFT has expressed an interest in purchasing 5 licenses in Aug 2026. COR followed up 6/24/2026. Waiting on a response.
OASIS has expressed interest in 1 license. COR plans to combine these two requirements into one BPA Call Order.',
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
),
(
  'manual-qualtrics-2026-06-01',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
  '06/01/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OCEFT has expressed an interest in purchasing 5 licenses in Aug 2026. COR is working with them in developing and submitting their EAS PR.
OASIS has expressed interest in 1 license. COR plans to combine these two requirements into one BPA Call Order.',
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
),
(
  'manual-qualtrics-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '05/04/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR (officially) that they are not renewing their current licenses (expires April 24th).
OCEFT has expressed an interest in purchasing 5 licenses in Aug 2026. COR is working with them in developing and submitting their EAS PR.',
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
),
(
  'manual-qualtrics-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '04/21/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license. However, the BPA order minimum is 5. The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.',
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
),
(
  'manual-qualtrics-2026-04-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-07 12:00:00') AS INTEGER) * 1000,
  '04/07/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license. However, the BPA order minimum is 5. The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.',
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
),
(
  'manual-qualtrics-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '03/24/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license. However, the BPA order minimum is 5. The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.',
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
),
(
  'manual-qualtrics-2026-03-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-02 12:00:00') AS INTEGER) * 1000,
  '03/02/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
COR assisting OW and OCEFT BPA Call Order to be awarded mid April.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.',
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
),
(
  'manual-qualtrics-2026-02-17',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-17 12:00:00') AS INTEGER) * 1000,
  '02/17/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OIG & OCHCO renewals awarded 2/11/2026.
OA is looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.',
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
),
(
  'manual-qualtrics-2026-01-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-29 12:00:00') AS INTEGER) * 1000,
  '01/29/2026:
No funding required on BPA.
BPA Actions:
Option Period 2 exercised. Current period expires 2/22/2027.
BPA Call Orders:
PR-OFA-26-00068 - OIG renewal by 2/1/2026.
PR-OFA-26-00106 - OCHCO renewal by 2/1/2026.
COR met with Nancy Broom 9/10/2025. Remaining need confirmed. Nancy will coordinate with users to determine Brand Admin and license count. She will submit to COR by mid-December.
Followed up with Nancy 1/5/2026.
Nancy is still attempting to consolidate former ORD users.
OA is looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order).
COR provided OA with information and is awaiting requirements.',
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
),
(
  'manual-qualtrics-2026-01-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
  '01/05/2026:
No funding required on BPA.
BPA Actions:
Option Period 2 exercised. Current period expires 2/22/2027.
BPA Call Orders:
PR-OFA-26-00068 - OIG renewal by 2/1/2026.
PR-OFA-26-00106 - OCHCO renewal by 2/1/2026.
COR met with Nancy Broom 9/10/2025. Remaining need confirmed. Nancy will coordinate with users to determine Brand Admin and license count. She will submit to COR by mid-December.
Followed up with Nancy 1/5/2026.',
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
),
(
  'manual-qualtrics-2025-11-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
  '11/03/2025:
No funding required on BPA.
BPA Actions:
Exercise Option Period 2 by 2/22/2026. PR-OMS-26-00018 has been accepted by ITAD. The vendor has been notified of the Government''s intent to exercise Option Period 2.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025. Remaining need confirmed. Nancy will coordinate with users to determine Brand Admin and license count. She will submit to COR by mid-December.
OIG has also inquired about renewing their Qualtrics products.
OIG has submitted their requirement.',
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
),
(
  'manual-qualtrics-2025-10-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
  '10/21/2025:
BPA Actions:
Exercise Option Period 2 by 2/22/2026. PR-OMS-26-00018 has been accepted by ITAD. The vendor has been notified of the Government''s intent to exercise Option Period 2.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025. Remaining need confirmed. Nancy will coordinate with users to determine Brand Admin and license count. She will submit to COR by mid-December.
OIG has also inquired about renewing their Qualtrics products.
OIG has submitted their requirement.',
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
),
(
  'manual-qualtrics-2025-10-06',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-5f48f8cdadd6d7029a70c638' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'import-contract-5f48f8cdadd6d7029a70c638',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-06 12:00:00') AS INTEGER) * 1000,
  '10/06/2025:
BPA Actions:
Exercise Option Period 2 by 2/22/2026.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025. Remaining need confirmed. Nancy will coordinate with users to determine Brand Admin and license count. She will submit to COR by mid-December.
OIG has also inquired about renewing their Qualtrics products.
COR is working with OIG to define their requirement.',
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
