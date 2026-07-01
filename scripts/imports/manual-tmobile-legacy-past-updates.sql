PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Authoritative replacement for T-Mobile--Legacy past WAR entries.

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-a809fd21f697d457ab18ec72';

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
  'manual-tmobile-legacy-2026-06-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-24 12:00:00') AS INTEGER) * 1000,
  '06/24/2026:
- Legacy contract was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
- PR-OFA-26-00904: PR with additional incremental funding of $465,000.00 was submitted to the FCO for commitment on 06/24/2026.
- This funding covers the performance in October-December 2026.
- Follow-up EMDC Call Order (to be awarded by 12/31/2026):
  - 04/06/2026 funding approved.
  - 04/10/2026 PR with funding submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised extending the current call order to 12/31/2026 and awarding the new call order from 01/01/2027.
  - 04/23/2026 COR updated the LSJ in accordance with the CO guidance.
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
  'manual-tmobile-legacy-2026-06-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-10 12:00:00') AS INTEGER) * 1000,
  '06/10/2026:
- Legacy contract was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
- Follow-up EMDC Call Order (to be awarded by 12/31/2026):
  - 04/06/2026 funding approved.
  - 04/10/2026 PR with funding submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised extending the current call order to 12/31/2026 and awarding the new call order from 01/01/2027.
  - 04/23/2026 COR updated the LSJ in accordance with the CO guidance.
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
  'manual-tmobile-legacy-2026-06-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-03 12:00:00') AS INTEGER) * 1000,
  '06/03/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding for the follow-up call order approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised that they will want to extend the legacy contract by six months (through 12/31/2026) and award the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with the CO guidance.
  - 05/20/2026 COR and CO determined that previously committed funding would not be obligated by Sep 30.
  - FY26 funding was decommitted while keeping the PRs open; funding will be committed anew in October using FY27 dollars.
  - CO acknowledged that she will proceed with the award of the call order without waiting for funding.',
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
  'manual-tmobile-legacy-2026-05-20',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-20 12:00:00') AS INTEGER) * 1000,
  '05/20/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding for the follow-up call order approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised that they will want to extend the legacy contract by six months (through 12/31/2026) and award the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with the CO guidance.
  - 05/20/2026 COR and CO determined that previously committed funding would not be obligated by Sep 30.
  - FY26 funding was decommitted while keeping the PRs open; funding will be committed anew in October using FY27 dollars.
  - CO acknowledged that she will proceed with the award of the call order without waiting for funding.',
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
  'manual-tmobile-legacy-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '05/04/2026:
- No operational updates.
- PR for the EMDC call order was submitted to CFAIAD:
  - 04/06/2026 funding for the follow-up call order approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised that they will want to extend the legacy contract by six months (through 12/31/2026) and award the new call order from 01/01/2027. See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.
  - 04/23/2026 COR updated the LSJ in accordance with the CO guidance.
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
  'manual-tmobile-legacy-2026-04-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-23 12:00:00') AS INTEGER) * 1000,
  '04/23/2026:
- No operational updates.
- PR for the EMDC call order ( = follow-up to this contract) was submitted to CFAIAD:
  - 04/06/2026 funding for the follow-up call order approved.
  - 04/13/2026 PR submitted (aligned with February guidance from HQAD).
  - 04/20/2026 CFAIAD advised that they will want to extend the legacy contract by six months (through 12/31/2026) and award the new call order from 01/01/2027.
  - 04/23/2026 COR requested approval for funding for the extension.',
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
  'manual-tmobile-legacy-2026-04-08',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-08 12:00:00') AS INTEGER) * 1000,
  '04/08/2026:
- No operational updates.
- Additional incremental funding of $225,000 was approved on 04/06/2026, and the PR will be submitted to the CO for processing shortly.
- The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.',
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
  'manual-tmobile-legacy-2026-03-31',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-31 12:00:00') AS INTEGER) * 1000,
  '03/31/2026:
- No operational updates.
- Additional incremental funding of $225,000 is required to fully fund the contract through the end of its PoP on 06/30/2026.
- The funding request was submitted to Garrett for managerial review.
- The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.',
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
  'manual-tmobile-legacy-2026-02-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-27 12:00:00') AS INTEGER) * 1000,
  '02/27/2026:
- The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
- Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026.
- The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026, and the COR started work on the procurement package.
- Incremental funding of $350,000 for the T-Mobile legacy contract was approved and submitted to the CO on 02/26/2026. The funding will be sufficient to cover the contract''s operating expenses through April 2026.',
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
  'manual-tmobile-legacy-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '02/10/2026:
- The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
- Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026.
- The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026.
- T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.
- Additional incremental funding of $350,000.00 was approved by the ITSB Director on 01/20/2026, and the COR is preparing the funding documentation.',
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
  'manual-tmobile-legacy-2026-01-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-29 12:00:00') AS INTEGER) * 1000,
  '01/29/2026:
- The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
- Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026.
- The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026.
- T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.
- Additional incremental funding of $350,000.00 was approved by the ITSB Director on 01/20/2026, and the COR is preparing the funding documentation.',
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
  'manual-tmobile-legacy-2025-12-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-12-29 12:00:00') AS INTEGER) * 1000,
  '12/29/2025:
- HQAD (Scott Tharpe) and ITOD decided to "run out" this contract until its expiration date on 06/30/2026.
- The EMDC BPAs with all three carriers (AT&T, Verizon Wireless, and T-Mobile) are expected to be signed by 12/31/2025, with the first call orders expected to be awarded by 01/31/2026.
- HQAD/Scott Tharpe and ITOD held a discussion on 12/16/2025, and Scott recommended to continue using the legacy T-Mobile contract until its end date of 06/30/2026.
- The first call orders with AT&T and Verizon will be awarded for five months, i.e. through 06/30/2026 as well, so as to align them to the end date of the T-Mobile legacy contract.
- By 07/01/2026, the second set of call orders will be established with all three carriers, and all mobile operations will switch to be performed fully under EMDC.
- T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.',
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
  'manual-tmobile-legacy-2025-11-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-18 12:00:00') AS INTEGER) * 1000,
  '11/18/2025:
- T-Priority services (= alternative to AT&T''s FirstNet) was added to the contract via a contract modification, and the service is now orderable.
- After the award of the EMDC contract, HQAD is planning to terminate this contract early (before its scheduled expiration date of 06/30/2026).',
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
  'manual-tmobile-legacy-2025-11-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
  '11/03/2025:
- Incremental funding of $275,000 was added to the contract. It will cover the contract expenses through December 2025.
- PR to add the T-Priority services to the scope of the contract and incrementally fund their performance in the amount of $25,000 was submitted to ITAD on 10/31/2025.',
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
  'manual-tmobile-legacy-2025-10-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
  '10/21/2025:
- Incremental funding of $275,000 was approved by all required parties, and the PR was submitted to the FCO for funds commitment on 10/20/2025. Once obligated, the funding will fund the contract through the end of December 2025.
- COR is developing the necessary paperwork to modify the contract''s scope and add the T-Priority requirement that was requested by Scott Baker.',
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
  'manual-tmobile-legacy-2025-10-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-a809fd21f697d457ab18ec72' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-jake-beja'),
  'import-contract-a809fd21f697d457ab18ec72',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-07 12:00:00') AS INTEGER) * 1000,
  '10/07/2025:
- Scott Baker approved the vendor''s technical proposal to add T-Priority to the current contract. The COR will work with the Contracts Office to modify the contract.',
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
