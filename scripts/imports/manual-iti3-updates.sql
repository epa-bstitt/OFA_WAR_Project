PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- ITI3: authoritative current + past updates replacement.
DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = 'iti-iii';

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
  'manual-iti3-2026-06-30',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-06-30 12:00:00') AS INTEGER) * 1000,
  '06/30/2026:
General
Primary COR responsibilities transferred from Andrew Rhoades to Michelle Cuilla and Kim Farmer pending MOD from NITAAC.

Funding
$5.57M to cover 6 months of OY4 (August 28, 2026-March 2, 2027) has been accepted by NITAAC.
The MOD will need to be done by August 28th.
Risk: If the MOD is not done by 27 Aug 2026 to exercise OY4 and fund the OY, ITI3 will expire 27 August 2026.

Patriot PM Key Personnel
Dipak Patnaik has taken on interim PM responsibilities and has been accepted as the PM.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-05-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-05-05 12:00:00') AS INTEGER) * 1000,
  '05/05/2026:
General
COR documentation provided to NITAAC personnel on April 28, 2026.
Craig Hammel communicated that transfer would be effective May 1, 2026, but no formal contract modification has taken place.
ORD Tiger Team was to be concluded as of April 30, 2026, which Valisha was advised of on April 29, 2026 during the GSS/ITI3 ITOD Weekly.

GSS/ITI3 Weekly Meetings
GSS/ITI3 ITOD Weekly scheduled for Wednesdays at 3:30 p.m.
Hosted by Willie Abney and co-led by Valisha Jackson.
Risk: ITOD personnel have been meeting with Patriot personnel regarding knowledge management efforts, but no known documentation or knowledge capture of the meetings are currently being centrally maintained by ITOD personnel.

GSS Customer Meetings
ITOD Customer Meeting was held on April 30, 2026.
Meeting was to be recorded, but Valisha has not yet viewed the meeting and/or next steps.

Scientific System Fusion Teams
Valisha was invited to the EPA Scientific Systems Fusion Team meetings on Mondays as of Monday, May 4, 2026, but was unable to attend.

Funding
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026.
Was advised on Wednesday, April 29, 2026 by J. Cunningham that these funds have been allocated for other efforts.
Advised Willie Abney, who said he would follow up with James regarding this.
OY3Q4 funding has been signed by EPA and NITAAC on May 5, 2026 for a June 1, 2026 start date.
MOD still needs to be done by the CO.

Option Year 4 Funding Actions
See email thread from Valisha on Monday, May 4, 2026.
$5.57M to cover August 28, 2026-March 2, 2027.
Risk: CGER form will need to be expedited through approval process.

General Risk
Valisha does not currently feel comfortable being named as COR to this vehicle with financial responsibilities (e.g., approving invoices) when there is no documented manner to validate time billed to the government for delivered services (e.g., tickets with work details, project plans, technical direction documents).
This risk remains, despite being required to submit COR nomination forms.

Patriot PM Key Personnel
Advised by Patriot on Monday, May 4, 2026 that Program Manager Jack Venturo left the company effective immediately.
Meeting with the VP of Service Delivery on Friday 5/8/2026 to address immediate program management needs and risk.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-04-22',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-04-22 12:00:00') AS INTEGER) * 1000,
  '04/22/2026:
General
Major actions pending from meeting with T. McNeil and W. Abney on Monday, April 20, 2026 include information on the 6-month period of performance for Option Year 4 and a breakdown of the PWS with options for realignment, descoping, and cost reduction.
Weekly transition meetings resume on Wednesday, April 22, 2026 at 10:30 a.m. with Craig Hammel.
Will be able to provide more information afterwards.

Funding
OY3Q4 funding is queued in G-Invoicing with all associated documents awaiting NIH action.
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026.
Need to check status of this action and the year of funding currently in use on the vehicle.

Risk
Valisha does not currently feel comfortable being named as COR to this vehicle with financial responsibilities (e.g., approving invoices) when there is no documented manner to validate time billed to the government for delivered services (e.g., tickets with work details, project plans, technical direction documents).',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-03-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-03-10 12:00:00') AS INTEGER) * 1000,
  '03/10/2026:
General
Briefing with T. McNeill, W. Lominack, V. Jackson, and M. Fays on March 2, 2026.
As of 03/02/2026, T. McNeill advised that ATO will be extended, but no information on extension date.
Advised Craig Hammel on March 4, 2026.
GSS infrastructure is expected to be assumed by IT Operations Division.
Within Brandi Surmmons'' branch; no specific FTE named.
Question for next transition meeting: has there been discussion about appropriated FTE moving to EOB to perform support? WCF employees cannot support work that is not in the fund.
T. McNeill requested a contractor-led overview presentation tentatively scheduled for April 15, 2026 at 9:00 a.m.
Valisha documented requirements for presentation to inform agenda.
Reviewed and discussed with M. Fays on March 5, 2026.
Reviewed by Craig Hammel on March 9, 2026.
Sent to contractor on 03/10/2026; draft due 03/24/2026.
Meeting will be in-person at EPA Headquarters.
Craig is working to facilitate an intro meeting between NITAAC CO Christopher Cunningham, Valisha, and Andrew Rhoades in the next couple of weeks.
Next standing weekly contract transition meeting scheduled for March 11, 2026 at 10:30 a.m.

