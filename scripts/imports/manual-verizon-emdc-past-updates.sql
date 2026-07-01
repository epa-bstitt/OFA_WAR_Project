PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Authoritative replacement for Verizon (via EMDC) (call order) past WAR entries.

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-1175226adce593ff68fdde37';

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
  'manual-verizon-emdc-2026-06-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-24 12:00:00') AS INTEGER) * 1000,
  '06/24/2026:
- No operational updates.
- Current EMDC call order was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
- PR-OFA-26-00907: PR with additional incremental funding of $141,578.75 was submitted to the FCO for commitment on 06/24/2026.
- This funding covers performance in October-December 2026.
- Follow-up Call Order (to be awarded by 12/31/2026):
  - 04/06/2026 funding approved.
  - 04/10/2026 PR with funding submitted to CFAIAD (aligned with February HQAD guidance).
  - 04/20/2026 CFAIAD advised extending current call order to 12/31/2026 and awarding new call order from 01/01/2027.
  - 04/23/2026 COR updated LSJ per CO guidance.
  - 05/20/2026 previously committed funding not expected to obligate by Sep 30.
  - FY26 funding decommitted while PRs remained open; to be committed anew in October with FY27 dollars.
  - CO acknowledged proceeding with award without waiting for funding.',
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
  'manual-verizon-emdc-2026-06-09',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-09 12:00:00') AS INTEGER) * 1000,
  '06/09/2026:
- No operational updates.
- Current EMDC call order was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
- Follow-up Call Order (to be awarded by 12/31/2026):
  - 04/06/2026 funding approved.
  - 04/10/2026 PR with funding submitted to CFAIAD.
  - 04/20/2026 CFAIAD advised six-month extension and new call order from 01/01/2027.
  - 04/23/2026 COR updated LSJ per CO guidance.
  - 05/20/2026 previously committed funding would not be obligated by Sep 30.
  - FY26 funding decommitted while PRs remained open; funding to be committed in October with FY27 dollars.
  - CO acknowledged proceeding with award without waiting for funding.',
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
  'manual-verizon-emdc-2026-06-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-03 12:00:00') AS INTEGER) * 1000,
  '06/03/2026:
- No operational updates.
- Current EMDC call order is to be extended for additional six months of performance (07/01/2026 - 12/31/2026).
- CO sent draft contract mod with extension to vendor for signature on 06/01/2026.
- Follow-up Call Order (to be awarded by 12/31/2026):
  - 04/06 funding approved; 04/10 PR submitted; 04/20 CFAIAD extension/new-award guidance; 04/23 LSJ updated.
  - 05/20 funding decommitted with PRs open and to be recommitted in October as FY27 dollars.
  - CO acknowledged proceeding with award without waiting for funding.',
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
  'manual-verizon-emdc-2026-05-20',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-20 12:00:00') AS INTEGER) * 1000,
  '05/20/2026:
- No operational updates.
- Current EMDC call order scheduled to end 06/30/2026; COR is developing continuation on two tracks.
- Six-month extension track:
  - At CO recommendation, current call order to be extended through 12/31/2026.
  - Funded PR for extension submitted to CO on 05/13/2026.
- Follow-up Call Order (to be awarded by 12/31/2026):
  - 04/06 funding approved; 04/10 PR submitted; 04/20 CFAIAD extension/new-award guidance; 04/23 LSJ updated; 05/20 funding decommit/recommit plan confirmed.
  - CO acknowledged proceeding with award without waiting for funding.',
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
  'manual-verizon-emdc-2026-05-04',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
  '05/04/2026:
- No operational updates.
- Current EMDC call order scheduled to end 06/30/2026; COR developing continuation on two tracks.
- Six-month extension track:
  - CO recommended extension through 12/31/2026.
  - COR secured CGER approval for extension funding.
  - PR in EAS to be submitted once ITSB Director confirms funding availability.
- Follow-up Call Order track:
  - 04/06 funding approved; 04/10 PR submitted; 04/20 CFAIAD guidance; 04/23 LSJ updated; 05/04 pending further CO guidance.',
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
  'manual-verizon-emdc-2026-04-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-23 12:00:00') AS INTEGER) * 1000,
  '04/23/2026:
- No operational updates.
- PR for follow-up call order submitted to CFAIAD.
- 04/06 funding approved; 04/10 PR submitted; 04/20 CFAIAD advised extension through 12/31/2026 and new call order from 01/01/2027.
- 04/23 COR requested approval for extension funding.',
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
  'manual-verizon-emdc-2026-04-08',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-08 12:00:00') AS INTEGER) * 1000,
  '04/08/2026:
- No operational updates.
- Follow-up call order for July 2026 and beyond is being developed by COR.
- SOW and IGCE were developed by COR and vetted by Scott Baker''s group.
- Funding secured on 04/06/2026; EO Compliance Review to be submitted this week.',
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
  'manual-verizon-emdc-2026-03-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-27 12:00:00') AS INTEGER) * 1000,
  '03/27/2026:
