PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

-- Rebuild eBusiness past updates from source-of-truth notes provided by the user.
-- Targets the active eBusiness project record.

DELETE FROM submissions
WHERE deletedAt IS NULL
  AND projectId = (
    SELECT id
    FROM projects
    WHERE lower(name) = 'ebusiness'
    ORDER BY updatedAt DESC, createdAt DESC
    LIMIT 1
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
SELECT
  data.id,
  COALESCE(
    (
      SELECT pa.userId
      FROM project_assignments pa
      WHERE pa.projectId = target.id
        AND pa.componentId IS NULL
      ORDER BY pa.assignedAt ASC
      LIMIT 1
    ),
    'import-adam-vanenwyck'
  ),
  target.id,
  NULL,
  NULL,
  data.weekOf,
  data.rawText,
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
FROM (
  SELECT id
  FROM projects
  WHERE lower(name) = 'ebusiness'
  ORDER BY updatedAt DESC, createdAt DESC
  LIMIT 1
) AS target
JOIN (
  SELECT
    'manual-ebusiness-2026-06-29' AS id,
    CAST(strftime('%s', '2026-06-29 12:00:00') AS INTEGER) * 1000 AS weekOf,
    '06/29/2026:
- Funding:
  - PR-OFA-26-00925 was received by contracts on 6/26/2026. This PR full funds GS-35F-116AA/68HERD25F0001 Option Period 1, fixed price CLIN 1001, through November 09, 2026.
- Exercise Option Period 2:
  - COR notified CO of intent to exercise Option Period 2 on 6/1/2026.
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
  - eBusiness Enhancements
    - #20216 Enhanced Search - Search all collections
    - #20167 Exception Report for Account CPIC Specific IT Code vs Funding Profile
    - #20181 PR Module: Modify PR proportional buttons on IT Distribution Tab to prevent variances by tower
  - Snow API (Status)
  - EISDSUPT Orders/Deprovisions: This will be deployed in the 10.02 release.
  - Orders Payload for IPL Basic and IPL Core: Testing in DEV environment in process; SNOW put on hold 05/21.
  - 508 Compliance
  - Rico Grids currently being rewritten with Sencha EXTJS Infinite Grid
- Mobile Device Refresh:
  - As of early this afternoon, 19 people still need to sign their acknowledgement form.
  - Leidos has been assisting the MD Support team with device refresh questions.
  - 1,910 registrations have been updated with new device information to date.
- Workflow request for SRO and facilities approval of location moves:
  - Facilities officially requested this enhancement. COR directed eBusiness to proceed. Anticipated completion is end of Q1 FY27.
- Cross Charging Enhancement Proposal:
  - COR has directed eBusiness to proceed with this enhancement.' AS rawText

  UNION ALL SELECT
    'manual-ebusiness-2026-06-01',
    CAST(strftime('%s', '2026-06-01 12:00:00') AS INTEGER) * 1000,
    '06/01/2026:
- Exercise Option Period 2:
  - COR notified CO of intent to exercise Option Period 2 on 6/1/2026.
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only. Completed (Sat) May 30, 2026.
  - eBusiness Enhancements
    - #20216 Enhanced Search - Search all collections
    - #20167 Exception Report for Account CPIC Specific IT Code vs Funding Profile: COR to set up meeting with requestor to discuss requirements.
    - #20181 PR Module: Modify PR proportional buttons on IT Distribution Tab to prevent variances by tower: Meeting set up (6/10) with requestor.
  - Snow API (Status)
  - EISDSUPT Orders/Deprovisions: This will be deployed in the 10.02 release.
  - Orders Payload for IPL Basic and IPL Core: Testing in DEV environment in process; SNOW put on hold 05/21.
  - 508 Compliance
  - Rico Grids currently being rewritten with Sencha EXTJS Infinite Grid
- Mobile Device Refresh:
  - As of early this afternoon, 19 people still need to sign their acknowledgement form.
  - Leidos has been assisting the MD Support team with device refresh questions.
  - 1,910 registrations have been updated with new device information to date.
- Workflow request for SRO and facilities approval of location moves:
  - eBusiness provided LOE and estimate to Facilities; awaiting decision.
- Cross Charging Enhancement Proposal:
  - A meeting has been scheduled for June 4 to further discuss EPA proposal.
- Workflow change request from Deputy CIO to change remote location selection:
  - Willie reviewed proposed solution with Deputy CIO. eBusiness team waiting for further direction.'

  UNION ALL SELECT
    'manual-ebusiness-2026-05-04',
    CAST(strftime('%s', '2026-05-04 12:00:00') AS INTEGER) * 1000,
    '05/04/2026:
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only. Target release date (Sat) May 30, 2026; testing underway.
  - eBusiness Enhancements
    - #20216 Enhanced Search - Search all collections
    - #20167 Exception Report for Account CPIC Specific IT Code vs Funding Profile
    - #20181 PR Module: Modify PR proportional buttons on IT Distribution Tab to prevent variances by tower
  - Snow API (Status)
  - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions, deployed 2/24.
  - Future Enhancements: Orders Payload for IPL Basic and IPL Core (SN waiting for approval).
- Mobile Device Refresh:
  - As of 4/30/26, 28 people still need to sign acknowledgement form.
  - Leidos has been assisting the MD Support team with device refresh questions.
  - 1,379 registrations updated with new device information to date.
- Workflow request for SRO and facilities approval of location moves:
  - COR to review proposed cost with Section Manager.
- Cross Charging Enhancement Proposal:
  - Meeting scheduled for May 19 to further discuss EPA proposal.'

  UNION ALL SELECT
    'manual-ebusiness-2026-04-21',
    CAST(strftime('%s', '2026-04-21 12:00:00') AS INTEGER) * 1000,
    '04/21/2026:
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 10.0 Release planned for April 7, 2026. Includes eBusiness facelift and account manager transfer initiation.
    - eBusiness 10.0 includes ColdFusion 2021 Update 23 with roll-back of search package to 330334 to support eTMS #20036 and satisfy open POAM vulnerability.
  - eBusiness Enhancements
    - #20176 Make PRs editable for creator and first approver approved as written; broader approver editing not adopted.
    - #20165 Add field to account screen for CPIC specific IT code approved (one code, two characters).
    - #20166 Display account CPIC specific IT code on PR screen approved.
  - Snow API (Status)
  - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions, deployed 2/24.
  - Future Enhancements: Orders Payload for IPL Basic and IPL Core (SN waiting for approval).
- FY27 Forecasting workshops:
  - Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
- eBusiness Modernization/Facelift:
  - Leidos presented a brief demo to the CAG during the March meeting.
  - Release planned for April 7.
- eBusiness Budget Module:
  - Budget module training 4/6/2026.
  - Initialize FY2027 Budget Planning data and establish schedule completed 03/11/2026.
  - CCMgrInput step opened 03/16/2026.'

  UNION ALL SELECT
    'manual-ebusiness-2026-03-24',
    CAST(strftime('%s', '2026-03-24 12:00:00') AS INTEGER) * 1000,
    '03/24/2026:
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 10.0 Release plans to deploy on April 7, 2026; includes facelift and transfer initiation capability.
    - Leidos demonstrated facelift in March CAG; AppScan requested on March 23.
    - eBusiness 10.0 includes ColdFusion 2021 Update 23 with roll-back of search package to 330334 for eTMS #20036 and POAM support.
  - eBusiness Enhancements
    - #20176 Make PRs editable for creator and first approver approved as written.
    - #20165 Add field to account screen for CPIC specific IT code approved.
    - #20166 Display account CPIC specific IT code on PR screen approved.
  - Snow API (Status)
  - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions, deployed 2/24.
  - Future Enhancements: Orders Payload for IPL Basic and IPL Core (SN waiting for approval).
  - Adobe: Migrated AD groups from org-specific to agency-level groups completed March 19, 2026.
- FY27 Forecasting workshops:
  - Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
- eBusiness Modernization/Facelift:
  - Leidos demo to CAG completed.
  - Release planned for April 7.
- eBusiness Budget Module:
  - Initialize FY2027 Budget Planning data and establish schedule completed 03/11/2026.
  - CCMgrInput step opened 03/16/2026.'

  UNION ALL SELECT
    'manual-ebusiness-2026-03-02',
    CAST(strftime('%s', '2026-03-02 12:00:00') AS INTEGER) * 1000,
    '03/02/2026:
- Incoming Political Appointee Support:
  - Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.16.03 maintenance release deployed February 24, 2026 with database-only changes.
    - 9.17 is now 10.0.
    - 10.0 release plans to deploy on April 7, 2026; should include facelift and March CAG demo.
    - eBusiness 10.0 includes ColdFusion 2021 Update 23 with roll-back of search package to 330334 for eTMS #20036 and POAM support.
  - Snow API (Status)
  - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions, deployed 2/24.
  - Future Enhancements: Orders Payload for IPL Basic and IPL Core (SN waiting for approval).
- Enhance Continuous Evaluations (CE):
  - Deployed in 9.16.03 on February 24; March billing includes adjustments back through FY25.
- FY27 Forecasting workshops:
  - Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
- eBusiness Modernization/Facelift:
  - Menu, home page, catalog, and color theme targeted for 9.17 in March 2026.
  - Additional home page/forms/buttons updates.
  - Brief demo targeted for March CAG.
- CT Lite (Regions 5 and 8):
  - Pre-kickoff strategic planning meeting in March.
- eBusiness Budget Module:
  - Need to initialize FY2027 planning data after FY26 BE updates and revised rates finalization.'

  UNION ALL SELECT
    'manual-ebusiness-2026-02-17',
    CAST(strftime('%s', '2026-02-17 12:00:00') AS INTEGER) * 1000,
    '02/17/2026:
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.16.02 Maintenance Release scheduled 2/24/2026.
    - Budget allocation enhancements.
    - Adobe AD group levels moved to agency level rather than by organization.
  - Snow API (Status)
  - 9.15 Enhancements:
    - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions.
    - Future Enhancements: Orders Payload for IPL Basic and IPL Core (waiting for SN DEV).
- FY27 Forecasting workshops:
  - Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
- eBusiness Modernization/Facelift:
  - Menu, home page, catalog, and color theme targeted for 9.17 in March 2026.
  - Additional updates to home page, forms, and buttons.
  - Brief demo targeted for March CAG.
- CT Lite (Regions 5 and 8):
  - Target implementation in February.
  - Additional region outreach in progress.
- eBusiness Budget Module:
  - Initialize FY2027 planning mid-late February after FY26 BE updates and rate finalization.'

  UNION ALL SELECT
    'manual-ebusiness-2026-01-29',
    CAST(strftime('%s', '2026-01-29 12:00:00') AS INTEGER) * 1000,
    '01/29/2026:
- Mod P00008 awarded 01/28/2026.
  - Incrementally funds Option Period through May 1.
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.16.02 Maintenance Release scheduled 2/24/2026.
    - Budget allocation enhancements.
    - Adobe AD groups at agency level rather than by organization.
    - CE process enhancements.
  - Snow API (Status)
  - 9.15 Enhancements:
    - Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions.
    - Future Enhancements: Orders Payload for IPL Basic and IPL Core (waiting for SN DEV).
- eBusiness Modernization/Facelift:
  - Menu, home page, catalog, and color theme targeted for 9.17 in February/March.
  - Additional updates to home page, forms, and buttons.
  - Brief demo and color scheme review completed with COR approval.
- Enhance Continuous Evaluations (CE):
  - Coding completed for agreed rules; moved to QA for preliminary testing.
- Adobe ColdFusion Enterprise 2023:
  - Compatibility review underway. EPA purchased license. Cost model discussion continuing.
- FY2026 rate recalculation:
  - EAC and BE support updates continue in eBusiness.'

  UNION ALL SELECT
    'manual-ebusiness-2026-01-05',
    CAST(strftime('%s', '2026-01-05 12:00:00') AS INTEGER) * 1000,
    '01/05/2026:
- Mod P00006 awarded 12/12/2025.
  - Changes CO to Kaela Back.
- Funded through January 10, 2026.
  - Funding PR-OFA-26-00072 assigned to new CO on 12/22/2025.
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- Information Management activity:
  - Carla Diaz as IM Activity Manager; ongoing weekly meetings continue.
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.15 Release scheduled Tuesday 11/18.
  - Snow API (Status)
  - 9.15 Enhancements:
    - MP Location Moves
    - Include Special Instructions with CT Moves
    - Include decal/SN with MP orders when available
    - MD cancellations and rescinds
  - New enhancement: Orders payload for LF products IPLCORE and IPLBASIC (#20094) assigned.
- eBusiness Modernization/Facelift:
  - Demo to operations group and CAG tentatively scheduled for February 2026.
- Adobe ColdFusion Enterprise 2023:
  - EPA procured required license; Leidos no longer needs ODC purchase path.
- XACTA eBusiness CMA Year 1:
  - Complete with no vulnerabilities found.'

  UNION ALL SELECT
    'manual-ebusiness-2025-11-03',
    CAST(strftime('%s', '2025-11-03 12:00:00') AS INTEGER) * 1000,
    '11/03/2025:
- Funded through January 10, 2026.
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- Information Management activity:
  - Carla Diaz as IM Activity Manager; ongoing weekly meetings continue.
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.15 Release scheduled Tuesday 11/18.
  - Snow API (Status)
  - 9.15 Enhancements:
    - MP Location Moves
    - Include Special Instructions with CT Moves
    - Include decal/SN with MP orders when available
    - MD cancellations and rescinds
  - New enhancement: Orders payload for LF products IPLCORE and IPLBASIC (#20094) assigned.
- eBusiness Modernization/Facelift moving forward after progress demo feedback.
- Adobe ColdFusion Enterprise 2023:
  - EPA will procure required license; Leidos no longer purchasing via ODC.
- XACTA eBusiness CMA Year 1:
  - Revision work underway with weekly meetings; assessment schedule tracked.'

  UNION ALL SELECT
    'manual-ebusiness-2025-10-21',
    CAST(strftime('%s', '2025-10-21 12:00:00') AS INTEGER) * 1000,
    '10/21/2025:
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- Information Management activity:
  - Carla Diaz as IM Activity Manager; ongoing weekly meetings continue.
- eBusiness Application Enhancement:
  - eBusiness Releases
    - 9.15 Release scheduled Tuesday 11/18.
  - Snow API (Status)
  - 9.15 Enhancements:
    - MP Location Moves
    - Include Special Instructions with CT Moves
    - Include decal/SN with MP orders when available
    - MD cancellations and rescinds
    - Phone services (IPLCORE/IPLBASIC) requesting API-created RITMs
- eBusiness Modernization/Facelift moving forward after progress demo feedback.
- 508 Compliance:
  - Phase 1 completed in 9.14; additional enhancements planned including 9.15.
- ColdFusion Update 21 hotfix status reviewed.
- Adobe ColdFusion Enterprise 2023:
  - EPA to buy eBusiness license; Leidos not purchasing under ODCs.
- XACTA eBusiness CMA Year 1:
  - Assessment timeline and due dates confirmed.'

  UNION ALL SELECT
    'manual-ebusiness-2025-10-06',
    CAST(strftime('%s', '2025-10-06 12:00:00') AS INTEGER) * 1000,
    '10/06/2025:
- Incoming Political Appointee Support:
  - Leidos providing continuous support (High Priority).
- DRP (Groups 2 and 3)/VERA Personnel:
  - Leidos received updated DRP 3.0 list and cancelled DA and MW registrations for personnel with admin leave dates September 30 or prior.
- Information Management activity:
  - Carla Diaz as IM Activity Manager; ongoing weekly meetings continue.
- eBusiness Application Enhancement:
  - Leidos continuing to work; follow-up meeting scheduled for 10/8.
- MS products available in eBusiness Phase 2:
  - No new update.
- Snow API:
  - CT/MP Orders, Cancellations, Moves all in production.
  - MP location moves testing with release 9.15.
  - MD cancellations testing with release 9.15.
  - MD rescinded cancellations testing with release 9.15.'
) AS data;

COMMIT;
PRAGMA foreign_keys = ON;
