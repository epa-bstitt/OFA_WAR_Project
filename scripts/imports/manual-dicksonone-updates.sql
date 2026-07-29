PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- DicksonOne: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'import-contract-eae8e00c70a495083e0607af';

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
  'manual-dicksonone-2026-07-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-eae8e00c70a495083e0607af' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'cmpx2emsj0001788vfgr7eaal'),
  'import-contract-eae8e00c70a495083e0607af',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-07-02 12:00:00') AS INTEGER) * 1000,
  '07/02/2026:
Requirement Package Status
EOC/CGER was submitted for review on 11 June 2026. Still waiting for CIO approval.
FITARA was submitted on 30 June 2026. Still waiting for FITARA approval.
Both were escalated in an effort to send the package to the contracting office and meet the 26 June 2026 deadline.
The rest of the required documentation has been completed and uploaded into EAS:
Cybersecurity
Market Research
Sole Source Justification
PWS/SOW
IGE
The $0 PR and attached documentation was sent to the contracting office on 26 June.
The contracting office rejected the package on 2 July 2026 due to missing documentation (FITARA and EOC).
Once appropriated funding from ORI has been secured, a funded PR with all attachments, including FITARA and EOC, will need to be submitted.

QA/QAM Status
Maily Pham has added Sergey to the DicksonOne dashboard.
A meeting between Willie, Maily, and Sergey is recommended so Willie can better understand the roles, responsibilities, and scope of the previous QAMs.
Willie is aware of this recommendation and agrees.
It could not be scheduled before he went on PTO.

General
Recommendation to Sergey: contact the vendor to introduce yourself and get some history from them regarding this. If nothing else, build a rapport with them so that if or when you ask for a grace period, they provide it. Their email is at the top of this page.
Good luck. I tried to set you up as best as I could with what I had.
The Sole Source Justification is going to be difficult but appears possible.
Over 800 devices have been installed throughout EPA, and there is not another software product available that is compatible with these devices.
Check with DicksonOne to confirm there are no resellers; there were not in the past.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-dicksonone-2026-06-01',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-eae8e00c70a495083e0607af' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'cmpx2emsj0001788vfgr7eaal'),
  'import-contract-eae8e00c70a495083e0607af',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
  '06/01/2026:
I met with the previous contract owner, who said he was never delegated authority as a COR, on 1 June 2026 and toured RTP''s main building to better understand what the devices were and what they monitored.
They are small devices attached to refrigeration units that wirelessly broadcast to a few centralized router-like devices.
These devices are attached to the network and send the data to a dashboard for temperature and maintenance monitoring.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-dicksonone-2026-05-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'import-contract-eae8e00c70a495083e0607af' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'cmpx2emsj0001788vfgr7eaal'),
  'import-contract-eae8e00c70a495083e0607af',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-27 12:00:00') AS INTEGER) * 1000,
  '05/27/2026:
General
BLUF: I know very little about this contract other than it expires in August.
I am investigating what this contract completely entails.
The documentation I have seen does not appear to be current.
Prior year awards appear to be closed out, and it seems like they are only ordering replacement parts each year.
I have not seen a contract maintaining the equipment with a period of performance yet.
However, when I asked the current COR, the response was: "It''s just an order - you''re in the last option year so a clean slate going forward. No options to exercise. August 2026 will be the end of the PoP and we have the latest invoice for the following year ready for you."',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
