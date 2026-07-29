PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Managed Print Services (MPS): authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'ebusiness';

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
  'manual-mps-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '6/30/2026:
COR is still waiting on deliverables for Service Review and Recommendations Report (originally due on 6/9/2026 - sent several reminders).
COR''s second attempt in requesting acknowledgment email with step-by-step instructions correcting the invoice that billed wrong CLIN (original email was sent on 6/16/2026).
Vendor finally responded back to invoice billed to wrong CLIN, and has now asked for a meeting on 7/1/2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-06-26',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-26 12:00:00') AS INTEGER) * 1000,
  '6/26/2026:
Submitted PR MOD for incremental funding to cover from October 2026 until December 2026.
EO Compliance was submitted to cover incremental funding (for 10/26 - 12/26) and is still pending approval.
COR followed up with vendor to acknowledge they received the email on the part of back billing charged to the wrong CLIN (original email was to TLG on 6/16).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-06-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-16 12:00:00') AS INTEGER) * 1000,
  '6/16/2026:
COR sent email with step-by-step instructions on how to correct back billing invoice as only 3 months were billed to the wrong CLIN. It was billed to CLIN2001 and should have been billed to just CLIN1001.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-06-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-10 12:00:00') AS INTEGER) * 1000,
  '6/10/2026:
COR sent reminder and asked if deliverable Service Review Recommendations Report and Quarterly Report were completed.
6/11 - COR questioned a second time about 2 deliverables: Service Review Recommendations Report (originally due on 6/9/26) and TLG indicated they were reviewing feedback (COR did not have that much feedback).
6/24 - COR sent another reminder about deliverables and TLG finally acknowledged email and will submit by Monday, 6/29/2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-06-03',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-03 12:00:00') AS INTEGER) * 1000,
  '6/3/2026:
CO determined that the invoice for back billing on the part of Oct., Nov., Dec. 2025 was billed to the wrong CLIN. It should have been billed to CLIN1001 instead of CLIN2001.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-06-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-06-02 12:00:00') AS INTEGER) * 1000,
  '6/2/2026:
COR sent feedback to TLG''s deliverable "Service Review and Improvement Recommendation Report", with new deadline of 6/9/2026.
COR also requested the deliverable Quarterly Review Report, which is past due for Dec. 2025 - Jan. and Feb. 2026, and asked for this report by 6/15/2026.
Requested also the quarterly review report for Mar., Apr., and May 2026 that will be due on 7/2/2026.
COR approved invoice in IPP for April invoice (including back billing - Oct., Nov., Dec. 2025 and Jan., Feb., Mar. 2026).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-29',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-29 12:00:00') AS INTEGER) * 1000,
  '5/29/2026:
COR still reviewing and adding feedback to TLG''s deliverable "Service Review and Improvement Recommendation Report".
TLG to submit April''s invoice (including back billing for FY26) in IPP to approve.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-18 12:00:00') AS INTEGER) * 1000,
  '5/18/2026:
COR pulled back April''s invoice in STAR in order for TLG to replace invoice with new invoice including back billing.
TLG resubmitted invoice to reflect back billing. This was a $9,706.55 difference. New invoice is now $33,991.18 and original invoice was $24,284.63.
Service and Project Management section reviewed and approved invoice (to include back billing).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-16 12:00:00') AS INTEGER) * 1000,
  '5/16/2026:
TLG met with the COR, Program Office, and Acting Section Chief (IT Service Desk Section) to discuss 373 printers never billed.
TLG stated the error was caused by a column in spreadsheet that was mislabeled as "LTCP" and TLG thought the mislabel would charge EPA twice. The "LTCP" were filtered out and never charged.
TLG indicated there were 330 printers not reported since May 2025. 40 more printers are on registry but came up in May 2025.
Acting Section Chief let TLG know that FY26 can be back billed to customers, but FY25 cannot be back billed.
Agreed that TLG can back bill but only for FY26 and the estimated amounts range from $1,000 to $2,000 a month.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-12',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-12 12:00:00') AS INTEGER) * 1000,
  '5/12/2026:
