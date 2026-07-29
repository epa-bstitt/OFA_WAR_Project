PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- FY26 Microsoft ELA: authoritative timeline replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-614f28f4029854f21450b5c7';

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
  'manual-msela-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
6/28 two call orders done, working on 2 more for new licenses being purchased by customers.
6/24 meeting held to discuss ebusiness submissions for new licenses, second meeting held with MS only to determine what licenses are eligible for ebusiness 6/30.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-06-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-16 12:00:00') AS INTEGER) * 1000,
  '6/16/2026:
Second call order awarded 6/3.
Still waiting on compliance memo from Region 10.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-05-15',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-15 12:00:00') AS INTEGER) * 1000,
  '5/15/2026:
Awarded 5/15.
First call order awarded 5/16.
Second call order PR in process 5/18.
New software buy for Region 10 in process 5/18.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-30 12:00:00') AS INTEGER) * 1000,
  '4/30/2026:
TEP was required, final report signed and accepted by CO 4/29.
CO anticipates sending award recommendation to OGE by 5/1.
CO anticipates award no later than 5/15.
Microsoft stated all current licenses will remain usable for up to 30 days.
No cost is anticipated for extension of current licenses while waiting for award.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-04-22',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-22 12:00:00') AS INTEGER) * 1000,
  '04/22/2026:
All final proposals are due tomorrow. (No TEP is needed).
Request for Proposal (RFP) will need to go to OGC and Advocates Office to approve within 5 days.
Award anticipated by 4/30/2026. If 4/30/2026 deadline does not get met, then EPA can pay compensation to extend deadline.
OFA has 9 offices, and each one is to submit a separate PR to approve funding. COR has only received one PR. COR is waiting on 8 OFA offices to submit their funded PR as it will not be fully awarded until then.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-03-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-30 12:00:00') AS INTEGER) * 1000,
  '03/30/2026:
COR contacted all Microsoft customers to submit their orders no later than 4/10/2026.
COR waiting for final award to be awarded by April 30, 2026.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-03-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-27 12:00:00') AS INTEGER) * 1000,
  '03/27/2026:
Brand Name Justification approved by the Office of General Counsel.
Limited Source Justification was approved by the Office of General Counsel (brand name approved).',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-02-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-27 12:00:00') AS INTEGER) * 1000,
  '2/27/2026:
The Office of General Counsel (OGC) rejected Microsoft name approval. Currently elevated to Tiffany by Will for assistance.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-02-13',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-13 12:00:00') AS INTEGER) * 1000,
  '2/13/2026:
CO submitted updated LSJ to OGC for review and approval.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-02-12',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-12 12:00:00') AS INTEGER) * 1000,
  '2/12/2026:
Additional language supporting LSJ submitted to CO.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '2/10/2026:
CO received comments from OGCE concerning Limited Source Justification (LSJ) for named source.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-01-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-28 12:00:00') AS INTEGER) * 1000,
  '1/28/2026:
The PR is currently with CO, who is reviewing the APP (submitted in Sept. 2025) and Statement of Work (SOW). The CO is new and asking the COR questions to become more familiar with the contract.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-01-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-21 12:00:00') AS INTEGER) * 1000,
  '1/21/2026:
Approved compliance memo received.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2026-01-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
  '1/5/2026:
Due to EAS routing issues, COR resubmitted (PR-OFA-26-00141) and routed to Contracting Team. The PR is for a recompete, with an anticipated award by March 2026.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2025-12-15',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-12-15 12:00:00') AS INTEGER) * 1000,
  '12/15/2025:
COR submitted PR (PR-OFA-26-00141) but was delayed due to routing issues.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-msela-2025-11-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-614f28f4029854f21450b5c7' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-kim-farmer'),
  'import-contract-614f28f4029854f21450b5c7',
  NULL,
  NULL,
  CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
  '11/3/2025:
Meeting with ITAD to map the recompete.',
  NULL, NULL, NULL,
  'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