- New CO was appointed: Pamela Kuykendall.
- No operational updates.
- Follow-up call order for July 2026 and beyond is being developed by COR.
- Legacy contract with Verizon Wireless ended on 01/31/2026.',
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
  'manual-verizon-emdc-2026-02-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-27 12:00:00') AS INTEGER) * 1000,
  '02/27/2026:
- No operational updates.
- Follow-up call order for July 2026 and beyond is being developed by COR.
- Legacy contract with Verizon ended on 01/31/2026.',
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
  'manual-verizon-emdc-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '02/10/2026:
- EMDC call order for Verizon Wireless services was awarded on 01/29/2026; performance began 02/01/2026.
- Period of performance: February-June 2026.
- Call order currently funded through March.
- Additional funding for April-June was approved on 01/20/2026; COR preparing funding PR.
- Follow-up call order for July 2026 and beyond is being developed by COR.
- Legacy contract with Verizon Wireless ended on 01/31/2026.',
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
  'manual-verizon-emdc-2026-01-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-29 12:00:00') AS INTEGER) * 1000,
  '01/29/2026:
- Legacy contract with Verizon is expected to end on 01/31/2026.
- The EMDC BPA with Verizon was signed on 01/15/2026, and the call order for five months of performance (Feb-Jun 2026) is expected to be enacted on 01/29/2026.
- Verizon submitted proposal on 01/26 and revised it after discussions on 01/28.
- COR reviewed proposal and submitted evaluation to Contract Specialist on 01/28.
- Call order expected to be awarded on 01/29.
- As of 02/01/2026, Verizon''s mobile services are expected to transfer to EMDC.',
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
  'manual-verizon-emdc-2025-12-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-12-29 12:00:00') AS INTEGER) * 1000,
  '12/29/2025:
- Contract was extended through 01/31/2026.
- EMDC BPAs with AT&T, Verizon Wireless, and T-Mobile expected by 12/31/2025; first call orders expected by 01/31/2026.
- First call orders with AT&T and Verizon expected through 06/30/2026 to align with T-Mobile legacy end date; full mobile operations expected under EMDC by 07/01/2026.',
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
  'manual-verizon-emdc-2025-11-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-18 12:00:00') AS INTEGER) * 1000,
  '11/18/2025:
- Contract was extended through 12/31/2025.
- No additional updates at this time.
- If EMDC is awarded by 12/31/2025, this contract ends in December; otherwise HQAD may require additional extension.
- COR asked HQAD about contingency plans for EMDC delays; HQAD said it was too soon to discuss.',
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
  'manual-verizon-emdc-2025-11-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
  '11/03/2025:
- Contract was extended through 12/31/2025.
- Legacy contract was extended for up to five months (2-month base + three 1-month options), expiring 12/31/2025.
- Extensions and funding through 12/31/2025 were fully processed and applied.
- HQAD remains committed to revised EMDC award by 12/31/2025.
- Revised FITARA approved by CIO on 10/22/2025.
- RFQ for EMDC procurement issued on 10/30/2025.
- HQAD working to secure three BPAs with AT&T, T-Mobile, and Verizon Wireless.',
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
  'manual-verizon-emdc-2025-10-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
  '10/21/2025:
- Contract was extended through 10/31/2025.
- Legacy contract now scheduled to expire on 12/31/2025.
- Extension through 10/30/2025 fully executed.
- Extension for 11/01/2025-11/30/2025 funded and PR submitted to ITAD.
- Extension for 12/01/2025-12/31/2025 funded separately and PR submitted to ITAD.
- HQAD committed to revised EMDC award by 12/31/2025.
- On 10/16/2025 HQAD acknowledged paperwork readiness to begin procurement; solicitation planned by end of October.
- Revised FITARA pending CIO approval.',
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
  'manual-verizon-emdc-2025-10-07',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-1175226adce593ff68fdde37' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-dawn-lamb'),
  'import-contract-1175226adce593ff68fdde37',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-10-07 12:00:00') AS INTEGER) * 1000,
  '10/07/2025:
- Contract was extended through 10/31/2025.
- Legacy contract now scheduled to expire on 12/31/2025.
- Extension through 10/30/2025 fully executed.
- Extension for 11/01/2025-11/30/2025 in process; WCF accountants approved funding.
- HQAD committed to revised EMDC award by 12/31/2025.
- OITO delivered draft SOW and IGCE to HQAD''s Scott Tharp on 08/11/2025.
- HQAD issued RFI and received responses on 08/25/2025.
- OITO analyzed responses and submitted analysis to HQAD on 09/03/2025.
- On 09/09/2025, HQAD and OITO agreed to pivot EMDC procurement to carrier-specific contracts to minimize agency spending.
- OITO delivered revised draft SOW to HQAD on 09/17/2025; HQAD reviewing.
- COR working with HQAD on additional PWS revisions and revised FITARA approval.',
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