TLG submitted deliverable - Service Review and Improvement Recommendation Report. COR will review and provide feedback.
TLG submitted April''s invoice without any back billing.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-08',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-08 12:00:00') AS INTEGER) * 1000,
  '5/8/2026:
COR did not receive update on 373 printers as TLG is still investigating and asked for extension until 5/12/2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-05-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-05-05 12:00:00') AS INTEGER) * 1000,
  '5/5/2026:
COR requested update on 373 printers still not reporting. TLG is supposedly meeting with Chris Costa to determine how to bill EPA. Requested update by 5/8/26.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-30 12:00:00') AS INTEGER) * 1000,
  '4/30/2026:
All printing devices are reporting in through LDCM and should see less and less manual requests for toner, and should be automated.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-28 12:00:00') AS INTEGER) * 1000,
  '4/28/2026:
Let TLG know that about 300 to 373 printers have not been included in our billing. Program searched in invoice and did not have any of these serial numbers. Program Office Jean Gabriel also indicated that this could have happened more than a year ago or even since they started.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-24 12:00:00') AS INTEGER) * 1000,
  '4/24/2026:
PR submitted for incremental funding of $60K to cover May through end of July 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
  '4/21/2026:
Still waiting for printer toner update and asked for tracking number twice. Gave wrong tracking number. Been since 4/14/2026 that was the original request for toner.
Completed CPARS for 2025 for The Lioce Group - MPS.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-16',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-16 12:00:00') AS INTEGER) * 1000,
  '4/16/2026:
Premier toner was received and still asking about other toner for 833 - Tix # INC1862071.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-14',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-14 12:00:00') AS INTEGER) * 1000,
  '4/14/2026:
Customers are not happy over these toners. Toners should arrive by tomorrow into the country.
Let TLG know about another toner that was running out in Region 3 and gave ticket #. Not premier. Tix # INC1862071.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-13',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-13 12:00:00') AS INTEGER) * 1000,
  '4/13/2026:
Still waiting on status of premier printer.
Asking when new printers will be connected to LDCM.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-10 12:00:00') AS INTEGER) * 1000,
  '4/10/2026:
Toner for 833 printer is on back order and will arrive in the country next week.
Toner at HQ (premier printer) still waiting on. TLG stated toner was shipped on 4/8/26, but still waiting.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-04-02',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-04-02 12:00:00') AS INTEGER) * 1000,
  '4/2/2026:
HQ: Premier printer toner was out and inoperable. Toner was overnighted (delivered supposedly on 4/3) but technician did not receive it until Monday, April 6, 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-31',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-31 12:00:00') AS INTEGER) * 1000,
  '3/31/2026:
Meeting scheduled between Contracting Officer, Contract Specialist, Brad Werwick, COR, and TLG (Prime Contractor) to discuss the problem of not meeting the contract requirements, and what the solution will be.
The problem is the subcontractor did not connect new printers (from new procurement) to LDCM to monitor toner, etc., and toners were not automatically ordered even though this was a contract requirement.
The underlying problem was an agreement between the prime contractor and subcontractor had to be signed because EPA added new printer models.
This was not an issue with EPA MPS Contract as the PWS clearly states printers could be up to 3,000 printers in fleet (even if all regions joined).
Region 1 had not received expedited printer toner yet.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-27 12:00:00') AS INTEGER) * 1000,
  '3/27/2026:
Region 1 had another new printer out of toner and COR contacted TLG (Prime Contractor) to expedite new toner.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-26',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-26 12:00:00') AS INTEGER) * 1000,
  '3/26/2026:
Region 1 had another toner out (new printer). This one was delivered later, nearly a week later on 4/3/2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-25',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-25 12:00:00') AS INTEGER) * 1000,
  '3/25/2026:
COR met with Brad Werwick, Contracting Officer, and Contract Specialist to discuss the issue of the prime not meeting contract requirements by not connecting new printers to the tool and not ordering toner automatically.
Region 1 did receive toner for the first printer out of ink (this took a week). Initial request was on 3/18/2026 and the region did not receive it until March 25, 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-24',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
  '3/24/2026:
