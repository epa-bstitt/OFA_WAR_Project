PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Authoritative replacement for T-Mobile (EMDC) past WAR entries.

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-a809fd21f697d457ab18ec72';

DELETE FROM submissions
WHERE id IN (
  'manual-tmobile-emdc-2026-06-03',
  'manual-tmobile-emdc-2026-05-20',
  'manual-tmobile-emdc-2026-05-04',
  'manual-tmobile-emdc-2026-04-08',
  'manual-tmobile-emdc-2026-03-27'
);

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
  'manual-tmobile-emdc-2026-06-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-03 12:00:00') AS INTEGER) * 1000,
  '06/03/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised extending the legacy contract by six months through 12/31/2026 and awarding the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with CO guidance.
  - 05/20/2026 COR and CO determined previously committed funding would not be obligated by Sep 30.
  - FY26 funding was decommitted while keeping the PRs open; funding will be committed anew in October using FY27 dollars.
  - CO acknowledged she will proceed with the award of the call order without waiting for funding.',
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
),
(
  'manual-tmobile-emdc-2026-05-20',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-20 12:00:00') AS INTEGER) * 1000,
  '05/20/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised extending the legacy contract by six months through 12/31/2026 and awarding the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with CO guidance.
  - 05/20/2026 COR and CO determined previously committed funding would not be obligated by Sep 30.
  - FY26 funding was decommitted while keeping the PRs open; funding will be committed anew in October using FY27 dollars.
  - CO acknowledged she will proceed with the award of the call order without waiting for funding.',
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
),
(
  'manual-tmobile-emdc-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '05/04/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised extending the legacy contract by six months through 12/31/2026 and awarding the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with CO guidance.
  - 05/04/2026 pending feedback and further guidance from the CO.',
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
),
(
  'manual-tmobile-emdc-2026-04-08',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-08 12:00:00') AS INTEGER) * 1000,
  '04/08/2026:
- No operational updates; T-Mobile services are still provided under the legacy T-Mobile contract till 06/30/2026.
- First call order for T-Mobile under EMDC is being developed by the COR and will start on 07/01/2026.
- SOW and IGCE were developed by the COR and vetted by Scott Baker''s group.
- Funding for the call order was secured on 04/06/2026, and the EO Compliance Review will be submitted for approval this week.',
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
),
(
  'manual-tmobile-emdc-2026-03-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-27 12:00:00') AS INTEGER) * 1000,
  '03/27/2026:
- New CO was appointed to the contract: Pamela Kuykendall.
- No operational updates; T-Mobile services are still provided under the legacy T-Mobile contract till 06/30/2026.
- First call order for T-Mobile under EMDC is being developed by the COR and will start on 07/01/2026.',
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
);

COMMIT;
PRAGMA foreign_keys = ON;