Funding
OY3Q4 funding is queued in G-Invoicing with all associated documents but awaiting SRO signature.
Niki Maslin/Alva Daniels were emailed February 3, 2026 for SRO signature.
As of March 5, 2026 still awaiting action.
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026.
As of March 4, 2026, NITAAC is awaiting 7600B from Temberly James (current Project Officer) to decrease funding.
DW-075-95981901 is the IA.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-02-10',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-02-10 12:00:00') AS INTEGER) * 1000,
  '02/10/2026:
Transition meeting scheduled for 02/11/2026 at 10:30 a.m.

Ongoing Risk
Lack of ownership of the GSS system and/or any of the technical roles required for direction, oversight, and general program management are a major block in transition planning and execution.
No ISO creates risks related to NIST adherence, among other security concerns and added costs to the agency.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-01-28',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-28 12:00:00') AS INTEGER) * 1000,
  '01/28/2026:
Transition meeting focused on invoicing processes and documentation was held on 01/14/2026 at 10:30 a.m.
Meeting notes and action items were distributed to all invitees on 01/14/2026.
All agenda items were not covered; will work with Craig to address those matters via email and offline discussions.
Attendees: Craig Hammel, Valisha Jackson, Andrew Rhodes, Michael Fays, and Kristen Gaster.
Invited but did not attend: James Cunningham and Jon Richardson.
Weekly transition meetings are scheduled on Wednesdays from 10:30 to 11:30 a.m.
Kristen Gastner attended the 01/14/2026 meeting as there are former ORD personnel who fulfill required roles related to contract business needs and have been assigned to her section.
Meeting scheduled for 01/21/2026 will focus on the transition plan outline developed by Valisha and lapse-planning activities.
Valisha requested access to the vendor under Task 1 FFP to help facilitate knowledge management due to Craig''s limited bandwidth.

Risk
Lack of ownership of the GSS system and/or any of the technical roles required for direction, oversight, and general program management are a major block in transition planning and execution.
No ISO creates risks related to NIST adherence, among other security concerns and added costs to the agency.

Funding
An Executive Compliance Form has been routed by James Cunningham and Craig Hammel to fund the contract through the end of the Option Year, August 27, 2026.
Note: This action was suggested to transition to ITO; however, until there is a documented bona fide business need to support currently delivered activities, this is not something Valisha (on behalf of ITO) is comfortable doing.

Lapse Planning (Time Sensitive)
Craig Hammel is working with the vendor and James Cunningham to determine if this vehicle and activities will still be considered exempted and/or excepted, as well as Craig and Jon Richardson as excepted personnel.
In the most recent lapse, Craig reported that because the contract was funded, ORD decisionmakers permitted work to continue as planned.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
),
(
  'manual-iti3-2026-01-05',
  COALESCE((SELECT userId FROM project_assignments WHERE projectId = 'iti-iii' AND componentId IS NULL ORDER BY assignedAt ASC LIMIT 1), 'import-michelle-cuilla'),
  'iti-iii',
  NULL,
  NULL,
  CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
  '01/05/2026:
This contract vehicle is still in the early stages of transition and currently remains with current personnel Craig Hammel, formerly of ORD.
Valisha Jackson has been identified as the to-be COR and Andrew Rhodes will be the Alt-COR.
No specific transition-in date has been determined yet.
Risk: It remains unclear how separation of duties will be managed to delegate contract management functions and technical program direction based on current functions.
Risk: Current ATO expires June 2026; there is no IMO, SIO, or ISO currently identified to own this.
Valisha has been actively reviewing contract-related files and emails to develop a transition-in plan and timeline.
This effort was paused over the prior two weeks due to leave but resumed on Monday, January 5, 2026.
Invoice processing transition meeting is scheduled for January 14, 2026.

Contract period of performance was split into quarters for the current option year based on ORD management direction:
Q1: 8/28/2025-12/1/2025.
Q2: 12/2/2025-2/28/2026.
Q3: 3/1/2026-5/31/2026.
Q4: 6/1/2026-8/27/2026.
This was done via a formal contract modification.

Funding
Current funding at a contract level is through Q3, May 31, 2026.
Risk: Funding for this vehicle was single sourced out of ORD, with no cost recovery model.

Action Required
CBI Access Request CBI-0007431 https://oppt.lightning.force.com/lightning/r/CBI_Access_Request__c/a06SJ00000ktoHqYAI/view.
Required for CBI-related functions on the contract.
Submitted to Craig Hammel as DCO, and Will Lominack as first-line supervisor, because Michael Fays does not come up in the system.',
  NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL,
  CAST(strftime('%s','now') AS INTEGER) * 1000,
  CAST(strftime('%s','now') AS INTEGER) * 1000
);

COMMIT;
PRAGMA foreign_keys = ON;