Region 1''s printer became inoperable (no ink in toner).
COR finally got a response from subcontractor who stated it is the issue mentioned on last week''s call (about their MOD).
Region 1''s new printer was no longer working as there was no toner.
Subcontractor is trying to work out something with prime for additional funding to cover these new printers. Prime contractor has to sign a new agreement with subcontractor.
MPS technician told Program Office that he was ordered to stop ordering any supplies until a MOD is made with the prime contractor (not a MOD with EPA).
COR met with Contract Specialist (CO was out of office) regarding the prime not meeting requirements of connecting new printers to LDCM and getting toner ordered automatically.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-23 12:00:00') AS INTEGER) * 1000,
  '3/23/2026:
Program Office reached out to COR to escalate the problem of no response from Lexmark/subcontractor.
COR reached out to Prime Contractor TLG and subcontractor for toner not being provided. TLG (Prime) claimed they did not know that Lexmark would stop supplying toner to new printers (from previous procurement) and not connect new printers to LDCM. No response from subcontractor.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-20',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-20 12:00:00') AS INTEGER) * 1000,
  '3/20/2026:
Region 1 still did not have any response from subcontractor and reached out to Lexmark again.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-18',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-18 12:00:00') AS INTEGER) * 1000,
  '3/18/2026:
Region 1 contacted Lexmark regarding low toner for new printer.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-17',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-17 12:00:00') AS INTEGER) * 1000,
  '3/17/2026:
Approved invoice in IPP for February usage.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-12',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-12 12:00:00') AS INTEGER) * 1000,
  '3/12/2026:
Received February''s invoice and usage report.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-03-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-03-05 12:00:00') AS INTEGER) * 1000,
  '3/05/2026:
TLG presented the Quarterly Program Briefing to the Contracting Officer and Contract Specialist. CO and CS gave feedback and requested a few changes for the next report.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-02-27',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-02-27 12:00:00') AS INTEGER) * 1000,
  '2/27/2026:
TLG submitted updated Quarterly Program Briefing Report. COR scheduled meeting with CO for TLG to present this report.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-02-26',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-02-26 12:00:00') AS INTEGER) * 1000,
  '2/26/2026:
Requested Quarterly Briefing Report with changes.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-02-19',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-02-19 12:00:00') AS INTEGER) * 1000,
  '2/19/2026:
COR approved invoice in IPP for January 2026 usage.
COR submitted PR PR-OFA-26-00310 to deobligate funds of $189,332.81 for CLIN1001 (COR confirmed with vendor that all invoices have been paid for 2025).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-02-17',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-02-17 12:00:00') AS INTEGER) * 1000,
  '2/17/2026:
COR approved January usage invoice in STAR.
MOD P0010 incrementally funded contract for 1 month until the end of April 2026.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-02-12',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-02-12 12:00:00') AS INTEGER) * 1000,
  '2/12/2026:
COR submitted PR (PR-OFA-26-00297) to incrementally fund CLIN2001 (OY2) for 1 more month until the end of April 2026 in the amount of $20K.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-01-23',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-01-23 12:00:00') AS INTEGER) * 1000,
  '1/23/2026:
COR received the Quarterly Program Briefing to review and give potential feedback if needed.
COR will also schedule a meeting for the Program Manager to present to the CO and CS.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-01-21',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-01-21 12:00:00') AS INTEGER) * 1000,
  '1/21/2026:
COR submitted EO Compliance form to incrementally fund for an additional month (April 2026).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-01-14',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-01-14 12:00:00') AS INTEGER) * 1000,
  '1/14/2026:
COR and Alt COR met with new CO and new CS for introduction and to give an overview of MPS.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-mps-2026-01-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'ebusiness' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-adam-vanenwyck'),
  'ebusiness', NULL, NULL,
  CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
  '1/05/2026:
COR requested changes to the Quarterly Program Briefing and is waiting on the final version.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
