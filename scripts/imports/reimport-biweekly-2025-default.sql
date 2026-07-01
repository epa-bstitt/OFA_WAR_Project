PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;
DELETE FROM workflow_states;
DELETE FROM reviews;
DELETE FROM submissions;
DELETE FROM project_assignments;
DELETE FROM project_components;
DELETE FROM contracts;
DELETE FROM notifications;
DELETE FROM audit_logs;
DELETE FROM conversation_states;
DELETE FROM import_job_file_results;
DELETE FROM import_jobs;
DELETE FROM projects;
DELETE FROM prompt_templates;
DELETE FROM users;
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('cmpx2emsj0001788vfgr7eaal', 'sergey.minchenkov@import.local', 'Sergey Minchenkov', 'import-sergey-minchenkov-import-local', 'CONTRIBUTOR', 1, 1780430594276, 1780430594276, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('demo-admin', 'admin@demo.epa.gov', 'Demo Administrator', 'demo-admin', 'ADMINISTRATOR', 1, 1782236911089, 1782243016644, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('demo-aggregator', 'aggregator@demo.epa.gov', 'Demo Aggregator', 'demo-aggregator', 'AGGREGATOR', 1, 1782323914868, 1782323914868, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('demo-contributor', 'contributor@demo.epa.gov', 'Contributor', 'demo-contributor', 'CONTRIBUTOR', 1, 1778012502839, 1782853737662, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('demo-overseer', 'overseer@demo.epa.gov', 'Demo Program Overseer', 'local-demo-overseer', 'PROGRAM_OVERSEER', 1, 1778092676945, 1778096529942, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-adam-vanenwyck', 'adam-vanenwyck@import.local', 'Adam VanEnwyck', 'import-adam', 'CONTRIBUTOR', 1, 1782236988833, 1782243019721, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-dawn-lamb', 'dawn-lamb@import.local', 'Dawn Lamb', 'import-dawn-lamb', 'CONTRIBUTOR', 1, 1782238547632, 1782323915121, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-garrett-hayes', 'garrett-hayes@import.local', 'Garrett Hayes', 'import-garrett', 'CONTRIBUTOR', 1, 1782236988987, 1782243020221, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-jake-beja', 'jake-beja@import.local', 'Jake Beja', 'import-jake', 'CONTRIBUTOR', 1, 1782236989045, 1782243019233, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-kim-farmer', 'kim-farmer@import.local', 'Kim Farmer', 'import-kim', 'CONTRIBUTOR', 1, 1782238552331, 1782243020276, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-michelle-cuilla', 'michelle-cuilla@import.local', 'Michelle Cuilla', 'import-michelle-cuilla', 'CONTRIBUTOR', 1, 1782238547490, 1782323915155, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('import-shela-poke-williams', 'shela-poke-williams@import.local', 'Shela Poke-Williams', 'import-shela', 'CONTRIBUTOR', 1, 1782238549721, 1782243020021, 1, NULL, NULL);
INSERT INTO users (id, email, name, azureAdId, role, isActive, createdAt, updatedAt, teamsNotificationsEnabled, teamsConversationId, teamsConversationReference) VALUES ('jamila-barnes', 'jamila-barnes@demo.epa.gov', 'jamila-barnes', 'jamila-barnes', 'CONTRIBUTOR', 1, 1778012502932, 1780339756512, 1, NULL, NULL);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('ebusiness', 'Managed Print Services (MPS)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Managed Print Services (MPS)","cor":"Dawn Lamb","contractNumber":"68HERD24F0028","office":"ITAD","nextPeriodOfPerf":"1/1/2026","ultimateCompletionDate":"12/31/2026","co":"TBD","cs":"TBD","orderNumber":"TBD","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1551434678-e076c223a692?auto=format&fit=crop&w=1200&q=80","imageAlt":"People collaborating in front of analytics and digital workflow screens.","currentUpdatePlaceholder":"Add this week''s eBusiness contract update here.","importSourcePath":"Contract Management Section.docx#details#MPS"}', 'ACTIVE', NULL, 1778012502833, 1782323915118);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('hesc-ii', 'ITS-EPA IV HESC II (High-End Scientific Computing)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ITS-EPA IV HESC II (High-End Scientific Computing)","cor":"Dawn Lamb","contractNumber":"47QFCA22F0020","office":"FEDSIM","nextPeriodOfPerf":"4/4/2026","ultimateCompletionDate":"4/3/2029","co":"Brendan Miller (GSA)","cs":"Brendan Miller (GSA)","orderNumber":"","palt":"","paltProcurementType":"Simplified Acquisitions Procedures","paltDollarValue":"Micropurchase","paltBeginOitoEngagement":"2026-06-02","paltOitoEngagement":"2026-08-31","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s HESC II contract update here.","importSourcePath":"Contract Management Section.docx#details#HESC II"}', 'ACTIVE', NULL, 1778012502939, 1782323915053);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('iti-iii', 'ITI3', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ITI3","cor":"Michelle Cuilla","contractNumber":"HHSN316201200065W","office":"NIH/NITAAC","nextPeriodOfPerf":"8/28/2026","ultimateCompletionDate":"3/2/2027","co":"Christopher Cunningham, NIH","cs":"N/A","orderNumber":"75N98122F00001","palt":"","paltProcurementType":"Simplified Acquisitions Procedures","paltDollarValue":"Above Micro & Under SAT","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=1200&q=80","imageAlt":"Modern operations room with screens and workspace used for IT transition planning.","currentUpdatePlaceholder":"Add this week''s ITI III contract update here.","importSourcePath":"Contract Management Section.docx#details#ITI III"}', 'ACTIVE', NULL, 1778012502994, 1782323915151);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('cmoudozbe000090udqjfuddj7', 'EIS', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"EIS","cor":"Sergey Minchenkov/ALT. COR:  Kim Farmer","contractNumber":"GS00Q17NSD3000, Task Order 68HERD22F0007","office":"","nextPeriodOfPerf":"10/17/2026","ultimateCompletionDate":"10/17/2032","co":"Kaela Back","cs":"Sarah Langlois","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s EIS contract update here.","importSourcePath":"Contract Management Section.docx#details#EIS"}', 'COMPLETED', NULL, 1778091371979, 1782324094439);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('cmoueqtxy001a90udrw9mp4o3', 'BOB', '{"category":"New Awards and Recompetes","activeContract":{"contractName":"BOB","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s BOB contract update here."}', 'COMPLETED', NULL, 1778093137943, 1778099719851);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('cmoukhyg2000411fpst3i90hm', 'EIS', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"EIS","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s EIS contract update here."}', 'COMPLETED', NULL, 1778102801569, 1778103380289);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('cmp33hm9h0000iza9qojok6pj', 'EIS', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"EIS","cor":"Sergey Minchenkov","contractNumber":"68HERD22F0007","office":"CFAID","nextPeriodOfPerf":"10/17/2026","ultimateCompletionDate":"10/17/2032","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s EIS contract update here."}', 'ACTIVE', NULL, 1778618427894, 1782323914899);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('cmpx2ems90000788vw082lx08', 'EIS (Enterprise Infrastructure Services) Task Order', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"EIS (Enterprise Infrastructure Services) Task Order","cor":"Sergey Minchenkov","contractNumber":"GS00Q17NSD3000, Task Order 68HERD22F0007","office":"EPA","nextPeriodOfPerf":"2026-10-17","ultimateCompletionDate":"2032-10-17","co":"Kaela Back","cs":"Sarah Langlois","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Add this week''s EIS (Enterprise Infrastructure Services) Task Order contract update here."}', 'COMPLETED', NULL, 1780430594265, 1780431040706);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-8879bc71a4e99b8cb6e7b7dd', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', '{"category":"New Awards and Recompetes","activeContract":{"contractName":"Future Enhancements - Orders Payload for IPL Basic and IPL Core","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core","importSourcePath":"Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core"}', 'COMPLETED', NULL, 1782236988863, 1782323915227);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-2ff57a35df384ce743129385', 'Orders Payload for IPL Basic and IPL Core', '{"category":"New Awards and Recompetes","activeContract":{"contractName":"Orders Payload for IPL Basic and IPL Core","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core","importSourcePath":"Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core"}', 'COMPLETED', NULL, 1782236988944, 1782323915233);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-e400ff653596ab4df65250ad', 'Esri', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Esri","cor":"Garrett Hayes","contractNumber":"68HERD24F0002","office":"GSA","nextPeriodOfPerf":"10/01/2026","ultimateCompletionDate":"09/30/2028","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#ESRI","importSourcePath":"Contract Management Section.docx#details#ESRI"}', 'ACTIVE', NULL, 1782236988982, 1782323914928);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-b539f4fd85c22b1a2d0f63ba', 'AT&T (via EMDC) (call order)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"AT&T (via EMDC) (call order)","cor":"Jake Beja","contractNumber":"68HERL26A0002/68HERL26F0051","office":"CFAAID","nextPeriodOfPerf":"06/30/2026","ultimateCompletionDate":"01/14/2031","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"Sealed Bids Including 2 Step","paltDollarValue":"Up to $1M","paltBeginOitoEngagement":"2026-06-30","paltOitoEngagement":"2026-09-28","paltMilestones":"[{\"id\":0,\"milestone\":\"Begin ITOD Engagement\",\"dueDate\":\"2026-06-30\",\"days\":\"90\"},{\"id\":1,\"milestone\":\"ITOD Engagement Ends\",\"dueDate\":\"2026-09-28\",\"days\":\"30\"},{\"id\":2,\"milestone\":\"Acquisition Planning Complete\",\"dueDate\":\"2026-10-29\",\"days\":\"30\"},{\"id\":3,\"milestone\":\"Procurement Package Complete\",\"dueDate\":\"2026-12-01\",\"days\":\"15\"},{\"id\":4,\"milestone\":\"Solicitation Issued\",\"dueDate\":\"2026-12-16\",\"days\":\"30\"},{\"id\":5,\"milestone\":\"Proposals Received\",\"dueDate\":\"2027-01-15\",\"days\":\"15\"},{\"id\":6,\"milestone\":\"Tech Evaluations Complete\",\"dueDate\":\"2027-01-30\",\"days\":\"15\"},{\"id\":7,\"milestone\":\"Final Proposals Received\",\"dueDate\":\"2027-02-14\",\"days\":\"15\"},{\"id\":8,\"milestone\":\"Award Complete\",\"dueDate\":\"2027-03-01\",\"days\":\"End Date\"}]"},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Mobile - EMDC - AT&T"}', 'ACTIVE', NULL, 1782236989040, 1782850054312);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-1175226adce593ff68fdde37', 'Verizon (via EMDC) (call order)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Verizon (via EMDC) (call order)","cor":"Jake Beja","contractNumber":"68HERL26A0004/68HERL26F0052","office":"CFAAID","nextPeriodOfPerf":"06/30/2026","ultimateCompletionDate":"01/14/2031","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Mobile - EMDC - Verizon","importSourcePath":"Contract Management Section.docx#details#Mobile - EMDC - Verizon"}', 'ACTIVE', NULL, 1782236989186, 1782323914960);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-d029e826a7d7aa31c028b829', 'Mobile - EMDC - T-Mobile', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Mobile - EMDC - T-Mobile","cor":"Jake Beja /Alt:  Sergey Minchenkov","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Mobile - EMDC - T-Mobile","importSourcePath":"Contract Management Section.docx#details#Mobile - EMDC - T-Mobile"}', 'COMPLETED', NULL, 1782236989338, 1782324094447);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-a809fd21f697d457ab18ec72', 'T-Mobile (Legacy Contract) (no call order @ this time)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"T-Mobile (Legacy Contract) (no call order @ this time)","cor":"Jake Beja","contractNumber":"47QTCA22D008N/68HERD23F0130","office":"ITAD","nextPeriodOfPerf":"6/30/2026","ultimateCompletionDate":"6/30/2026","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)","importSourcePath":"Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)"}', 'ACTIVE', NULL, 1782236989416, 1782323914976);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-832e8c8ddb89f3f257fe9c8e', 'Adobe ELA', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Adobe ELA","cor":"Garrett Hayes","contractNumber":"NNG15SD38B/68HERF26F0002","office":"CFAID","nextPeriodOfPerf":"11/26/2026","ultimateCompletionDate":"11/26/2026","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#Adobe ELA","importSourcePath":"Contract Management Section.docx#details#Adobe ELA"}', 'ACTIVE', NULL, 1782236989559, 1782323914878);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-section-9a1440b0a0d6424294cec1dd', 'FY26 Out of Cycle Requests (OCR)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"FY26 Out of Cycle Requests (OCR)","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Data Processing Activity.docx","importSourcePath":"Data Processing Activity.docx"}', 'COMPLETED', NULL, 1782236989572, 1782323915223);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-section-dfbf956b1535007eccc45230', 'Quarterly Service Review/STAR Format (Terri)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Quarterly Service Review/STAR Format (Terri)","cor":"","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Service and Project Management Section.docx","importSourcePath":"Service and Project Management Section.docx"}', 'COMPLETED', NULL, 1782236989937, 1782323915239);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-057dbdf775d573de25e7b743', 'ITS-EPA IV ESSET (End User Services)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ITS-EPA IV ESSET (End User Services)","cor":"Michelle Cuilla","contractNumber":"47QFCA22F0026","office":"FEDSIM","nextPeriodOfPerf":"6/2/2027","ultimateCompletionDate":"6/2/2029","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#ESSET","importSourcePath":"Contract Management Section.docx#details#ESSET"}', 'ACTIVE', NULL, 1782238547483, 1782323914995);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-3a6aa924799c90ebc86046d3', 'ITS-EPA IV MAINES (Infrastructure & Hosting)', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ITS-EPA IV MAINES (Infrastructure & Hosting)","cor":"Adam VanEnwyck","contractNumber":"47QFCA22F0018","office":"FEDSIM","nextPeriodOfPerf":"4/3/2026","ultimateCompletionDate":"4/3/2029","co":"Aaron Sannutti aaron.sannutti@gsa.gov (GSA)","cs":"Natalia Belinsky natalia.belinsky@gsa.gov (GSA)","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#MAINES","importSourcePath":"Contract Management Section.docx#details#MAINES"}', 'ACTIVE', NULL, 1782238547594, 1782323915037);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-3cca6c65f4f89588245aa152', 'ITSM / STAR Support', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ITSM / STAR Support","cor":"Garrett Hayes","contractNumber":"68HERD23F0049","office":"CFAIAD","nextPeriodOfPerf":"3/15/2027","ultimateCompletionDate":"3/15/2029","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#ITSM/STAR Support","importSourcePath":"Contract Management Section.docx#details#ITSM/STAR Support"}', 'ACTIVE', NULL, 1782238547873, 1782323915085);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-5f48f8cdadd6d7029a70c638', 'Qualtrics (via Carahsoft) BPA', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Qualtrics (via Carahsoft) BPA","cor":"Adam VanEnwyck","contractNumber":"47QSWA18D008F/68HERD24A0005","office":"ITAD","nextPeriodOfPerf":"02/25/2027","ultimateCompletionDate":"02/22/2029","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA","importSourcePath":"Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA"}', 'ACTIVE', NULL, 1782238548039, 1782323915102);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-8bdd5dee44f90d09fd873e19', 'GAVETS 2', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"GAVETS 2","cor":"Garrett Hayes","contractNumber":"47QFPA25F0008","office":"GSA","nextPeriodOfPerf":"5/13/2027","ultimateCompletionDate":"5/13/2030","co":"Greg Keller","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#GAVETS 2","importSourcePath":"Contract Management Section.docx#details#GAVETS 2"}', 'ACTIVE', NULL, 1782238549354, 1782323915134);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-eae8e00c70a495083e0607af', 'DicksonOne', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"DicksonOne","cor":"Sergey Minchenkov","contractNumber":"","office":"ITAD","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"TBD","cs":"TBD","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#DicksonOne","importSourcePath":"Contract Management Section.docx#details#DicksonOne"}', 'ACTIVE', NULL, 1782238549620, 1782323915169);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-ca130e3ffe78ee6a16735530', 'TrueTandem', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"TrueTandem","cor":"Garrett Hayes","contractNumber":"","office":"","nextPeriodOfPerf":"","ultimateCompletionDate":"","co":"TBD","cs":"TBD","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#TrueTandem","importSourcePath":"Contract Management Section.docx#details#TrueTandem"}', 'ACTIVE', NULL, 1782238549673, 1782323915187);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-43ff00ad21c61d3a413f4cf1', 'ICMS - V', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"ICMS - V","cor":"Shela Poke-Williams","contractNumber":"68HERD23D0001 - Daycom\n68HERD23D0002 - Abaco Blackfish\n68HERD23D0003 - Agile","office":"ITAD","nextPeriodOfPerf":"11/01/2022 - 10/31/2027","ultimateCompletionDate":"10/31/2027","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#IMCS – V","importSourcePath":"Contract Management Section.docx#details#IMCS – V"}', 'ACTIVE', NULL, 1782238549713, 1782324079490);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-5c4031542012d126e56612ca', 'Abaco Blackfish', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Abaco Blackfish","cor":"Shela Poke-Williams","contractNumber":"68HERD23D0002  Task Orders:   68HERD23F0052, 68HERD23F0103","office":"","nextPeriodOfPerf":"10/31/2027","ultimateCompletionDate":"10/31/2027","co":"Shelley Marley","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Abaco Blackfish","importSourcePath":"Contract Management Section.docx#details#Abaco Blackfish"}', 'COMPLETED', NULL, 1782238549752, 1782323915208);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-be12f0eecafb0baa6f69f8dd', 'Agile Decision Sciences', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Agile Decision Sciences","cor":"Shela Poke-Williams","contractNumber":"68HERD23D003","office":"","nextPeriodOfPerf":"10/31/2027","ultimateCompletionDate":"10/31/2027","co":"Ross Gillingham","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Agile Decision Sciences","importSourcePath":"Contract Management Section.docx#details#Agile Decision Sciences"}', 'COMPLETED', NULL, 1782238549934, 1782323915213);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-050f0bd7f3153f89a03aad6f', 'Daycom', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Daycom","cor":"Shela Poke-Williams","contractNumber":"68HERD23D0001","office":"","nextPeriodOfPerf":"10/31/2027","ultimateCompletionDate":"10/31/2027","co":"Melinda McBride","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Daycom","importSourcePath":"Contract Management Section.docx#details#Daycom"}', 'COMPLETED', NULL, 1782238550081, 1782323915218);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-65355f1c5465ef3091ebbb1b', 'IMCS-VI', '{"category":"New Awards and Recompetes","activeContract":{"contractName":"IMCS-VI","cor":"Dawn Lamb","contractNumber":"68HERF26P0034","office":"","nextPeriodOfPerf":"- A.R.O. 45 days","ultimateCompletionDate":"- A.R.O. 45 days","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#IMCS-VI","importSourcePath":"Contract Management Section.docx#details#IMCS-VI"}', 'ACTIVE', NULL, 1782238550611, 1782243020014);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-baf0be6e5b1e6094b8e3775d', 'Oracle 2026', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Oracle 2026","cor":"Sergey Minchenkov","contractNumber":"NNG15SC59B/68HERF26F0053","office":"CFAIAD","nextPeriodOfPerf":"3/31/2027","ultimateCompletionDate":"3/31/2027","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#2024 Oracle","importSourcePath":"Contract Management Section.docx#details#2025 ORACLE"}', 'ACTIVE', NULL, 1782238551268, 1782323915071);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-d30fe6889e2da89ade70e94c', '2024 Printer Refresh and Accessories', '{"category":"Legacy Contracts","activeContract":{"contractName":"2024 Printer Refresh and Accessories","cor":"Andrew Rhoades and Dawn Lamb","contractNumber":"68HERD24F0075","office":"","nextPeriodOfPerf":"June 2024","ultimateCompletionDate":"June 2024","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#2024 Printer Refresh and Accessories","importSourcePath":"Contract Management Section.docx#details#2024 Printer Refresh and Accessories"}', 'ACTIVE', NULL, 1782238551524, 1782243020091);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-f0484471e8858bfc2db838ff', '2025 Printer Refresh 2nd Order CY24', '{"category":"Legacy Contracts","activeContract":{"contractName":"2025 Printer Refresh 2nd Order CY24","cor":"Dawn Lamb","contractNumber":"68HERD25F0155","office":"","nextPeriodOfPerf":"9/5/2025 - A.R.O. 45 days","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24","importSourcePath":"Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24"}', 'ACTIVE', NULL, 1782238552124, 1782243020155);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-614f28f4029854f21450b5c7', 'Microsoft ELA', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"Microsoft ELA","cor":"Kim Farmer","contractNumber":"68HERD23A0001","office":"CFAID","nextPeriodOfPerf":"4/30/2027","ultimateCompletionDate":"4/30/2026","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Legacy Microsoft ELA","importSourcePath":"Contract Management Section.docx#details#Legacy Microsoft ELA"}', 'ACTIVE', NULL, 1782238552321, 1782323915015);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-f3407cda0843798fd3d706e6', 'Infotech 2024', '{"category":"Legacy Contracts","activeContract":{"contractName":"Infotech 2024","cor":"Kim Farmer","contractNumber":"GS-35F-298GA /68HE0P24F0004","office":"","nextPeriodOfPerf":"01/09/2025","ultimateCompletionDate":"01/09/2025","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Infotech 2024","importSourcePath":"Contract Management Section.docx#details#Infotech 2024"}', 'ACTIVE', NULL, 1782238552733, 1782243020213);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-d3b1aa0179954f23527943d1', 'Records Management – DC', '{"category":"Legacy Contracts","activeContract":{"contractName":"Records Management – DC","cor":"Kim Farmer","contractNumber":"68HERD23F0109 / TO 0024","office":"","nextPeriodOfPerf":"4/30/2025","ultimateCompletionDate":"4/30/2028","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Records Management – DC","importSourcePath":"Contract Management Section.docx#details#Records Management – DC"}', 'ACTIVE', NULL, 1782238552998, 1782243020251);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-c36e2aadda827ded8c159f09', 'Jan. 2026 PC (Laptops) Refresh', '{"category":"Legacy Contracts","activeContract":{"contractName":"Jan. 2026 PC (Laptops) Refresh","cor":"Kim Farmer","contractNumber":"68HERF26F0048","office":"","nextPeriodOfPerf":"- A.R.O. 45 days","ultimateCompletionDate":"","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh","importSourcePath":"Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh"}', 'ACTIVE', NULL, 1782238553069, 1782243020270);
INSERT INTO projects (id, name, description, status, createdBy, createdAt, updatedAt) VALUES ('import-contract-8e811cb28d5f5d3761ca5634', 'eBusiness', '{"category":"Current and Active Contracts/Purchase Order Outlook","activeContract":{"contractName":"eBusiness","cor":"Adam VanEnwyck","contractNumber":"GS-35F-116AA/68HERD25F0001","office":"ITAD","nextPeriodOfPerf":"11/09/2025","ultimateCompletionDate":"11/09/2029","co":"","cs":"","orderNumber":"","palt":"","paltProcurementType":"","paltDollarValue":"","paltBeginOitoEngagement":"","paltOitoEngagement":"","paltMilestones":""},"imageUrl":"https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=80","imageAlt":"Contract and acquisition planning documents on an office desk.","currentUpdatePlaceholder":"Imported from Contract Management Section (2).docx#eBusiness","importSourcePath":"Contract Management Section.docx#details#eBusiness"}', 'ACTIVE', NULL, 1782241800240, 1782323914910);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkcz0052q4elkdup6p28', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, 'demo-admin', 1782242103636);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkh10057q4ell9c97uht', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, 'demo-admin', 1782242103781);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkqz005pq4elweac1qkp', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, 'demo-admin', 1782242104140);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkrm005qq4elzz5jyd62', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, 'demo-admin', 1782242104162);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xks9005rq4eljlaw74fr', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, 'demo-admin', 1782242104186);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xktd005sq4elhdcbvs3x', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, 'demo-admin', 1782242104226);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkv7005vq4eljxv8ypro', 'import-dawn-lamb', 'import-contract-d30fe6889e2da89ade70e94c', NULL, 'demo-admin', 1782242104292);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkwp005xq4elao9of01s', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, 'demo-admin', 1782242104345);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xky5005zq4elgpazykfo', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, 'demo-admin', 1782242104398);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkz10060q4elm36685je', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, 'demo-admin', 1782242104430);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqr0xkzm0061q4elisbml8gn', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, 'demo-admin', 1782242104450);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqs4jcam0001xpx7thdkw48h', 'demo-contributor', 'import-contract-d30fe6889e2da89ade70e94c', NULL, NULL, 1782308624637);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqs4jcb80005xpx7hs2gwzep', 'demo-contributor', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1782308624661);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2bw0001x35rgrwmfmys', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, 'demo-admin', 1782323914892);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2ca0003x35r6ghbi5a3', 'cmpx2emsj0001788vfgr7eaal', 'cmp33hm9h0000iza9qojok6pj', NULL, 'demo-admin', 1782323914907);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2cs0005x35rwblxkcq5', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, 'demo-admin', 1782323914924);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2d70007x35rplproxl6', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, 'demo-admin', 1782323914940);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2dp0009x35rytd7l6ro', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, 'demo-admin', 1782323914957);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2e4000bx35ruunj0z05', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, 'demo-admin', 1782323914973);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2em000dx35re3331gq8', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, 'demo-admin', 1782323914991);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2f5000fx35rno88o36b', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, 'demo-admin', 1782323915010);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2fr000hx35re2ww0e14', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, 'demo-admin', 1782323915031);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2g9000jx35r32uir73p', 'import-adam-vanenwyck', 'import-contract-3a6aa924799c90ebc86046d3', NULL, 'demo-admin', 1782323915049);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2gq000lx35rp35mcwxm', 'import-dawn-lamb', 'hesc-ii', NULL, 'demo-admin', 1782323915067);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2h5000nx35r6lf7c5ah', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, 'demo-admin', 1782323915082);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2hl000px35rpra69sql', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, 'demo-admin', 1782323915097);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2i0000rx35rpgzawaoo', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, 'demo-admin', 1782323915112);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2ii000tx35rfd8ky69m', 'import-dawn-lamb', 'ebusiness', NULL, 'demo-admin', 1782323915130);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2ix000vx35rtfgtm2yn', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, 'demo-admin', 1782323915146);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2jf000xx35rdyqdaiqn', 'import-michelle-cuilla', 'iti-iii', NULL, 'demo-admin', 1782323915163);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2jy000zx35rkslzrbq8', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-eae8e00c70a495083e0607af', NULL, 'demo-admin', 1782323915182);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdn2kj0011x35r4714p41p', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, 'demo-admin', 1782323915203);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdqlce00014pich7mlmdf5', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, 'demo-admin', 1782324079502);
INSERT INTO project_assignments (id, userId, projectId, componentId, assignedBy, assignedAt) VALUES ('cmqsdr1w60001au3ujzzpggqr', 'demo-contributor', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1782324100950);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qji70001vqrvyi6yxbm7', 'demo-contributor', 'ebusiness', NULL, NULL, 1775595600000, 'Funding remained unchanged. AT&T ATO work continued, including P00060 execution. EPA continued disputing disconnect charges and prepared a response to the vendor''s ongoing compensation request.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjij0003vqrv076ruknp', 'demo-contributor', 'ebusiness', NULL, NULL, 1774386000000, 'March-April funding in the amount of $3.35M was processed, with an additional $5.1M request planned. Five ATOs remained in development. EPA continued addressing vendor charges tied to 1,100 line disconnects and IVR transition support.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjiv0005vqrv8fycytko', 'demo-contributor', 'ebusiness', NULL, NULL, 1773176400000, 'Funding for March-April 2026 was approved and awaited final commitment. Multiple ATOs were in progress. EPA and AT&T continued discussing NGV transition costs, including disconnects and returned hard phones.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjkd0007vqrv9lkl6hrw', 'demo-contributor', 'ebusiness', NULL, NULL, 1770760800000, 'A Starlink ATO and more than 10 additional ATOs were being developed. EPA reviewed disputed disconnect pricing and assessed the vendor''s request for compensation related to unused hard phones.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjl7000bvqrv51q3sfrp', 'jamila-barnes', 'hesc-ii', NULL, NULL, 1775595600000, 'EVML requests were finalized and transitioned to Jamila and Brian. HPC demand rose to 34 active requests, 6 additional OASES projects, and 5 expected submissions, while GDIT prepared access shutdown and overage notifications for noncompliant or over-allocation projects.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjlh000dvqrvyy6ng5vf', 'jamila-barnes', 'hesc-ii', NULL, NULL, 1774386000000, 'Funding runout was projected for May 2. A $450,000 incremental funding request was sent to Garrett through June 1, FY26 EMVL funding commitments were being collected by Heidi Paulsen, and the TPOC planned follow-up outreach to SROs to avoid possible service interruptions or stop work.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, 1778528017015, 1774310400000, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjlr000fvqrvjulfl6ky', 'jamila-barnes', 'hesc-ii', NULL, NULL, 1773176400000, 'Incremental funding of $448,242 for 4/1/2026 through 5/12/2026 remained pending. CPARS reviews were submitted to GSA on 3/4/2026, and letters were sent to program offices requesting EMVL project plans and funding commitments by 3/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2qjm1000hvqrv4m64udgk', 'jamila-barnes', 'hesc-ii', NULL, NULL, 1771970400000, 'EO Compliance approved incremental funding of $448,242 on 2/16/2026. HPC FY26 project applications were due February 27, and the EMVL MicroSAP project plan was no longer expected to receive funding because the program office did not approve it.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2uw4m000uvqrvpl2g5to1', 'demo-contributor', 'hesc-ii', NULL, NULL, 1776805200000, 'Status update for HESC II: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778012705830, 1778012705830);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2uw4m000vvqrvwsxljdis', 'demo-contributor', 'hesc-ii', NULL, NULL, 1778014800000, 'WAR update for HESC II: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, 1778528017015, 1778012705830, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2uw4z000yvqrvxzpknglt', 'demo-contributor', 'iti-iii', NULL, NULL, 1776805200000, 'Status update for ITI III: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778012705843, 1778012705843);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmot2uw4z000zvqrvqrshe71u', 'demo-contributor', 'iti-iii', NULL, NULL, 1778014800000, 'WAR update for ITI III: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778012705843, 1778012705843);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoudt700000390ud7r3rpnni', 'demo-contributor', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1776805200000, 'Status update for EIS: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778091568561, 1778091568561);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoudt700000490udj7pqy88k', 'demo-contributor', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1778014800000, 'WAR update for EIS: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, 1778528017015, 1778091568561, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmouep2rh001590udcwe5tekw', 'demo-contributor', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778093056062, 1778093090242);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoueqtz7001d90ud2l6unpgo', 'demo-contributor', 'cmoueqtxy001a90udrw9mp4o3', NULL, NULL, 1776805200000, 'Status update for BOB: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778093137988, 1778093137988);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoueqtz7001e90udfytucahq', 'demo-contributor', 'cmoueqtxy001a90udrw9mp4o3', NULL, NULL, 1778014800000, 'WAR update for BOB: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, 1778528017015, 1778093137988, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmouer8dj001g90ud2bgj7tkc', 'demo-contributor', 'cmoueqtxy001a90udrw9mp4o3', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778093156647, 1778096529951);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoukhygp000711fpjjpgd6vh', 'demo-contributor', 'cmoukhyg2000411fpst3i90hm', NULL, NULL, 1776805200000, 'Status update for EIS: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1778102801593, 1778102801593);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoukhygp000811fp58khwdft', 'demo-contributor', 'cmoukhyg2000411fpst3i90hm', NULL, NULL, 1778014800000, 'WAR update for EIS: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778102801593, 1778102889640);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmoukj6w3000a11fptfea8pmo', 'demo-contributor', 'cmoukhyg2000411fpst3i90hm', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778102859171, 1778618492574);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmovglf3n0001ag3g0sp2pf2z', 'demo-contributor', 'hesc-ii', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, 1778528017015, 1778156710834, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmp1ebce40001fgvkz5buuwlx', 'demo-contributor', 'hesc-ii', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, 1778528017015, 1778515678584, 1778528017017);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmp1lei6r0001tlzd3pql84d6', 'demo-contributor', 'hesc-ii', NULL, NULL, 1778014800000, 'afhfh', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1778527583377, 1778529289215);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmp33hmad0003iza9nnhyvba6', 'demo-contributor', 'cmp33hm9h0000iza9qojok6pj', NULL, NULL, 1778014800000, 'No update this week.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1778618427925, 1778618464180);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmp33hmad0004iza9mper6ri5', 'demo-contributor', 'cmp33hm9h0000iza9qojok6pj', NULL, NULL, 1778014800000, 'WAR update for EIS: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1778618427925, 1778618427925);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emt60005788vw940jfvk', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1780434000000, 'Funding: Funding of $5.1M to cover the remainder of the current PoP (through 10/17/2026) was approved by Will/Mike/Garrett on 05/05/2026. COR is developing the contract mod to obligate the funding. ATQs: 2 ATQs were approved by EOB and are being processed by the COR and the CO. 10+ ATQs are being developed by EPA and the vendor. Issues: According to AT&T, the vendor''s accounting for the Next Gen Voice licenses and hard phones has been inaccurate in FY25-FY26. AT&T is analyzing the data on the billing errors, and will submit it to EPA for review. It is yet uncertain what the scope of the planned billing correction will be.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780430594298, 1780431747915);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emtg0007788vr0lsi2bm', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1778014800000, 'Funding: COR estimates the need of $5.1M to fund this contract through the rest of the fiscal year / current period of performance. (The PoP runs through October 17, 2026.) ATQs: 1 ATQ was approved by EOB and is being processed by the COR and the CO. 11 ATQs are being developed by EPA and the vendor. Issues: According to AT&T, the vendor''s accounting for the Next Gen Voice licenses and hard phones has been inaccurate in FY25-FY26. AT&T is analyzing the data on the billing errors, and will submit it to EPA for review.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594309, 1780430594309);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emto0009788vz8j3i6dj', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1778014800000, 'Funding: None. ATQs: 11 ATQs are being developed by EPA and the vendor. Issues: Issues associated with the bulk disconnect of EPA lines that are no longer needed was resolved: The vendor''s proposed cost of $33K for disconnecting 1,000 users who left under DRP and other restructuring actions was adjudicated by the Contracting Officer to be justified. Tiffany approved the expenditure. Going forward, AT&T is changing its methodology for bulk disconnects. Rather than charging per line, AT&T will allocate a certain number of hours to EPA per month. Only if these hours are exhausted would the EPA incur additional costs. According to the analysis by Lemont Phelps, this approach is beneficial for the EPA.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594316, 1780430594316);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emtv000b788v42th8djz', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1776805200000, 'Funding: None. ATQs: Urgent task order modification P00060 - with five ATQs and a change in the vendor''s key personnel -- was signed on 04/06/2026. 13 additional ATQs are being developed by EPA and the vendor. Issues: One issue related to the unexpected costs of the contract work continue to be debated by the vendor and the CO at this time: Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $33K. (Original price tag was $95K, later discounted to $63K, then discounted to $31.5K, and then trued-up to $33K.) Tiffany and the CO concurred (internally) on paying this price, but have not announced the decision to the vendor yet. Long-term Solution: COR''s overall position is that line disconnects should be a part of normal managed service, and that their cost was not proposed as a separate line item at the time of the vendor''s NGV proposal. Therefore, the NGV line disconnects should not cost extra. However, the vendor disagrees. They confirmed that the routine ongoing disconnects will not carry the extra cost, but the vendor considers the disconnects of more than 10 lines at a time to be special projects, and thus they will cost extra. This approach led them to pause the processing of an additional disconnect request for 1,697 lines until EPA agrees to pay the price of $12K for it. CO is currently considering how EPA should respond. Starting in April 2026, the vendor is revising their approach to disconnects and other line-provisioning actions, and should be able to process bulk disconnect requests largely at no extra cost to EPA. CO is leaning towards is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects. Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594323, 1780430594323);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emu4000d788v42f3pbrt', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1774386000000, 'Funding: Funding of $3,350,000.00 (for March-April 2026) was processed, and the funding mod was issued to the vendor. Based on the revised invoice estimates, this funding should last through May 2026. Additional funding of $5,100,000.00 to cover the remainder of the current period of performance will be requested in April-May. ATQs: Five ATQs are in the works with the COR and the CO. 10 additional ATQs were requested by EPA and are being developed by the vendor. Issues: Two issues related to the unexpected costs of the contract work continue to be debated by the vendor and the CO at this time: Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $33K. (Original price tag was $95K, later discounted to $63K, then discounted to $31.5K, and then trued-up to $33K.) Tiffany and the CO concurred (internally) on paying this price, but disagree that the further ongoing line disconnects should cost EPA anything (as EPA expects the line disconnects to be a part of normal managed service). CO is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects. Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed. AT&T and ITOD are at odds about the costs of the vendor''s support for the IPv6 transition at EPA. The vendor claims that this support should be provided at cost, whereas EPA''s interpretation of the contract requirements suggest otherwise. CO sent a letter to the vendor rejecting their compensation claims. AT&T subsequently continued to disagree. The vendor stands by their argument of providing these services at extra cost. CO is currently gathering additional information for the adjudication of this matter.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594332, 1780430594332);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emub000f788vf0k2mtmj', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1773176400000, 'Funding: Funding of $3,350,000.00 (for March-April 2026) was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February. As of 02/27, still pending for SRO Approval on this $1M+ funding action. Per Kristen Arel, SRO should approve soon. ATQs: Three ATQs are in the works with the COR and the CO. 10+ additional ATQs were requested by EPA and are being developed by the vendor. Issues: Two issues related to the unexpected costs of the contract work are being debated by the vendor and the CO at this time: Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $31.5K. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.) Tiffany and the CO concurred (internally) on paying this price, but disagree that the further ongoing line disconnects should cost EPA anything (as EPA expects the line disconnects to be a part of normal managed service). CO is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects. Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed. AT&T and ITOD are at odds about the costs of the vendor''s support for the IPv6 transition at EPA. The vendor claims that this support should be provided at cost, whereas EPA''s interpretation of the contract requirements suggest otherwise. CO sent a letter to the vendor rejecting their compensation claims. AT&T subsequently disagreed and stood by their argument for providing these services at extra cost. CO is currently gathering additional information for the adjudication of this matter.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594340, 1780430594340);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emuj000h788vn2gorq9k', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1770760800000, 'Funding: Funding of $3,350,000.00 (for March-April 2026) was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February. ATQs: One ATQ (for Starlink services) is in the works with the CO. 10+ additional ATQs were requested by EPA and are being developed by the vendor. Issues: Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps. This mass disconnect of 1,100 lines carries the price tag of $31.5K, as per AT&T. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.) Tiffany concurred on paying this price. CO for the EIS contract (Kaela Back) was briefed on the situation, and she is determining the legality of the vendor''s request for the compensation of these charges. AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594348, 1780430594348);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emur000j788vtm4b8nx5', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1770760800000, 'Funding: PR in the amount of $3.5M to fund the contract through February 2026 was processed, and the funding was obligated. Additional funding of $3,350,000.00 was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February. ATQs: Several ATQs are in the works. Issues: Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps. This mass disconnect of 1,100 lines carries the price tag of $31.5K, as per AT&T. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.) Tiffany concurred on paying this price. CO for the EIS contract (Kaela Back) was briefed on the situation, and she is determining the legality of the vendor''s request for the compensation of these charges. AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed. 10+ additional ATQs were requested by EPA and are being developed by the vendor.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594356, 1780430594356);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emuz000l788vq472l993', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1767132000000, 'Funding: PR in the amount of $3.5M to fund the contract through February 2026 was submitted to the FCO on 12/29/2025. (PR# is PR-OFA-26-00098.) The funding action was approved by the SRO (via the SRO Approval process) and the CIO (via the EO Compliance Review process). ATQs: 2 ATQs - for Starlink services and for the Firewall Support in the Office of the Administrator - were submitted to Contracts for processing. Issues: Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps. This mass disconnect of 1,100 lines carries the price tag of $97K, as per AT&T. Tiffany and Lemont are negotiating more favorable terms. AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed. 10+ additional ATQs were requested by EPA and are being developed by the vendor.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594363, 1780430594363);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emv7000n788v3skh6d4o', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1763503200000, 'Funding: Contract is funded through 12/31/2025. COR submitted request for additional funding for the month of January and beyond to Garrett on 11/17/2025. ATQs: 1 ATQ - for Starlink services - is being processed by the COR. It will require the base EIS contract modification with GSA to be modified before EPA can modify our EIS task order and add these services. The vendor is currently working with GSA to modify the base contract. Starlink procurement seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time. 1 ATQ - for mass disconnect of 1,100 phone lines - is under review by EOD This mass disconnect carries the price tag of $97K that was not seemingly accounted for by EOD previously. EOD is deliberating on how to proceed with this project. 10 additional ATQs were requested from the vendor and are being developed.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594371, 1780430594371);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emvd000p788vw2rvep7q', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1762293600000, 'Funding: Contract mod with incremental funding of $1,000,000 (to cover invoices through December 2025) and eight ATQs is with ITAD for processing. The mod is waiting for the final signoff by the CO; it was already countersigned by the vendor. ATQs: 1 ATQ - for Starlink services - is was processed by the COR. It will require the base EIS contract modification with GSA to be modified before EPA can modify our EIS task order and add these services. The vendor is currently working with GSA to modify the base contract. Starlink procurement seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time. 7 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594377, 1780430594377);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emvm000r788vdvu4aloy', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1761080400000, 'Funding: Contract was extended for Option Period 4 (10/18/2025 - 10/17/2026), and funded in the amount of $1.5M. This funding will last through approximately end of November 2025. PR for additional incremental funding of $1M was prepared and submitted to the FCO for commitment on 10/21/2025. The funding action was approved by all necessary parties. Once obligated, this funding will fund the contract through the end of December 2025. ATQs: 9 ATQs were processed by the COR and submitted to ITAD to be added to the contract. 1 ATQ is under technical review by EOD. 1 ATQ - for Starlink equipment - was submitted by the vendor and approved by the technical SMEs, but it seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time. 14 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594386, 1780430594386);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2emvt000t788vttq78gen', 'cmpx2emsj0001788vfgr7eaal', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1759870800000, 'Funding: Current period of performance will end on 10/17/2025 COR and the WCF accountants secured the incremental funding of $1.5M to exercise the next period of performance (Option Period 4). EO Compliance Review approval and the SRO Approval for this funding action were obtained. As of this writing (3 p.m. on 10/07/2025), WCF is waiting for the Office of Budget to release the WR forward funds. Once released, these funds will be used to fund this action. WR forward funds are expected to be released as early as 10/08/2025. FCO will commit the funds and the CO will obligate the funds as soon as they are available. ATQs: Multiple ATQs are being processed by the COR and the CO and will be added to the contract through the mod. 9 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1780430594393, 1780430594393);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2fx3r0002jzb5bcllk964', 'demo-contributor', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1779224400000, 'Status update for EIS (Enterprise Infrastructure Services) Task Order: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1780430654295, 1780430654295);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmpx2fx3r0003jzb5l8uov8hc', 'demo-contributor', 'cmpx2ems90000788vw082lx08', NULL, NULL, 1780434000000, 'WAR update for EIS (Enterprise Infrastructure Services) Task Order: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780430654295, 1780431709576);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxop001vkj72cjwcu2l2', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1780434000000, '06/03:
Funding:
Funding of $5.1M to cover the remainder of the current PoP (through 10/17/2026) was approved by Will/Mike/Garrett on 05/05/2026.
COR is waiting for the SRO approval for this funding action prior to developing the contract mod to obligate the funding.
SRO Approval request was submitted on 05/27/2026.
ATQs:
1 ATQ was approved by EOB and is being processed by the COR and the CO.
9 ATQs are being developed by EPA and the vendor.
Issues:
According to AT&T, the vendor''s accounting for the Next Gen Voice licenses and hard phones has been inaccurate in FY25-FY26.
AT&T claims that approx. 18,000 licenses that EPA has gradually purchased since August 2024 have not yet been billed to EPA. AT&T is to provide a month-by-month assessment of the license costs, so that EPA and AT&T can jointly strategize on the most appropriate invoicing and funding approach.
At present, EPA (Harlan and Mike Orton) are reviewing the license number to ensure that they are correct and acceptable for billing.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780444800000, 1780444800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxov001xkj72zfd3xqre', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1779224400000, '05/20:
Funding:
Funding of $5.1M to cover the remainder of the current PoP (through 10/17/2026) was approved by Will/Mike/Garrett on 05/05/2026.
COR is developing the contract mod to obligate the funding.
ATQs:
2 ATQs were approved by EOB and are being processed by the COR and the CO.
10+ ATQs are being developed by EPA and the vendor.
Issues:
According to AT&T, the vendor''s accounting for the Next Gen Voice licenses and hard phones has been inaccurate in FY25-FY26.
AT&T is analyzing the data on the billing errors, and will submit it to EPA for review.
It is yet uncertain what the scope of the planned billing correction will be.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxp2001zkj72qoatgfey', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1778014800000, '05/04:
Funding:
COR estimates the need of $5.1M to fund this contract through the rest of the fiscal year / current period of performance. (The PoP runs through October 17, 2026.)
ATQs:
1 ATQ was approved by EOB and is being processed by the COR and the CO.
11 ATQs are being developed by EPA and the vendor.
Issues:
According to AT&T, the vendor''s accounting for the Next Gen Voice licenses and hard phones has been inaccurate in FY25-FY26.
AT&T is analyzing the data on the billing errors, and will submit it to EPA for review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxp80021kj72ro104oi5', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1778014800000, '04/23:
Funding:
None.
ATQs:
11 ATQs are being developed by EPA and the vendor.
Issues:
Issues associated with the bulk disconnect of EPA lines that are no longer needed was resolved:
The vendor''s proposed cost of $33K for disconnecting 1,000 users who left under DRP and other restructuring actions was adjudicated by the Contracting Officer to be justified. Tiffany approved the expenditure.
Going forward, AT&T is changing its methodology for bulk disconnects. Rather than charging per line, AT&T will allocate a certain number of hours to EPA per month. Only if these hours are exhausted would the EPA incur additional costs.
According to the analysis by Lemont Phelps, this approach is beneficial for the EPA.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxpe0023kj72kaovvz5e', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1775595600000, '04/08:
Funding:
None.
ATQs:
Urgent task order modification P00060 - with five ATQs and a change in the vendor''s key personnel -- was signed on 04/06/2026.
13 additional ATQs are being developed by EPA and the vendor.
Issues:
One issue related to the unexpected costs of the contract work continue to be debated by the vendor and the CO at this time:
Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $33K. (Original price tag was $95K, later discounted to $63K, then discounted to $31.5K, and then trued-up to $33K.)
Tiffany and the CO concurred (internally) on paying this price, but have not announced the decision to the vendor yet.
Long-term Solution:
COR''s overall position is that line disconnects should be a part of normal managed service, and that their cost was not proposed as a separate line item at the time of the vendor''s NGV proposal. Therefore, the NGV line disconnects should not cost extra.
However, the vendor disagrees. They confirmed that the routine ongoing disconnects will not carry the extra cost, but the vendor considers the disconnects of more than 10 lines at a time to be special projects, and thus they will cost extra.
This approach led them to pause the processing of an additional disconnect request for 1,697 lines until EPA agrees to pay the price of $12K for it.
CO is currently considering how EPA should respond.
Starting in April 2026, the vendor is revising their approach to disconnects and other line-provisioning actions, and should be able to process bulk disconnect requests largely at no extra cost to EPA.
CO is leaning towards is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects.
Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxpj0025kj7208uz0k0l', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1774386000000, '03/24:
Funding:
Funding of $3,350,000.00 (for March-April 2026) was processed, and the funding mod was issued to the vendor. Based on the revised invoice estimates, this funding should last through May 2026.
Additional funding of $5,100,000.00 to cover the remainder of the current period of performance will be requested in April-May.
ATQs:
Five ATQs are in the works with the COR and the CO.
10 additional ATQs were requested by EPA and are being developed by the vendor.
Issues:
Two issues related to the unexpected costs of the contract work continue to be debated by the vendor and the CO at this time:
Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $33K. (Original price tag was $95K, later discounted to $63K, then discounted to $31.5K, and then trued-up to $33K.)
Tiffany and the CO concurred (internally) on paying this price, but disagree that the further ongoing line disconnects should cost EPA anything (as EPA expects the line disconnects to be a part of normal managed service).
CO is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects.
Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed.
AT&T and ITOD are at odds about the costs of the vendor''s support for the IPv6 transition at EPA. The vendor claims that this support should be provided at cost, whereas EPA''s interpretation of the contract requirements suggest otherwise.
CO sent a letter to the vendor rejecting their compensation claims.
AT&T subsequently continued to disagree. The vendor stands by their argument of providing these services at extra cost.
CO is currently gathering additional information for the adjudication of this matter.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxpp0027kj72m4h4e3bk', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1773176400000, '02/27:
Funding:
Funding of $3,350,000.00 (for March-April 2026) was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February.
As of 02/27, still pending for SRO Approval on this $1M+ funding action. Per Kristen Arel, SRO should approve soon.
ATQs:
Three ATQs are in the works with the COR and the CO.
10+ additional ATQs were requested by EPA and are being developed by the vendor.
Issues:
Two issues related to the unexpected costs of the contract work are being debated by the vendor and the CO at this time:
Costs of disconnecting 1,100 users who left under DRP and other restructuring actions carry -- according to the vendor - the price tag of $31.5K. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.)
Tiffany and the CO concurred (internally) on paying this price, but disagree that the further ongoing line disconnects should cost EPA anything (as EPA expects the line disconnects to be a part of normal managed service).
CO is drafting the response to the vendor, in which she plans to push back on the vendor''s claim for ongoing compensation for the line disconnects.
Once the vendor accepts EPA''s arguments, the at-cost disconnect of 1,100 lines can be processed.
AT&T and ITOD are at odds about the costs of the vendor''s support for the IPv6 transition at EPA. The vendor claims that this support should be provided at cost, whereas EPA''s interpretation of the contract requirements suggest otherwise.
CO sent a letter to the vendor rejecting their compensation claims.
AT&T subsequently disagreed and stood by their argument for providing these services at extra cost.
CO is currently gathering additional information for the adjudication of this matter.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxpu0029kj72luxi7bwg', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1770760800000, '02/10:
Funding:
Funding of $3,350,000.00 (for March-April 2026) was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February.
ATQs:
One ATQ (for Starlink services) is in the works with the CO.
10+ additional ATQs were requested by EPA and are being developed by the vendor.
Issues:
Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps.
This mass disconnect of 1,100 lines carries the price tag of $31.5K, as per AT&T. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.)
Tiffany concurred on paying this price.
CO for the EIS contract (Kaela Back) was briefed on the situation, and she is determining the legality of the vendor''s request for the compensation of these charges.
AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxq1002bkj725apjvzgn', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1770760800000, '01/29:
Funding:
PR in the amount of $3.5M to fund the contract through February 2026 was processed, and the funding was obligated.
Additional funding of $3,350,000.00 was approved by the ITSB Director on 01/20/2026. The paperwork is being processed by the COR to commit the funding before the end of February.
ATQs:
Several ATQs are in the works.
Issues:
Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps.
This mass disconnect of 1,100 lines carries the price tag of $31.5K, as per AT&T. (Original price tag was $95K, later discounted to $63K, and then discounted to $31.5K.)
Tiffany concurred on paying this price.
CO for the EIS contract (Kaela Back) was briefed on the situation, and she is determining the legality of the vendor''s request for the compensation of these charges.
AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed.
10+ additional ATQs were requested by EPA and are being developed by the vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxq7002dkj72a7zsqk2p', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1767132000000, '12/29:
Funding:
PR in the amount of $3.5M to fund the contract through February 2026 was submitted to the FCO on 12/29/2025. (PR# is PR-OFA-26-00098.)
The funding action was approved by the SRO (via the SRO Approval process) and the CIO (via the EO Compliance Review process).
ATQs:
2 ATQs - for Starlink services and for the Firewall Support in the Office of the Administrator - were submitted to Contracts for processing.
Issues:
Two issues related to the costs of transition to the Next Generation Voice (NGV) -- (1) the costs of disconnecting 1,100 users who left under DRP and other restructuring actions and (2) the costs of returning the unneeded hard phones to the vendor -- are continued to be discussed with AT&T. The discussions are led by Tiffany and Lemont Phelps.
This mass disconnect of 1,100 lines carries the price tag of $97K, as per AT&T. Tiffany and Lemont are negotiating more favorable terms.
AT&T also argued that they cannot accept the phones that EPA no longer needs. Eventually, they relaxed their stance but the process and the cost of the phone returns are still being developed.
10+ additional ATQs were requested by EPA and are being developed by the vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxqe002fkj72s8efbrch', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1763503200000, '11/18:
Funding:
Contract is funded through 12/31/2025.
COR submitted request for additional funding for the month of January and beyond to Garrett on 11/17/2025.
ATQs:
1 ATQ - for Starlink services - is being processed by the COR.
It will require the base EIS contract modification with GSA to be modified before EPA can modify our EIS task order and add these services. The vendor is currently working with GSA to modify the base contract.
Starlink procurement seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time.
1 ATQ - for mass disconnect of 1,100 phone lines - is under review by EOD
This mass disconnect carries the price tag of $97K that was not seemingly accounted for by EOD previously. EOD is deliberating on how to proceed with this project.
10 additional ATQs were requested from the vendor and are being developed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763424000000, 1763424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxqk002hkj7291c1ch2n', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1762293600000, '11/03:
Funding:
Contract mod with incremental funding of $1,000,000 (to cover invoices through December 2025) and eight ATQs is with ITAD for processing.
The mod is waiting for the final signoff by the CO; it was already countersigned by the vendor.
ATQs:
1 ATQ - for Starlink services - is was processed by the COR.
It will require the base EIS contract modification with GSA to be modified before EPA can modify our EIS task order and add these services. The vendor is currently working with GSA to modify the base contract.
Starlink procurement seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time.
7 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxqq002jkj72c5l0me7h', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1761080400000, '10/21:
Funding:
Contract was extended for Option Period 4 (10/18/2025 - 10/17/2026), and funded in the amount of $1.5M. This funding will last through approximately end of November 2025.
PR for additional incremental funding of $1M was prepared and submitted to the FCO for commitment on 10/21/2025. The funding action was approved by all necessary parties.
Once obligated, this funding will fund the contract through the end of December 2025.
ATQs:
9 ATQs were processed by the COR and submitted to ITAD to be added to the contract.
1 ATQ is under technical review by EOD.
1 ATQ - for Starlink equipment - was submitted by the vendor and approved by the technical SMEs, but it seems to be unaccounted for in the WCF budget for FY26. COR referred this situation to the WCF accountants, and is awaiting for further instructions at this time.
14 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxqw002lkj720nyd6h9s', 'cmpx2emsj0001788vfgr7eaal', 'cmoudozbe000090udqjfuddj7', NULL, NULL, 1759870800000, '10/07:
Funding:
Current period of performance will end on 10/17/2025
COR and the WCF accountants secured the incremental funding of $1.5M to exercise the next period of performance (Option Period 4).
EO Compliance Review approval and the SRO Approval for this funding action were obtained.
As of this writing (3 p.m. on 10/07/2025), WCF is waiting for the Office of Budget to release the WR forward funds. Once released, these funds will be used to fund this action.
WR forward funds are expected to be released as early as 10/08/2025.
FCO will commit the funds and the CO will obligate the funds as soon as they are available.
ATQs:
Multiple ATQs are being processed by the COR and the CO and will be added to the contract through the mod.
9 additional ATQs are being developed by EOD and the vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxri002okj72hkukv47x', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1780434000000, '06/01:
Exercise Option Period 2
COR notified CO of intent to exercise Option Period 2 on 6/1/2026
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only.  Completed (Sat) May 30, 2026
eBusiness Enhancements
#20216 - Enhanced Search - Search all collections
#20167 - Exception Report for Account CPIC Specific IT Code vs Funding Profile:  COR to set up meeting with requestor to discuss requirements
#20181 - PR Module: Modify PR proportional buttons on IT Distribution Tab to Prevent Variances by Tower:  Meeting set up (6/10 with requestor to discuss requirements
Snow API (Status)
EISDSUPT Orders/Deprovisions: This will be deployed in the 10.02 release
Orders Payload for IPL Basic and IPL Core - Testing in DEV environment in-process, SNOW was put on-hold 05/21.
508 Compliance:
Rico Grids currently being re-written with Sencha EXTJS Infinite Grid
Mobile Device Refresh – As of early this afternoon, 19 people still need to sign their acknowledgement form. Leidos has been assisting the MD Support team with device refresh questions. 1,910 registrations have been updated with new device information to date.
Workflow request for SRO and facilities approval of location moves
eBusiness  has provided LOE and estimate to Facilities, awaiting decision.
Cross Charging Enhancement Proposal – A meeting has been scheduled for June 4th to further discuss EPA’s proposal of the requirement.
Workflow change request from Deputy CIO to change remote location selection.
Willie reviewed proposed solution with Deputy CIO.  eBusiness team is waiting for further direction.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxro002qkj72jxw97sbh', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1778014800000, '05/04:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only.  Target release date (Sat) May 30, 2026 – Testing underway
eBusiness Enhancements
#20216 - Enhanced Search - Search all collections
#20167 - Exception Report for Account CPIC Specific IT Code vs Funding Profile
#20181 - PR Module: Modify PR proportional buttons on IT Distribution Tab to Prevent Variances by Tower
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Mobile Device Refresh – As of early this 4/30/26, 28 people still need to sign their acknowledgement form. Leidos has been assisting the MD Support team with device refresh questions. 1,379 registrations have been updated with new device information to date.
Workflow request for SRO and facilities approval of location moves
COR to review proposed cost with Section Manager
Cross Charging Enhancement Proposal – A meeting has been scheduled for May 19 to further discuss EPA’s proposal of the requirement', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxru002skj726dec7m67', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1776805200000, '04/21:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s).
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxvw003ikj72nl4b7wan', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1781643600000, '06/16: No update from GSA. Funding for OP3 approved. COR submitted for EO Compliance Review and waiting on approval to submit for SRO approval. Waiting for OCPO to confirm if ITOD should include IA fees in funding package.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxw1003kkj72maonkw1g', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1780434000000, '06/02: No changes. No update from GSA. Funding for OP3 approved, and COR will begin process of submitting for EO Compliance Review/SRO approval. Waiting for OCPO to confirm if ITOD should include IA fees in funding package.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780358400000, 1780358400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxw5003mkj72dha44f4o', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1779224400000, '05/19: No changes. No update from GSA. Funding for OP3 approved, and COR will begin process of submitting for EO Compliance Review/SRO approval.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxw9003okj72h0vcc4lp', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1778014800000, '05/05: COR has confirmed all details with GSA, and GSA COR Designation letter has been signed. GSA SF-30 notifying Esri of transfer to GSA has not gone out.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxwf003qkj72llu7vvpd', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1776805200000, '04/21: Contract transferred to GSA. EPA SF-30 notifying Esri of transfer to GSA sent out 03/31. COR working with GSA/Esri to confirm details for GSA SF-30 to go out.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxwi003skj72foe78jzh', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1774386000000, '03/24: Contract moving to GSA, scheduled for 04/02.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxwm003ukj72qay69h7b', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1761080400000, '10/21: No updates until next option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxwq003wkj72zck79unl', 'import-garrett-hayes', 'import-contract-e400ff653596ab4df65250ad', NULL, NULL, 1759870800000, '10/07: Option Period awarded.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxxb003zkj72bmdjna8b', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1780434000000, '06/02:
No operational updates.
Current EMDC call order was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/02/2026.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780358400000, 1780358400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxxh0041kj729bl6z4nl', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1775595600000, '04/06/2026 - Funding for the follow-up call order was approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775433600000, 1775433600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxxm0043kj72le1dxw3c', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1776805200000, '04/10/2026 - PR - with funding - was submitted to CFAIAD (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxxt0045kj72huu5iu6t', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1776805200000, '04/20/2026 - CFAIAD advised that they will want to extend the current call order by six months (i.e., till 12/31/2026), and award the new call order from 01/01/2027.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxxz0047kj7246xcamd4', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1778014800000, '04/23/2026 - COR updated the LSJ in accordance with the CO guidance.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxy50049kj72mgprir96', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxyb004bkj722f6lmftb', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1779224400000, '05/20:
No operational updates.
Current EMDC call order is scheduled to end on 06/30/2026. COR is developing the continuation of the call order along the two parallel tracks:
Six-month Extension of the current call order - to be processed by 06/30/2026:
At the recommendation of the CO, the current call order will be extended for six months (07/01/2026 - 12/31/2026), in order to allow for ample time to develop the follow-on call order.
The funded PR for the extension was submitted to the CO on 05/08/2026.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxyh004dkj72ct4ipf9y', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxym004fkj72urboaihv', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1778014800000, '05/04:
No operational updates.
Current EMDC call order is scheduled to end on 06/30/2026. COR is developing the continuation of the call order along the two parallel tracks:
Six-month Extension of the current call order - to be processed by 06/30/2026:
At the recommendation of the CO, the current call order will be extended for six months (07/01/2026 - 12/31/2026), in order to allow for ample time to develop the follow-on call order.
COR already secured the CGER approval for the funding of the extension.
Once the funding availability is confirmed by the ITSB Director in early May, COR will submit the PR in EAS.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxyt004hkj72y1iv6ty5', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1778014800000, '05/04/2026 - At present, pending feedback and further guidance from the CO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxyy004jkj724k8f5s50', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1778014800000, '04/23:
No operational updates.
PR for the follow-up call order was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxz4004lkj72ufyltb6h', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1776805200000, '04/10/2026 - PR was submitted (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxza004nkj72ofz1lawn', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1778014800000, '04/23/2026 - COR requested approval for funding for the extension.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxzf004pkj72lg8txx3o', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1775595600000, '04/08:
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
SOW and IGCE were developed by the COR and vetted by Scott Baker''s group.
Funding for the call order was secured on 04/06/2026, and the EO Compliance Review will be submitted for approval this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxzk004rkj720p4kncts', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1775595600000, '03/27:
New CO was appointed to the contract: Pamela Kuykendall
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with AT&T  ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774569600000, 1774569600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxzq004tkj7259av8plo', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1773176400000, '02/27:
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with AT&T  ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvxzx004vkj722s9fba11', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1770760800000, '02/10:
EMDC call order for AT&T services was awarded on 01/28/2026, and the performance began on 02/01/2026.
Period of Performance - February-June 2026
Call order is currently funded through March.
Additional funding for April-June was approved on 01/20/2026. COR is preparing the funding PR.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with AT&T  ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy02004xkj72sdvqnu4g', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1770760800000, '01/29:
This legacy contract with AT&T will end on 01/31/2026.
The EMDC BPA with AT&T was signed on 01/15/2026, and the call order for five months of performance (Feb-Jun 2026) was enacted on 01/28/2026.
As of 02/01/2026, AT&T''s mobile services will transfer to the EMDC contract.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy08004zkj72whviaf0q', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1767132000000, '12/29:
Contract was extended through 01/31/2026:
The EMDC BPAs with all three carriers (AT&T, Verizon Wireless, and T-Mobile) are expected to be signed by 12/31/2025, with the first call orders expected to be awarded by 01/31/2026. (The first call orders with AT&T and Verizon will be awarded for five months, i.e. through 06/30/206, so as to align them to the end date of the T-Mobile legacy contract; no call order with T-Mobile will be established at this time and we will continue using the legacy contract for this carrier. By 07/01/2026, the second set of call orders will be established with all three carriers, and all mobile operations will switch to be performed fully under EMDC.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy0c0051kj720a3yzxvx', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1763503200000, '11/18:
Contract was extended through 12/31/2025:
No additional updates at this time.
If the EMDC contract is awarded by 12/31/2025, this contract will end at the end of December 2025. Otherwise, HQAD will have to make a decision to extend this contract for an additional period.
COR inquired about HQAD''s contingency plans in case of delays with EMDC, but was told that it was too soon to discuss such plans.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763424000000, 1763424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy0i0053kj72b7st51q3', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1762293600000, '11/03:
Contract was extended through 12/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extensions and funding through 12/31/2025 were fully processed and applied to the contract.
HQAD is still committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
Revised FITARA request was approved by the CIO on 10/22/2025.
RFQ for the EMDC procurement was issued to the industry on 10/30/2025.
HQAD is working to secure three BPAs with all three major carriers (AT&T, T-Mobile, Verizon Wireless).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy0o0055kj72nw0l4zqv', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1761080400000, '10/21:
Contract was extended through 10/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extension through 10/30/2025 was fully executed
Extension for 11/01/2025-11/30/2025 was funded, and the PR was submitted to ITAD for processing.
Extension for 12/01/2025-12/31/2025 was also funded separately, and the PR was submitted to ITAD for processing.
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
On 10/16/2025, HQAD acknowledged that they have the necessary paperwork (PWS, etc.) to begin the procurement process.
HQAD plans to release the solicitation to the industry by the end of October.
Revised FITARA request is pending for the CIO''s approval. (It was recommended for approval by all necessary parties, including the CTO.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy0t0057kj72gk9310uv', 'import-jake-beja', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1759870800000, '10/07:
Contract was extended through 10/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extension through 10/30/2025 was fully executed
Extension for 11/01/2025-11/30/2025 is being processed. WCF accountants approved the funding for it.
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
OITO delivered draft SOW and IGCE to HQAD''s Scott Tharp on 08/11/2025.
HQAD issued the RFI, and received several responses from the industry on 08/25/2025.
OITO analyzed the responses and submitted the analysis to HQAD on 09/03/2025.
On 09/09/2025, based on the RFI response analysis, HQAD and OITO agreed to pivot the EMDC procurement from the managed contract to the carrier-specific contracts, in order to minimize the Agency''s spending on mobile services. The new PWS is due to HQAD by around 09/23/2025.
OITO delivered the revised draft SOW to HQAD on 09/17/2025. HQAD staff are currently reviewing the document.
COR is working with HQAD on making additional revisions to the PWS, as well as pending for approval of the revised FITARA request.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1a005akj72pafn6u9x', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1781643600000, '06/09:
No operational updates.
Current EMDC call order was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780963200000, 1780963200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1d005ckj721llqm5uk', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1775595600000, '04/06/2026 - Funding for the follow-up call order was approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775433600000, 1775433600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1j005ekj72yllrld9p', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1776805200000, '04/10/2026 - PR - with funding - was submitted to CFAIAD (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1n005gkj7282lwo8yq', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1776805200000, '04/20/2026 - CFAIAD advised that they will want to extend the current call order by six months (i.e., till 12/31/2026), and award the new call order from 01/01/2027.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1r005ikj72899mhij3', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1778014800000, '04/23/2026 - COR updated the LSJ in accordance with the CO guidance.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy1w005kkj727txoal9h', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy21005mkj72zayua0lw', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1748984400000, '06/03:
No operational updates.
Current EMDC call order is to be extended for additional six months of performance (07/01/2026 - 12/31/2026)
CO sent the draft contract mod with the extension to the vendor for signature on 06/01/2026.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1748908800000, 1748908800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy26005okj72rnku6d0r', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy2b005qkj72a83xda30', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1779224400000, '05/20:
No operational updates.
Current EMDC call order is scheduled to end on 06/30/2026. COR is developing the continuation of the call order along the two parallel tracks:
Six-month Extension of the current call order - to be processed by 06/30/2026:
At the recommendation of the CO, the current call order will be extended for six months (07/01/2026 - 12/31/2026), in order to allow for ample time to develop the follow-on call order.
The funded PR for the extension was submitted to the CO on 05/13/2026.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy2i005skj72wolwo0at', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1778014800000, '05/04:
No operational updates.
Current EMDC call order is scheduled to end on 06/30/2026. COR is developing the continuation of the call order along the two parallel tracks:
Six-month Extension of the current call order - to be processed by 06/30/2026:
At the recommendation of the CO, the current call order will be extended for six months (07/01/2026 - 12/31/2026), in order to allow for ample time to develop the follow-on call order.
COR already secured the CGER approval for the funding of the extension.
Once the funding availability is confirmed by the ITSB Director in early May, COR will submit the PR in EAS.
Follow-up Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy2o005ukj728hyzrz25', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1778014800000, '05/04/2026 - At present, pending feedback and further guidance from the CO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy2s005wkj72s8g4hqds', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1778014800000, '04/23:
No operational updates.
PR for the follow-up call order was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy2y005ykj720a6jlgvy', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1776805200000, '04/10/2026 - PR was submitted (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy330060kj7202s9kc21', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1778014800000, '04/23/2026 - COR requested approval for funding for the extension.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy3a0062kj72vln656ei', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1775595600000, '04/08:
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
SOW and IGCE were developed by the COR and vetted by Scott Baker''s group.
Funding for the call order was secured on 04/06/2026, and the EO Compliance Review will be submitted for approval this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy3g0064kj72ctxfm6vy', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1775595600000, '03/27:
New CO was appointed to the contract: Pamela Kuykendall
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with Verizon Wireless  ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774569600000, 1774569600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy3n0066kj72uj6k8xbl', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1773176400000, '02/27:
No operational updates.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with Verizon  ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy3t0068kj72gj6786kg', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1770760800000, '02/10:
EMDC call order for Verizon Wireless services was awarded on 01/29/2026, and the performance began on 02/01/2026.
Period of Performance - February-June 2026
Call order is currently funded through March.
Additional funding for April-June was approved on 01/20/2026. COR is preparing the funding PR.
Follow-up call order for July 2026 and beyond is being developed by the COR.
This legacy contract with Verizon Wireless ended on 01/31/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy40006akj72lmbvvbxv', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1770760800000, '01/29:
This legacy contract with Verizon is expected to end on 01/31/2026.
The EMDC BPA with AT&T was signed on 01/15/2026, and the call order for five months of performance (Feb-Jun 2026) is expected to be enacted on 01/29/2026.
Verizon submitted their proposal for the call order on 01/26, and revised their proposal after a series of conversations with the COR and the Contract Specialist on 01/28.
COR reviewed the proposal, and submitted the evaluation to the Contract Specialist on 01/28.
Call order is expected to be awarded today (01/29).
As of 02/01/2026, Verizon''s mobile services are expected to transfer to the EMDC contract.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy47006ckj72ec1tupo1', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1767132000000, '12/29:
Contract was extended through 01/31/2026:
The EMDC BPAs with all three carriers (AT&T, Verizon Wireless, and T-Mobile) are expected to be signed by 12/31/2025, with the first call orders expected to be awarded by 01/31/2026. (The first call orders with AT&T and Verizon will be awarded for five months, i.e. through 06/30/206, so as to align them to the end date of the T-Mobile legacy contract; no call order with T-Mobile will be established at this time and we will continue using the legacy contract for this carrier. By 07/01/2026, the second set of call orders will be established with all three carriers, and all mobile operations will switch to be performed fully under EMDC.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy4e006ekj72w6umsw0p', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1763503200000, '11/18:
Contract was extended through 12/31/2025:
No additional updates at this time.
If the EMDC contract is awarded by 12/31/2025, this contract will end at the end of December 2025. Otherwise, HQAD will have to make a decision to extend this contract for an additional period.
COR inquired about HQAD''s contingency plans in case of delays with EMDC, but was told that it was too soon to discuss such plans.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763424000000, 1763424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy4l006gkj72w8koifps', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1762293600000, '11/03:
Contract was extended through 12/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extensions and funding through 12/31/2025 were fully processed and applied to the contract.
HQAD is still committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
Revised FITARA request was approved by the CIO on 10/22/2025.
RFQ for the EMDC procurement was issued to the industry on 10/30/2025.
HQAD is working to secure three BPAs with all three major carriers (AT&T, T-Mobile, Verizon Wireless).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy4r006ikj72c76cl2hj', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1761080400000, '10/21:
Contract was extended through 10/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extension through 10/30/2025 was fully executed.
Extension for 11/01/2025-11/30/2025 was funded, and the PR was submitted to ITAD for processing.
Extension for 12/01/2025-12/31/2025 was also funded separately, and the PR was submitted to ITAD for processing.
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
On 10/16/2025, HQAD acknowledged that they have the necessary paperwork (PWS, etc.) to begin the procurement process.
HQAD plans to release the solicitation to the industry by the end of October.
Revised FITARA request is pending for the CIO''s approval. (It was recommended for approval by all necessary parties, including the CTO.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy4x006kkj72gbpmfptw', 'import-jake-beja', 'import-contract-1175226adce593ff68fdde37', NULL, NULL, 1759870800000, '10/07:
Contract was extended through 10/31/2025:
This legacy contract was extended for up to 5 months (2-month base period, plus 3 one-month option periods). It is now scheduled to expire on 12/31/2025.
Extension through 10/30/2025 was fully executed
Extension for 11/01/2025-11/30/2025 is being processed. WCF accountants approved the funding for it.
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
OITO delivered draft SOW and IGCE to HQAD''s Scott Tharp on 08/11/2025.
HQAD issued the RFI, and received several responses from the industry on 08/25/2025.
OITO analyzed the responses and submitted the analysis to HQAD on 09/03/2025.
On 09/09/2025, based on the RFI response analysis, HQAD and OITO agreed to pivot the EMDC procurement from the managed contract to the carrier-specific contracts, in order to minimize the Agency''s spending on mobile services. The new PWS is due to HQAD by around 09/23/2025.
OITO delivered the revised draft SOW to HQAD on 09/17/2025. HQAD staff are currently reviewing the document.
COR is working with HQAD on making additional revisions to the PWS, as well as pending for approval of the revised FITARA request.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy5m006nkj72tr7oz6g1', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1780434000000, '06/03:
No operational updates.
PR for the EMDC call order was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780444800000, 1780444800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy5r006pkj72nw1mbm2x', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1775595600000, '04/06/2026 - Funding for the follow-up call order was approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775433600000, 1775433600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy5w006rkj72gljoxslp', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1776805200000, '04/13/2026 - PR was submitted (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776038400000, 1776038400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy60006tkj7243g2dq6e', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1776805200000, '04/20/2026 - CFAIAD advised that they will want to extend the legacy contract by six months (i.e., till 12/31/2026), and award the new call order from 01/01/2027. (See "Mobile - T-Mobile (Legacy Contract)" for additional updates on the six-month extension.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy66006vkj72fqblvxzm', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1778014800000, '04/23/2026 - COR updated the LSJ in accordance with the CO guidance.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy6a006xkj72wjn13jd6', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy6e006zkj72cbv0xmvc', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1779224400000, '05/20:
No operational updates.
PR for the EMDC call order was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy6l0071kj72m6agg8ob', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy6s0073kj72ecpxicop', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1778014800000, '05/04:
No operational updates.
PR for the EMDC call order was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy6x0075kj72pkwgolak', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1778014800000, '05/04/2026 - At present, pending feedback and further guidance from the CO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy730077kj724j5rxg46', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1775595600000, '04/08:
No operational updates; T-Mobile services are still provided under the legacy T-Mobile contract till 06/30/2026.
First call order for T-Mobile under EMDC is being developed by the COR and will start on 07/01/2026.
SOW and IGCE were developed by the COR and vetted by Scott Baker''s group.
Funding for the call order was secured on 04/06/2026, and the EO Compliance Review will be submitted for approval this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy770079kj72x5i17j3g', 'import-jake-beja', 'import-contract-d029e826a7d7aa31c028b829', NULL, NULL, 1775595600000, '03/27:
New CO was appointed to the contract: Pamela Kuykendall
No operational updates; T-Mobile services are still provided under the legacy T-Mobile contract till 06/30/2026.
First call order for T-Mobile under EMDC is being developed by the COR and will start on 07/01/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774569600000, 1774569600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy7n007ckj72rqycb6ks', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1781643600000, '06/10:
Legacy contract was extended for additional six months of performance (07/01/2026 - 12/31/2026) on 06/09/2026.
Follow-up EMDC Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781049600000, 1781049600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy7r007ekj72165evfvc', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1775595600000, '04/06/2026 - Funding for the follow-up call order was approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775433600000, 1775433600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy7v007gkj7228rwp32m', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1776805200000, '04/10/2026 - PR - with funding - was submitted (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy80007ikj72jn53y7mo', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1776805200000, '04/20/2026 - CFAIAD advised that they will want to extend the current call order by six months (i.e., till 12/31/2026), and award the new call order from 01/01/2027.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy85007kkj72sr0mwoyt', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1778014800000, '04/23/2026 - COR updated the LSJ in accordance with the CO guidance.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy8a007mkj72h1eki3eo', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy8g007okj72ezcnhnxm', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1748984400000, '06/03:
This legacy contract with T-Mobile is scheduled to end on 06/30/2026. COR is developing the continuation of the T-Mobile support  along the two parallel tracks:
Legacy contract is to be extended for additional six months of performance (07/01/2026 - 12/31/2026)
CO sent the draft contract mod with the extension to the vendor for signature on 06/03/2026.
Follow-up EMDC Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1748908800000, 1748908800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy8m007qkj72qmusve7b', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1779224400000, '05/20/2026 - COR and CO determined that previously committed funding would not be obligated by Sep 30.
The funding (i.e., FY26 dollars) was decommitted while keeping the PRs open. The funding will be committed anew in October using FY27 dollars.
CO acknowledged that she will proceed with the award of the call order without waiting for funding.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy8q007skj72u7fp7du6', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1779224400000, '05/20:
This legacy contract with T-Mobile is scheduled to end on 06/30/2026. COR is developing the continuation of the T-Mobile support  along the two parallel tracks:
Legacy contract is to be extended for additional six months of performance (07/01/2026 - 12/31/2026)
Follow-up EMDC Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779235200000, 1779235200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy8x007ukj72mauq12sb', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1778014800000, '05/04:
This legacy contract with T-Mobile is scheduled to end on 06/30/2026. COR is developing the continuation of the T-Mobile support  along the two parallel tracks:
Six-month Extension of this legacy contract - to be processed by 06/30/2026:
At the recommendation of the CO, the legacy contract will be extended for six months (07/01/2026 - 12/31/2026), in order to allow for ample time to develop the follow-on EMDC call order with T-Mobile.
COR already secured the CGER approval for the funding of the extension.
Once the funding availability is confirmed by the ITSB Director in early May, COR will submit the PR in EAS.
Follow-up EMDC Call Order - to be awarded by 12/31/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy93007wkj72y0iumxch', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1778014800000, '05/04/2026 - At present, pending feedback and further guidance from the CO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy98007ykj72z6pvdihx', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1778014800000, '04/23:
No operational updates.
PR for the EMDC call order ( = follow-up to this contract) was submitted to CFAIAD:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy9e0080kj72x8eh3inr', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1776805200000, '04/10/2026 - PR was submitted (the date was in line with February''s guidance from HQAD).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy9j0082kj72kakrfcga', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1776805200000, '04/20/2026 - CFAIAD advised that they will want to extend this legacy contract by six months (i.e., till 12/31/2026), and award the new call order from 01/01/2027.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy9m0084kj72mgjojief', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1778014800000, '04/23/2026 - COR requested approval for funding for the extension.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy9r0086kj72e6748c3b', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1775595600000, '04/08:
No operational updates.
Additional incremental funding of $225,000 was approved on 04/06/2026, and the PR will be submitted to the CO for processing shortly.
The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775606400000, 1775606400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvy9y0088kj723y9nf3qx', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1775595600000, '03/31:
No operational updates.
Additional incremental funding of $225,000 is required to fully fund the contract through the end of its PoP (on 06/30/2026). The funding request was submitted to Garrett for managerial review.
The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774915200000, 1774915200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvya3008akj720qn9iigc', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1773176400000, '02/27:
The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026
The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026, and the COR started work on the procurement package.
Incremental funding of $350,000 for the T-Mobile legacy contract was approved and submitted to the CO on 02/26/2026. The funding will be sufficient to cover the contract''s operating expenses through April 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvya8008ckj72h3mxtnbh', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1770760800000, '02/10:
The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026
The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026.
T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.
Additional incremental funding of $350,000.00 was approved by the ITSB Director on 01/20/2026, and the COR is preparing the funding documentation.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyad008ekj72ln4rznd7', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1770760800000, '01/29:
The EMDC BPA with T-Mobile was signed on 01/15/2026. It will sit dormant until the end of the legacy contract with the carrier.
Previously, HQAD (Scott Tharpe) and ITOD decided to "run out" the legacy contract with T-Mobile until its expiration date on 06/30/2026
The first EMDC call order with T-Mobile is expected to be enacted by 07/01/2026.
T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.
Additional incremental funding of $350,000.00 was approved by the ITSB Director on 01/20/2026, and the COR is preparing the funding documentation.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyai008gkj72a1b7jmu3', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1767132000000, '12/29:
HQAD (Scott Tharpe) and ITOD decided to "run out" this contract until its expiration date on 06/30/2026
The EMDC BPAs with all three carriers (AT&T, Verizon Wireless, and T-Mobile) are expected to be signed by 12/31/2025, with the first call orders expected to be awarded by 01/31/2026.
HQAD/Scott Tharpe and ITOD held a discussion on 12/16/2025, and Scott recommended to continue using the legacy T-Mobile contract until its end date of 06/30/2026.
The first call orders with AT&T and Verizon will be awarded for five months, i.e. through 06/30/206 as well, so as to align them to the end date of the T-Mobile legacy contract.
By 07/01/2026, the second set of call orders will be established with all three carriers, and all mobile operations will switch to be performed fully under EMDC.
T-Mobile legacy contract was incrementally funded in the amount of $350,000.00. The funding is sufficient to cover the contract''s operating expenses through February 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyan008ikj72cwuwycxm', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1763503200000, '11/18:
T-Priority services ( = alternative to AT&T''s FirstNet) was added to the contract via a contract modification, and the service is now orderable.
After the award of the EMDC contract, HQAD is planning to terminate this contract early ( = before its scheduled expiration date of 06/30/2026).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763424000000, 1763424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyat008kkj72ly8gx2cv', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1762293600000, '11/03:
Incremental funding of $275,000 was added to the contract. It will cover the contract expenses through December 2025.
PR to add the T-Priority services to the scope of the contract and incrementally fund their performance in the amount of $25,000 was submitted to ITAD on 10/31/2025.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyaz008mkj723ufb3uvz', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1761080400000, '10/21:
Incremental funding of $275,000 was approved by all required parties, and the PR was submitted to the FCO for funds commitment on 10/20/2025. Once obligated, the funding will fund the contract through the end of December 2025.
COR is developing the necessary paperwork to modify the contract''s scope and add the T-Priority requirement that was requested by Scott Baker.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyb5008okj728n2owdbe', 'import-jake-beja', 'import-contract-a809fd21f697d457ab18ec72', NULL, NULL, 1759870800000, '10/07:
Scott Baker approved the vendor''s technical proposal to add T-Priority to the current contract. The COR will work with the Contracts Office to modify the contract.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvybs008rkj72rot19mv8', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1776805200000, '4/11.  Journeyman Software Analyst – 1 FTE to ESSET contract request was withdrawn/not approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775865600000, 1775865600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvybx008tkj728ur4y9jq', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1750194000000, '6/17.  EUSD request for VTC in RTP N-227', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1750118400000, 1750118400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyc1008vkj72rf42cg9i', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1723582800000, '8/12.  EUSD request for Nutanix nodes in service VDI - approved 8/28', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1723420800000, 1723420800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyc6008xkj72ulmuew9r', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1693342800000, '8/26.  No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1693008000000, 1693008000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyca008zkj72ieakggal', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1663102800000, '9/12.  No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1662940800000, 1662940800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvycf0091kj72wrc9gixt', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1632862800000, '9/24.  RTP SCIF', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1632441600000, 1632441600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvycj0093kj72ue70f7jy', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1602622800000, '10/8.  No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1602115200000, 1602115200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyco0095kj72y86rw16n', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1573596000000, '11/7.  No change.
FY25 WCF Budget Updates
Tuesday, July 16, 2024
3:23 PM
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1573084800000, 1573084800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyct0097kj72gr3x5ctb', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1548194400000, 'Update 1/16.
The internal FY25 budget schedule was reviewed with OITO leadership
Requests for FY25 input was distributed to all service owners with a 1st submission due date pf 1/26/24.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1547596800000, 1547596800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvycx0099kj724dlajvpg', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1517954400000, 'Update 1/31. Received submissions from several offices. Consolidating a draft memo for the Director''s review on 2/2.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1517356800000, 1517356800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyd2009bkj72ub7eh0bq', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1487714400000, 'Update 2/13. Held several follow-up meetings with the Operation teams and made final Director updates.  The draft memo will be submitted to the OITO Office Director on 2/14/24 for her review before being submitted to the CIO on 2/23/24.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1486944000000, 1486944000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyd7009dkj72s4k9x2p1', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1457474400000, 'Update 2/27. The budget draft memo was reviewed and edited by the OITO Office Director. After revisions were made, the  draft memo was submitted to the CIO on 2/27.  A courtesy copy was also sent to ORBO and the OMS Board Member.  We are waiting for CIO comments before making the final submission to OCFO on 3/5.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1456531200000, 1456531200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvydc009fkj72nwf65420', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1456264800000, 'Update 2/13. A follow-up meeting was held on 2/29 with the CIO to address questions.  All questions were resolved and the OITO Director signed of on the budget letter.  The FY25 budget letter was finalized and submitted to OCFO on 3/5.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1455321600000, 1455321600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvydh009hkj72ujw1uk2g', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1428440400000, 'Update 3/27. Prepared FY25 Budget Proposal excel summary (in lieu of ESC) and assisted ORBO in preparing the Single Payer slide deck for the Interim Board Meeting held 3/26/24.  Prepared FY25 Budget Proposal slide deck and distributed to Service Owners for review/revisions.  The presentation will be submitted to OCFO after approval from OITO Director. OCFO due date is n 4/1/24.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1427414400000, 1427414400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvydm009jkj72b1daaw88', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1398200400000, 'Update 4/11.  Presented FY25 Budget Proposal to the WCF Board and received Board approval on all service enhancements, planning base adjustments, FTE increases and capital requests.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1397174400000, 1397174400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvydq009lkj72omh986zc', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1366750800000, 'Update 4/24. Service owners are continuing to update the eBusiness budget module.  FMB working with eBusiness team to restore prior version of budget ledger report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1366761600000, 1366761600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvydu009nkj72nw3z7a3a', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1337720400000, 'Update 5/10. FMB Accountants are now reviewing the service owner submissions in eBusiness budget module and recommending changes based on actual YTD data and approved increases allowed from the April WCF Board meeting. Also, the eBusiness team instructed FMB on how to run prior version of budget ledger report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1336608000000, 1336608000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvye0009pkj72bgdb1den', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1306270800000, 'Update 5/21. FMB Accountants continue to update budget and enter missing data.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1305936000000, 1305936000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvye5009rkj72t52cldlx', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1276030800000, 'Update 6/4. First review meeting with OITO Director was held 6/3. The FMB Accountants are working with EUSD and EOD teams this week to collect answers to the Director''s questions and will update the FY25 draft budget for next review meeting.  The 2nd review meeting will be held 6/10  and the 1st review meeting with the CIO is scheduled for 6/17.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1275609600000, 1275609600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyeb009tkj72ywo4xyee', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1245790800000, 'Update 6/20.  Review meeting held with CIO on 6/17.  Several follow-up questions were asked but we were unable to get all responses by COB 6/20.  Requested a budget submission extension of early next week that was approved by OCFO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1245456000000, 1245456000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyeg009vkj721zknsr4s', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1215550800000, 'Update 7/2. Final revisions were made and the budget was submitted to OCFO on 7/1.  The transmittal letter is in draft with plans to finalize for signature by 7/5.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1214956800000, 1214956800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyek009xkj729ggjmle6', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1185310800000, 'Update 7/18. The transmittal letter was signed and submitted to OCFO on 7/8. OCFO returned questions on our budget submission and we responded on 7/15.  FY25 rates are being finalized this week for submission on 7/23.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1184716800000, 1184716800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyeo009zkj727bn47777', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1155070800000, 'Update 7/30. Budget rates were submitted to OCFO on 7/25. Preparing WCF Board slides for August presentation.  Will submit to OITO Director, CIO and ORBO management for review 7/31. Presentation is due to OCFO on 8/5.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1154217600000, 1154217600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyes00a1kj72y6ywcolm', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1124830800000, 'Update 8/13.  WCF Board slides were submitted to OCFO on 8/5 and presented to the CAG on 8/7 and the WCF Board on 8/13.  The Board approved the WCF DP Activity budget as submitted, with the exception of the FTE request from OA for service EK.  Although the FTE was not approved, we do not need to re-state budgets or rates.  Instead, the salary budgeted for EK can be used for contract labor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1123891200000, 1123891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyex00a3kj725r324jdx', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1094590800000, 'Update 8/27. Finalized FY25 rates and submitted file to OCFO for inclusion in the FY25 decision memorandum. Reviewed the draft memo and provided edits to ensure consistency.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1093564800000, 1093564800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyf200a5kj722n7ef020', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1063141200000, 'Update 9/3. Finalized FY25 rates and submitted file to OCFO for inclusion in the FY25 decision memorandum. Reviewed the draft memo and provided edits to ensure consistency.  Sent our final certification acknowledgement to SIOs on 9/3 with responses due 9/6.  Forward funding for FY25 should start on or around 9/9.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1062547200000, 1062547200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyf600a7kj72l2jybf4g', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1031691600000, 'Update 9/11. The SIO and IRMBC FY 2025 certified workload reports were distributed and we requested they review and confirm their organizations FY 2025 WCF orders.  Significant adjustments were not communicated, therefore the FY25 rates remain as published.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1031702400000, 1031702400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfc00a9kj72v8o8cf09', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 1001451600000, 'Update 9/26. No changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1001462400000, 1001462400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfh00abkj72o9e2vr0y', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 971211600000, 'Update 10/10.  We began the FY with $71.3M in forward funding and currently working with program offices funding all major contracts thru Feb 2025.  Our customers have been instructed to fund their agreements to the 22% level so our next wave of funding will come November 1st.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 971136000000, 971136000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfm00adkj72i7wke54l', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 940971600000, 'Update 10/23.  The FY25 Budget (or excerpt) have been distributed to the OITO Division Directors, GDIT and ESSET vendors. The PPL workcodes have been updated to reflect FY25 staff allocations.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 940636800000, 940636800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfq00afkj72v4s9oxwm', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 910735200000, 'Update 11/6. In an effort, to provide real-time data to the DP Activity Sponsored services, FMB has developed a new status of fund CBOR query report. This report will be sent on a monthly basis and indicates the funding authority that they have available for obligation. We hope this will encourage Sponsored services to be more responsive to our PR planning inquiries. See example of report below.
<<Copy of OISPx3A YW SOF.xlsx>>', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 910310400000, 910310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfu00ahkj72f1swy021', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 880495200000, 'Update 11/19. BA''s and PC''s FY25 cost recovery models are under review as new FY25 service/product costs are being added (increase in: Salesforce license costs, Adobe costs, and Qualtrics). UH''s preliminary FY25 cost recovery model shows UH ending the year with a profit. The accountant''s monthly variance report is used to track actual cost recovery. UH task force meetings (EOD, LEIDOS, WCFD) are scheduled monthly to review/learn actual cost recovery and identify issues.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 879897600000, 879897600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyfz00ajkj72hltwflvf', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 850255200000, 'Update 12/3.  The WCF DP Board slides were submitted to OCFO and will be presented at the CAG on 12/4 and next week at the Board on 12/11.  We will brief the FYE24 financial summary and ordering performance and also introduce several on the horizon topics for the FY26 budget season.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 849571200000, 849571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyg300alkj72fbtsb4ib', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 820015200000, 'Update 12/18.  Preparing the internal budget schedule for the FY26 budget cycle. This schedule will be submitted to the OITO Director and Deputy Director for approval before distribution to the Division Directors. (estimated 1st week of January)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 819244800000, 819244800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyg700ankj72nui0f053', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 789775200000, 'Update 12/31.  Preparing the internal budget schedule for the FY26 budget cycle. This schedule will be submitted to the OITO Director and Deputy Director for approval before distribution to the Division Directors on 1/8.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 788832000000, 788832000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygd00apkj72xhwj8qn1', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 759535200000, 'Update 1/17. December NOR was finalized on 1/15. DP has a 0.89% profit on $86.7M revenue. No real concerns with the larger profits/losses. We were very conservative with the UH revenue accrual but confidant that we are on a path to break-even.  Also, we will touch base with the sponsored services below to ensure they have plans to spend budgets as intended.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DI
eDiscovery Services
$6,311,834.26
$2,130,425.19
$2,617,118.67
($486,693.48)
(22.84%)
DS
Desktop Subscriptions
$3,365,684.78
$869,325.60
$602,668.57
$266,657.03
30.67%
DV
Data Analytics Platform Service
$1,917,567.85
$494,946.78
$293,058.07
$201,888.71
40.79%
UH
Application Hosting
$34,236,603.46
$9,370,828.59
$10,338,653.36
($967,824.77)
(10.33%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 758764800000, 758764800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygh00arkj7228kx7ioo', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 729295200000, 'Update 2/3. No changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 728697600000, 728697600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygl00atkj72rl539h6z', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 697845600000, 'Update 2/11. No changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 697766400000, 697766400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygp00avkj72mm834zp6', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 667605600000, 'Update 2/26. January NOR was finalized on 2/13. DP has a 2.02% profit on $115.9M revenue. No real concerns with the larger profits/losses. We were conservative with the UH revenue accrual but confidant that we are on a path to break-even.  Also, we will touch base with the sponsored services below to ensure they have plans to spend budgets as intended.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DS
Desktop Subscriptions
$3,365,684.78
$1,161,051.76
$767,027.72
$394,024.04
33.94%
DV
Data Analytics Platform Service
$1,917,567.85
$659,929.04
$433,056.15
$226,872.89
34.38%
EK
Correspondence Management System
$1,278,122.59
$426,040.96
$331,802.27
$94,238.69
22.12%
UH
Application Hosting
$34,236,603.46
$13,167,036.87
$14,142,261.40
($975,224.53)
(7.41%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 667526400000, 667526400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygu00axkj72yl5dv9pp', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 637365600000, 'Update 3/11. No changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 637113600000, 637113600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvygy00azkj72x8yuh7rr', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 607125600000, 'Update 3/25. February NOR was finalized on 3/13. DP has a 1.09% profit on $160M revenue. We have researched more detail of the UH loss and have identified that the Prior Year UH revenue accrual for two external products is causing the loss. We will set up a meeting with OISP and ISSS to understand their cost recovery model and billing methodology.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DV
Data Analytics Platform Service
$1,917,567.85
$824,911.30
$595,604.99
$229,306.31
27.80%
EK
Correspondence Management System
$1,278,122.59
$532,551.20
$432,240.41
$100,310.79
18.84%
UH
Application Hosting
$34,236,603.46
$15,937,312.59
$17,522,545.25
($1,585,232.66)
(9.95%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 606787200000, 606787200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyh200b1kj72kdh7id0m', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 576882000000, 'Update 4/11.  March NOR was finalized on 4/11. DP has a 0.93% profit on $183M revenue. We have researched more detail of the UH loss and have identified that the Prior Year UH revenue accrual for two external products is causing the loss. We met with OISP and ISSS and will prepare adjusting entries to recoup some of the missing profit by 4/16. We are still calculating the amount, so it is not known at this time.
Desktop Subscriptions'' profit will more than likely continue to grow. They have been directed to cancel several of their budgeted periodical subscriptions.
Managed Print services revenue is below the budgeted amount because print volume has decreased.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DS
Desktop Subscriptions
$3,365,684.78
$1,728,244.24
$1,514,960.61
$213,283.63
12.34%
MP
Managed Print Services
$1,499,461.02
$336,144.31
$347,379.35
($11,235.04)
(3.34%)
UH
Application Hosting
$34,236,603.46
$19,026,025.35
$20,525,070.99
($1,499,045.64)
(7.88%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 576720000000, 576720000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyh800b3kj720wqem3j8', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 546642000000, 'Update 4/21.  We are working to identify and calculate the amount of the UH adjusting entries noted above.  The exact amount of the adjusting entry still is not known at this time, however, we expect to have it posted in the April NOR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 545961600000, 545961600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyhd00b5kj726r4xryqg', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 516402000000, 'Update 5/6.  The team is currently working on on-tops for the April NOR.  New numbers will be posted 5/13.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 515721600000, 515721600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyhg00b7kj72rfwwpkdd', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 486162000000, 'Update 5/23.  April NOR was finalized on 5/12. DP has a 1.83% profit on $217M revenue. Our largest profit and loss are DA and UH.  The UH recon team has made great strides and have brought the UH loss down 6% which puts it into the acceptable 4% P/L range.  Service DA currently shows a considerable profit because we have not yet received the Microsoft ELA invoice.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DA
Agency-Wide Desktop Connectivity
$35,693,819.61
$21,301,742.05
$20,483,838.31
$817,903.74
3.84%
UH
Application Hosting
$34,236,603.46
$25,849,085.91
$26,155,789.20
($306,703.29)
(1.19%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 485654400000, 485654400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyhm00b9kj72gsre88a7', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 455922000000, 'Update 6/3.  Reviewing draft April NOR and preparing on-top entries that are due to OCFO 6/11.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 455068800000, 455068800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyhr00bbkj72biapqsyl', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 425682000000, 'Update 6/17.  May NOR was finalized on 6/12. DP has a 1.33% profit on $248.8M revenue. Our largest profit and loss are DA and UH have stabilized.  However, MP is still experiencing a loss.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DA
Agency-Wide Desktop Connectivity
$35,693,819.61
$24,129,489.13
$23,891,059.56
$238,429.57
0.99%
MP
Managed Print Services
$1,499,461.02
$449,850.47
$462,333.01
($12,482.54)
(2.77%)
UH
Application Hosting
$34,236,603.46
$28,016,283.26
$28,147,764.31
($131,481.05)
(0.47%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 424656000000, 424656000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyhv00bdkj72por133uy', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 396651600000, 'Update 7/15.  June NOR was finalized on 7/11. DP has a 1.12% profit on $274.5M revenue. Our largest loss is MP due to low print volume (revenue).  The MD profit is due to the eDiscovery Forensics project costs coming in lower than expected (budgeted).
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
MD
Mobile Devices
$9,512,491.53
$6,934,370.19
$6,650,302.74
$284,067.45
4.10%
MP
Managed Print Services
$1,499,461.02
$532,727.22
$543,829.58
($11,102.36)
(2.08%)
UH
Application Hosting
$34,236,603.46
$30,439,098.99
$30,650,431.71
($211,332.72)
(0.69%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 395539200000, 395539200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyi000bfkj727xt9drup', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 366411600000, 'Update 8/12.  The team prepared on-top entries that were due to OCFO 8/12 and finalized the July NOR.  DP has a 1.05% profit on $303M revenue. Our largest loss continues to be MP due to low print volume (revenue).  Unfortunately, the UH loss is growing due to unbudgeted Microsoft ELA charges that posted this month.  The team is currently researching ways to mitigate the UH loss to keep it under 4%.  Another service to note is MD and it''s growing profit.  The team determined that the eDiscovery forensics project budgeted the program too high and the expenses will come in under the budget amount, causing a profit.
Cost Center Code
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
MD
$9,512,491.53
$7,393,483.15
$7,025,162.80
$368,320.35
4.98%
MP
$1,499,461.02
$510,181.87
$524,244.44
($14,062.57)
(2.76%)
UH
$34,236,603.46
$33,637,752.74
$34,494,029.27
($856,276.53)
(2.55%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 366422400000, 366422400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyi700bhkj72lrsuzagc', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 336171600000, 'Update 8/26.  The team is working on August closing accruals and funding FYE procurements.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 336096000000, 336096000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyic00bjkj72abonqap3', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 305931600000, 'Update 9/12.  Aug NOR was finalized on 9/12. DP has a 0.41% profit on $327.9M revenue. MP and UH continue to report a loss as stated above.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
MP
Managed Print Services
$1,499,461.02
$609,648.57
$630,238.28
($20,589.71)
(3.38%)
UH
Application Hosting
$34,236,603.46
$37,719,994.28
$38,770,747.67
($1,050,753.39)
(2.79%)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 305942400000, 305942400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyih00blkj72w7my7aw6', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 275691600000, 'Update 9/24.  The team is working on funding FYE procurements and identifying FYE closing accruals through spreadsheet analysis and meeting with service owners.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 275443200000, 275443200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyio00bnkj72esz0ndrx', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 245451600000, 'Update 10/8.  The team has completed accounting period 13 FYE closing accruals.  Currently the NOR reports DP has a -0.92% loss on $346M revenue.  We are currently documenting the profit and losses and will report this information once finalized.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 245116800000, 245116800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyis00bpkj72i2kxxazg', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 215211600000, 'Update 10/22.  OCFO has published the preliminary FY25 NOR financial results.  The results include an adjusted increase to revenue of $10,157.63 due to a DA miscoding correction on JV RAS25269MLB.  The revenue increase didn’t significantly impact the bottom line, DP retains a -.92% loss.
There were 3 OITO managed services that had losses greater than 4%.  The loss is DA is due primarily to the loss of Headcount revenue.  The loss is MP is due to low print volume (revenue).  Although the UH service made great strides in their cost recovery plan, there were a few unbudgeted costs that surprised us.  1) unbudgeted Microsoft ELA charges posted late in the year.  2) higher unbudgeted ColdFusion costs.
Cost Center Code
Cost Center
*Annual Budget
Revenue
Expense
NOR
Profit % of Revenue
DA
Agency-Wide Desktop Connectivity
$35,693,819.61
$34,327,789.61
$35,758,144.27
($1,430,354.66)
(4.17%)
MP
Managed Print Services
$1,499,461.02
$644,187.84
$675,552.37
($31,364.53)
(4.87%)
UH
Application Hosting
$34,236,603.46
$33,433,764.42
$36,008,881.12
($2,575,116.70)
(7.70%)
Sub-Total
$338,325,885.64
$346,670,862.90
$349,861,842.94
($3,190,980.04)
(0.92%)
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 214790400000, 214790400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyix00brkj72c3r6gc5b', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 184975200000, 'Update 11/7. Provided the OCFO with the following WCF 4th Quarter Management Report explanations:
Service Code
Service Description
FY 2025 Profit/(Loss)
Profit/(Loss) as % of Revenue
Explanation
BA
Business Automation
$258,334
2.00%
Expenses were lower than budgeted which resulted in a profit.  However, the service remains within the 4% P/L.
CD
Continuous Diagnostics & Mitigation
$991,783
7.30%
Single payer funding was received late in the year which prevented us from obligating and spending funds as budgeted.
CT
Customer Technology Solutions
($358,880)
-1.20%
The Agencywide Deferred Resignation Program (DRP) caused a decrease in revenue for many of our Headcount and usage based services. To mitigate the loss, the program office cut budgeted expenses by 23% thereby allowing the service to end the year within the 4% P/L.
DA
Agencywide Desktop Connectivity
($1,430,355)
-4.20%
Actual expenses are in line with budgeted expenses. However, the Agencywide Deferred Resignation Program (DRP) caused a decrease in revenue for many of our Headcount and usage based services, thereby creating a loss in this service.
DS
Desktop Subscriptions
$907,068
28.10%
Based on Administration Direction, several periodical contracts were not renewed and therefore actual expenses were less than budgeted.
DV
Data Visualization
$350,832
17.70%
Salary and license renewal costs were lower than budgeted.
EV
Enterprise Development
$877,915
1.70%
Customer orders exceeded budget which resulted in a profit.  However, the service remains within the 4% P/L.
KS
Security & Integration Services
($698,703)
-2.30%
Actual expenses are in line with budgeted expenses. However, the Agencywide Deferred Resignation Program (DRP) caused a decrease in revenue for many of our Headcount and usage based services, thereby creating a loss in this service.
RV
RTP Voice Telecon Service
($1,153,389)
-32.00%
Actual expenses are in line with budgeted expenses. However, the Agencywide Deferred Resignation Program (DRP) caused a decrease in revenue for many of our Headcount and usage based services, and actual orders were less than the FY25 customer certified amount.
TZ
Technical Consulting Services
($603,752)
-2.60%
April forecast and August certification data from customers indicated a higher volume of anticipated orders. However, actual orders were lower than expected and the service could not fully recover its overhead.
UH
Application Hosting
($2,575,117)
-7.70%
An unbudgeted license renewal posted late in the year causing an unexpected loss beyond 4% of the service revenue.
FY26 WCF Budget Updates
Monday, January 6, 2025
1:30 PM
Past Updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 184550400000, 184550400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyj300btkj72pbz0px8q', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 159573600000, 'Update 1/17.  The internal budget schedule for the FY26 budget cycle was distributed to all OITO Division Directors and Service Owners on 1/8. The first due date is 1/28.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 159148800000, 159148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyj800bvkj728i2238gm', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 129330000000, 'Update 2/3.  OITO Division Directors and Service Owners submitted paragraphs for review.  We will review & consolidate submissions this week and present to OITO Director 2/5.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 129081600000, 129081600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyjd00bxkj728dglp6gy', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 99093600000, 'Update 2/11.  Briefed OITO Director and Division Directors on status of the Budget Memo and summarized the requests received to date.  We noted that we are still waiting on submissions for RPA and the Satellite Mobile communication request and we are also clarifying the OSMO business case.  The team provided feedback and inputs for edits.  These edits will be incorporated to the draft Budget Memo and submitted to the OITO Director early next week for additional review.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 98236800000, 98236800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyjj00bzkj726u8ql6jn', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 68853600000, 'Update 2/26. Met with the OSMO team to clarify questions on their LT Service Business case.  Updated the Budget Memo and provided to the OITO Director for final review on 2/21.  Incorporated the Director''s edits and then provided the revised Budget Memo to the CIO for comments on 2/28.  The memo is due to OCFO on 3/4 and we will likely be late given other tasks that had to be prioritized in the last 2 weeks.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 67910400000, 67910400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyjo00c1kj72t4dvn3q4', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 38613600000, 'Update 3/11.  Incorporated the CIO''s edits and then provided the revised Budget Memo to the OITO Director for signature. The memo was signed and submitted to OCFO on 3/10 along with 2 business cases (RPA and LT consolidation). We are now working on the PowerPoint slides for the April WCF Board meeting.  Planned completion date of 3/19 for Management''s review and the submission to OCFO 3/28.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 37497600000, 37497600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyju00c3kj72iu1rjck9', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, 7164000000, 'Update 3/25. Received comments and questions from OCFO regarding our 3 submissions (Budget Memo, RPA business case and LT consolidation business case).  Worked with operations staff to respond, make edits and resubmit on 3/21.  We  continued to work on the PowerPoint slides for the April WCF Board meeting.  Planned completion date of 3/28.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 7171200000, 7171200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyk000c5kj72426v1m29', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -21866400000, 'Update 4/11. Presented our proposed FY26 DP Activity Budget to the Board. The two service enhancements for CM and DV and the NS Capital Refresh were approved. The OSMO LT and RPA business cases were not presented.  An interim Board meeting will be held sometime before June to present and vote on the business cases.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -22896000000, -22896000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyk400c7kj72m6nqesa3', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -53316000000, 'Update 4/21. No changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -53568000000, -53568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyk900c9kj72av9q1da0', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -83559600000, 'Update 5/6. The team is preparing for the 5/14 and 5/22 CAG and Interim Board meetings.  We will present the RPA and OSMO (LT) business cases and also a proposal to create a new OIM WCF Activity (to be named).  We are also reviewing the entries made to date from the existing DP Activity operations team. We expect to review preliminary cost numbers to management the later part of next week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -83894400000, -83894400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyke00cbkj72d40jye3y', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -113799600000, 'Update 5/23. The CAG & interim Board meetings were held, however the RPA business case was not presented. The LT business case and OIM Activity were presented and both were approved.  A meeting will be held with Leidos to get the new accounting codes added to the eBusiness budget module.  These new budgets are due to OCFO on June 20th as is the rest of the DP Activity.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -113961600000, -113961600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvykj00cdkj7285d1ddoy', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -144039600000, 'Update 6/3. The draft FY26 budget has been developed and we currently having line-by-line reviews with the OITO Director, Division Directors and WCFD accountants.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -144547200000, -144547200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvykn00cfkj72lw3hir7m', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -174279600000, 'Update 6/17. We are continuing to make updates to the draft FY26 budget based on the line-by-line reviews with the OITO Director, Division Directors and Sponsored Service Owners.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -174873600000, -174873600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyks00chkj72yca0regc', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -202100400000, 'Update 7/25.  DP Activity proposed budget, rates and Board Briefing slides were submitted to OCFO 7/25.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -203212800000, -203212800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvykx00cjkj720s1ofo3y', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -232340400000, 'Update 8/12. The DP Activity Memo was reviewed by Tiffany and Bob, signed by the SRO (Yulia) and submitted to OCFO 8/5.  The WCF Board was also held today and the DP Budget was approved with a condition on service UH.  An additional report on service UH was requested to be prepared and presented at the December Board Meeting.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -233193600000, -233193600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyl100clkj727gci7ml2', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -262580400000, 'Update 8/26. No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -263520000000, -263520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyl500cnkj72713vcd11', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -292820400000, 'Update 9/12. No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -293587200000, -293587200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyl900cpkj72p4xgjh3m', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -323060400000, 'Update 9/24. Distributed the approved FY26 budget to service owners, IT/IM leadership and ITS-EPA IV contractors.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -324172800000, -324172800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvylf00crkj7299dr9rs6', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -354510000000, 'Update 10/8. No change.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -354499200000, -354499200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvylj00ctkj72rp5413ok', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -384750000000, 'Update 10/22.  Met with team to discuss and set up FY26 WCF Accounting changes for OFA Activities.  Also continued IM Activity transition meetings to support them in the accounting handoff between the DP and IM Activity.
Current Updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -384825600000, -384825600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvylo00cvkj727964lmmg', 'demo-admin', 'import-section-9a1440b0a0d6424294cec1dd', NULL, NULL, -413776800000, 'Update 11/8.  Continued DP Activity accountant transition meetings as well as providing the IM Activity accounting support for their transition.
WR Incremental Funding Tracker
Tuesday, February 24, 2026
4:29 PM
Data Processing Cashflow Approvals _FY26', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, -414892800000, -414892800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyly00cxkj72z6gs6e9v', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1747774800000, '05/20/25: The FY25 Q2 QSR cycle kicked off April 21; Briefings to Tiffany and Bob are scheduled for June 10, 2025
QSR Briefings have been rescheduled until June 24th & 25th with briefing time reduced due to competing priorities (TM);
Day 1 will be in-person at both HQ and RTP, for participants at each location – a first for Tiffany and Bob, also the first time since pre-Covid', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1747699200000, 1747699200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvym300czkj72mpz0pzdy', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1753822800000, '07/29/25: Q3 QSR cycle kicked off 07/21 and is in the early stage of completion, with financial input being entered by Service Managers and service performance details by technical/Ops.
We had a working meeting (SMB/Ops) to review and clear up old actions and to make sure that in-progress items carry over between cycles.  The system hadn''t been bringing over items from prior cycles once we passed the expected completion date, so updates weren''t being provided.
The Q3 cycle will be finalized by WCFD Director, next briefing is for Q4.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1753747200000, 1753747200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvym800d1kj726840wu7m', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1755032400000, '08/12/2025: QSRs are moving through the cycle.  We need to confirm who''ll take over Pritchett and anyone else taking the DRP, to make sure the system is updated for QSR approvals and notifications.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1754956800000, 1754956800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyme00d3kj7262kvx1rj', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1770760800000, '(02/11/2026) Currently in the FY26 Q1 QSR Cycle, reporting for Oct 2025 – Dec 2025.
Individual service reviews are being completed, 9 are on time.
The remaining 7 are currently behind schedule, waiting for technical manager input.
Current Updates: (04/07/2026)
Planning for FY26 Q2 QSR Cycle, reporting on WCF IT services for Jan – Mar 2026
Working on a review and recalculation of quarterly financial data in Q2.  Currently, financial performance isn''t calculated for each quarter, rather the difference between current and prior quarter is used.  Current method isn''t factoring in the actual period that revenue/expenses are for.  (i.e. an eBus order processed for a retroactive start date and billing after Q1 NOR data is certified would have revenue included in Q2 rather than in Q1).
Laptop Delivery (Michelle)
Monday, June 3, 2024
8:13 AM
Laptop Delivery:
FY2026
Current Update 05/06/2026
ALL items have been delivered for Task Order (68HERF26F0048) as of 05/06/26.
Lead Regions 3 & 4 have scheduled a meeting (05/07/26) for second and last order for FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770768000000, 1770768000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvymi00d5kj72xag4hv6q', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1775595600000, 'Update 04/07/2026
Items have started to be delivered for Task Order (68HERF26F0048), All Accessories have been delivered.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvymm00d7kj72myyd4v2h', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1774386000000, 'Update 03/24/2026
The First FY 26 Laptop Refresh Task Order (68HERF26F0048) was signed by the CO on 03/17/2026 total value of $2,704,268.96.
Copy of the Task Order has been distributed to Regional partners and posted to the Teams channel (Computer Refresh | Refresh Laptop Desktop | Microsoft Teams).
The first set of tracking sheets has also been shared with Regional partners and stakeholders within the Computer Refresh Team to support coordination and visibility, items will start shipping as early as 3/23/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyms00d9kj72bjdxmb43', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1773176400000, 'Update 03/10/2026:
On 3/3/26 the COR requested a Market Research Report, I sent all documents from the previous order, including the prior Planning Requisition, prior APP, and prior Market Research.
An APP meeting was held on  03/09/2026 with Ross Gillingham (CS,) Kim Farmer (COR), Michelle Graf (SM), David Allen (Small Business Office), and  Dawn Brown & Robert Gray (Strategic Sourcing Team); Ross was completing the APP, and reviewing with the team.
Ross (CS) indicated he aimed to complete the laptop buy by approximately April 1, 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvymx00dbkj72b6j0dcnh', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1771970400000, 'Update 02/24/2026:
CT Service Manager reached out to POC/CS that was provided by the Contract Management Section on 02/24/26.
CS responded with they were out ALL last week February 16, 2026- February 20, 2026.  They have not had time to review the PR, and have another PR that must be issued this week.
Manager and Contract Management Team sent response of up date from CS.
Current quote dated 02/17/26 will EXPIRE tomorrow 02/25/26, Agency could see a change in the price.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyn100ddkj72s1cf6osn', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1771970400000, 'Update 2/12/2026:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770854400000, 1770854400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyn700dfkj72smizrd06', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1765922400000, '12/15/2025: Kickoff email sent to all regions. 12/19/2025 Deadline for completion of regional Excel sheets.
Regional responses received: Region 1 (Boston), Region 9 (San Francisco), Region 10 (Seattle).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765756800000, 1765756800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvynd00dhkj72cnoyx9hb', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1768341600000, '01/12/2026: Independent Government Cost Estimate (IGCE) submitted to Contracts Management Section (CMS).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768176000000, 1768176000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvynh00djkj725jyg0rlk', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1770760800000, '02/04/2026: Revised IGCE and vendor quote submitted to CMS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770163200000, 1770163200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvynl00dlkj72v1ddwnsa', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1771970400000, '02/13/2026: CIO review and approval due.
_____________________________________________________________________________________________________________________________
FY25 Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770940800000, 1770940800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvynr00dnkj72jjxepvio', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1746565200000, 'Update 05/07:
$4.5M Laptop PR routed for review 05/10.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1746576000000, 1746576000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvynv00dpkj72axw2l0l1', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1716325200000, 'Update 05/20:
2nd FY24 laptop PR is with contracts. Vendor quote with HQ & Regions'' breakdown was returned to the CS 05/15, so PR is in queue for award, waiting on final signatures.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1716163200000, 1716163200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyny00drkj72voe8y61h', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1687294800000, 'Update 06/10:
Purchase order awarded 05/24.  The 2-in-1 laptops are pending production and have an expected ship date of 07/08, however, the initial ship date provided by Dell is typically a worst-case and moves up throughout the process.  Docking stations ship arrive first and have started shipping to HQ and Regions; standard 24" monitors included in the order have shipped, the larger 27" monitors were delayed, pending a model change, and are expected to begin shipping 06/14.
Counts of laptops and peripherals are being compiled for the 3rd and final FY24 bulk order, for HQ, ORD and Regions.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1686355200000, 1686355200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyo300dtkj72h5o0hg2l', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1718744400000, 'Update 6/17/2024:
24" monitors and the smaller qty of high computing laptops have been delivered, other details are the same as prior update.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1718582400000, 1718582400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyo800dvkj726oj8al0o', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1690923600000, 'Update 07/30:
2nd FY24 laptop order, waiting for Region 1 to schedule delivery. Once this delivery is made order 2 is complete.
3rd and Final FY 24 Laptops Numbers have been completed by Regions/HQ/ORD, Total Order should be less than $1M. Expect PR to be submitted to ITAD within the next two weeks.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1690675200000, 1690675200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyoc00dxkj72qmbrz9zo', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1724792400000, 'Update 08/15/2024
2nd FY24 laptop order 68HERD24F0065 has been completed 08/06/24.
Contracts Management Division has routed 3rd and Final FY24 Laptop PR through EAS.  ITAD should have the PR for processing by end of week August 16, 2024.
Order exception was required for the final PR due to the late year submission; this was the first time we''ve had to do this since establishing a regular order cadence and doing the initial SRO memo, planning PR and APP.
Final numbers for a Rugged Laptop order are being certified by EUSD.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1723680000000, 1723680000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyoi00dzkj725z467fa1', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1724792400000, 'Update 08/27/2024
Final FY24 Laptop PR is being processed by CO, sending it for review this week.
Rugged Laptop documents (IGCE/Quote/Funding Approval) routed to Contracts Administration Branch 8/27/24.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1724716800000, 1724716800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyoo00e1kj72zbj99haa', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1727211600000, 'Update 09/17/2024:
Final FY24 Laptop order signed on 09/03/24 68HERD24F0117.  Items on order already have ship to dates Headquarters, Region 1, Region 4, Region 7, Region 10 and multiple ORD sites.
Final FY24 Rugged order signed on 09/10/24 68HERD24F0116.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1726531200000, 1726531200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyot00e3kj72t5ugoqn0', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1727211600000, 'Update 09/24/2024:
Final FY24 Laptop order 68HERD24F0117, some items have already been delivered. Items that did not have ship to dates on 09/17/24, now have Estimated ship to dates.
Final FY24 Rugged order, items have ship to dates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1727136000000, 1727136000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyox00e5kj72ri89hcsc', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1729630800000, 'Update 10/10/2024:
Final FY24 Laptop order 68HERD24F0117, some items have already been delivered. Few More items to be delivered R07.
Final FY24 Rugged order, All Items have been Received.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1728518400000, 1728518400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyp300e7kj72gwp32xm5', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1729630800000, 'Update 10/22/2024:
Final FY24 Laptop order 68HERD24F0117, ALL items have been delivered except for 2.
FY25 Laptop order preliminary documentation taking place, with Regions.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729555200000, 1729555200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyp800e9kj72neb0grt4', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1730844000000, 'Update 11/05/2024:
Final FY24 Laptop order 68HERD24F0117 Completed ALL items delivered.
FY25 1st Laptop order counts currently taking place with Regions and EISD.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1730764800000, 1730764800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvypc00ebkj72g06zfpsj', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1732053600000, 'Update 11/19/2024:
FY25 1st Laptop order counts currently taking place with Regions, EISD, Superfund Region 4 CID.
Vendor composing "price book" to send to EPA with connect config included.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1731974400000, 1731974400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyph00edkj72daj8ve1x', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1734472800000, 'Update 12/18/2024:
FY25 1st order counts completed 12/09/2024.
Package sent to Contracts Management Branch Kim Farmer on 12/10/2024.  The following documents were attached with the package OITO SRO approval form, sample planning Requisition Laptop, Sample App Laptop, FITARA pre Approval EAS, IGCE 1st Order FY25, and FCO Budget Codes Email from Patrice.
Quote for FY25  1st order, has been reviewed, and will be sent to Contracts Management Branch 12/18/2024', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1734480000000, 1734480000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvypo00efkj72iah1nn65', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1736892000000, 'Update 1/14/2025:
Laptop package is with the Contracts Management Branch. 1/13/25 Service Manager completed the APP (APP-ITAD-25-00001). 1/14/25 Service Manager completed the Market Research document to attach with the completed APP along with the FITARA approval. 1/14/25 Service Manger notified CMB that APP and Market Research were  completed in EAS, sent copy''s of both to Kim Farmer.
Dell Road Map set for January 21, 2025 12:00pm to 2:00pm invite''s will be sent this week to stakeholders.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736812800000, 1736812800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvypt00ehkj72h6u6efsj', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1738101600000, 'Update 1/27/25:
PR-OMS-25-00387 approved by Yulia 01/27/25.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1737936000000, 1737936000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvypx00ejkj72x8sifjox', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1739311200000, 'Update 02/11/25:
FY25 1st buy on funding hold.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739232000000, 1739232000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyq300elkj72fhqbxwcy', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1740520800000, 'Update 2/25/2025:
Waiting on Approval of APP from ITAD Division for FY 25 1st buy', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1740441600000, 1740441600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyq800enkj72qgq1k0mt', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1745355600000, 'Update 4/22/2025:
Approved Compliance Form, Final IGCE, and Quote were submitted to ITAD on 04/21/25.
Unrelated to Laptops... CT now has HEADSET catalog item, an announcement and link were sent to the following: IMO Meeting Chat on April 16,2025, Email sent to the IMO''s,
Announcement made in the Teams Channel Refresh Laptop Desktop.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1745280000000, 1745280000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyqc00epkj72rhyi0pno', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1746565200000, 'Update 05/06/2025:
First order for FY25 signed by CO on April 22, 2025. Accessories have already begun shipping, Region 7 has already received monitors.
Headsets have been delivered to DC & RTP, as of this afternoon we have 31 orders pending in eBusiness along with Bulk order of Qty 75 for Region 9.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1746489600000, 1746489600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyqh00erkj72st47y6gf', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1748984400000, 'Update 06/03/2025:
Currently all Regions are receiving items from order number 68HERD25F0064.  Emails went out to Regional stakeholders on May 29, 2025 to start getting numbers together for last laptop order for FY25.
Stakeholders have been asked to have numbers in by Thursday June 5, 2025.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1748908800000, 1748908800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyqn00etkj72fqm27vrh', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1750194000000, 'Update 06/17/2025:
Items from the initial FY25 order are continuing to be delivered across all sites.
The template for the 2nd and final order for FY25 has been posted and is available for regions to input their item counts.
Extended time has been granted for regions, as they work to gather accurate numbers and validate their counts against the departing user numbers.
Updates: 07/29/2025
From the initial FY25 order there are still 73 units pending delivery; based on today''s vendor update, they have either shipped already or will by the end of this week.
The 2nd/final FY25 order counts have been submitted and are in the process of being reviewed [hopefully] for funding approval and to get all supporting documentation submitted to the COR by the end of this week.
Update: 09/11/2025
Final order for FY 25 signed by CO and Vendor, distributed to POC''s 68HERD25F0156 09/10/2025.
Update: 09/23/2025
Items are arriving at EPA locations for order 68HERD25F0156 09/10/2025. Excited that the new 34" Monitors are arriving this week in Landover Warehouse.
Update: 10/21/2025
All peripherals have been delivered.
Region 1 2in1''s have shipped and are expected to deliver on 10/23.  All the remaining 2in1''s are in "Shuttle" or "In Production" phases.
EUSD (Jackson) sent Email to vendor today engineering testing has been completed without any issues  for Dell Pro Max 16 Plus, approval given to proceed with production factory imaging and delivery.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1750118400000, 1750118400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqxvyqs00evkj720alhlmir', 'demo-admin', 'import-section-dfbf956b1535007eccc45230', NULL, NULL, 1762293600000, 'Update 11/04/2025:
There were a couple technical issues with a Patch and the ISP that caused some delays with shipping the 2in1’s.  ed, and (62) 2in1’s shipped out late yesterday.  All the remaining 2in1’s except for (1) are currently at the merge center for imaging and preparing to ship.
(1) 2in1 unit for Region 7 was damaged in transit so a replacement unit has been ordered.
All Dell Pro Max 16 Plus units have been successfully delivered.
__________________________________________________________________________________________________________________________________________________', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762214400000, 1762214400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbfm0005stjknaixhwgf', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1776805200000, '04/21:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s).
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Budget module training 4/6/2026
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbg40007stjk1rmsm8gu', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1775595600000, '04/07:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s).
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Budget module training 4/6/2026
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbgl0009stjkfahhmx6t', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1774386000000, '03/24:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans are to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s). Leidos demonstrated the facelift in the March CAG meeting held yesterday.  Larry will request an AppScan on Monday, March 23rd.
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Adobe – Migrated AD groups from Org specific groups to agency level groups for each product – Completed 19 March 2026.  The migration went smoothly with the exception of Adobe Acrobat Pro.  There was an issue associated with there being more than 10,000 licenses that had to be addressed.  The issue has been resolved.
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbh0000bstjkwmirr0kp', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1773176400000, '03/02:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
9.16.03 Maintenance Release – Deployed on February 24, 2026 – The updates were database only changes.  Highlights include Budget allocation enhancements, making Adobe AD group levels at the Agency level rather than by organization, the new CE process enhancements, and adding phone numbers to the ArcGIS views.
9.17 is now 10.0
10.0 Release – Plans are to Deploy on April 7, 2026 – This should include the eBusiness facelift. Leidos plans on demonstrating this in the March CAG meeting.
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”
This will satisfy the open security vulnerability POAM.
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Enhance Continuous Evaluations (CE) - Deployed in the 9.16.03 released on February 24th.  March billing will include adjustments back thru FY25
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in March 2026
Additional updates to home page, forms, buttons
Brief Demo – Leidos will target doing a brief demo for the CAG in March.
CT Lite (Regions 5 & 8)
Pre-kickoff strategic planning meeting in March.
eBusiness Budget Module
Need to initialize FY2027 Budget Planning data and establish a schedule.  Tentative plans are to initialize after FY26 BE updates have been completed and revised rates have been finalized.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbhe000dstjk0fhbxqu7', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1771970400000, '02/17:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
EBusiness Application Enhancement:
eBusiness Releases
9.16.02 Maintenance Release – Scheduled 2/24/2026
Budget allocation enhancements,
Making Adobe AD group levels at the Agency level rather than by organization, and
Snow API (Status)
9.15 Enhancements:
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions
Future Enhancements:
Orders Payload for IPL Basic and IPL Core (waiting for SN DEV)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in March 2026
Additional updates to home page, forms, buttons
Brief Demo – Leidos will target doing a brief demo for the CAG in March.
CT Lite (Regions 5 & 8)
Target implementation in February (Leidos).
Chris contacted Michelle Graf re additional Regions; no response yet.
Many Regions pushing back; consider alternate management/billing approach. CTREG FY2026 usage counts down across the board (Craig).
eBusiness Budget Module
Initialize FY2027 planning mid–late February after FY26 BE updates and rate finalization.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbht000fstjks08kerms', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1759870800000, '10/06:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
DRP (Groups 2 [1,732] and 3)/VERA Personnel - Leidos received an updated DRP 3.0 list on Tuesday and cancelled DA and MW registrations for all personnel with administrative leave dates of September 30th or prior. HR has moved most of the DRP personnel to OMS and put them in the OMS-OHCO-RCD-PSB-PSSB office.
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
Leidos continuing to work.  Follow up meeting scheduled for 10/8.
MS products available in eBusiness Phase 2:
No new update
SNOW API:
CT/MP – Orders, Cancellations, Moves all in production
MP – Location moves – Test with release 9.15
MD Cancellations – Test with release 9.15
MD Rescinded Cancellations – Test with release 9.15', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759708800000, 1759708800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbid000hstjkqrmfsfwg', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1729630800000, '10/21:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
Phone services (IPLCORE and IPLBASIC) want RITMs via API to be created
eBusiness Modernization/Facelift – moving forward after progress demo feedback
508 Compliance – Phase 1 was completed as part of release 9.14; more compliance enhancements will be in future releases, including 9.15.  Some are on hold because they will be addressed with the facelift.
ColdFusion Update 21 Hotfix status
Adobe ColdFusion Enterprise 2023 - Leidos attended a meeting with Timothy Adobe (Timothy Pontier) on October 8th. Adam noted EPA will buy the license for eBusiness and Leidos no longer needs to explore buying it under ODCs.
XACTA – eBusiness CMA Year 1 assessment update – Currently reviewing the revisions/changes required in XACTA for NIST 800-53 Rev 5. Meeting weekly with Eric Maule, the assigned POC. Michelle Gyimah is the accessor that has been assigned to eBusiness for the CMA Y1 review.  It was determined that the dates in the email were incorrect and the eBusiness assessment dates are:
PBC Submissions due:                                     October 30, 2025
Assessment begins:                                          November 10, 2025
Assessment testing concludes on:                      TBD
Assessment package delivery by:                       TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729468800000, 1729468800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbir000jstjkdhfwsgwz', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1699394400000, '11/03:
Funded through January 10th, 2026
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
New Enhancement – Orders payload for LF products IPLCORE nad IPLBASIC - #20094 assigned.
eBusiness Modernization/Facelift – moving forward after progress demo feedback.
Adobe ColdFusion Enterprise 2023 - EPA will procure the necessary licence,  Leidos will no longer purchase via ODC.
XACTA – eBusiness CMA Year 1 assessment update – Currently reviewing the revisions/changes required in XACTA for NIST 800-53 Rev 5. Meeting weekly with Eric Maule, the assigned POC. Michelle Gyimah is the accessor that has been assigned to eBusiness for the CMA Y1 review.  It was determined that the dates in the email were incorrect and the eBusiness assessment dates are:
PBC Submissions due:                                     October 30, 2025
Assessment begins:                                          November 10, 2025
Assessment testing concludes on:                      TBD
Assessment package delivery by:                       TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698969600000, 1698969600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbj5000lstjko5yamug9', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1673992800000, '01/05:
Mod P00006 awarded 12/12/2025
Mod. Changes CO to Kaela Back
Funded through January 10th, 2026
Funding PR-OFA-26-00072 assigned to  new CO (Kaela Back) on 12/22/2025
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
New Enhancement – Orders payload for LF products IPLCORE and IPLBASIC - #20094 assigned.
eBusiness Modernization/Facelift – eBusiness team to provide demo to operations group and CAG.  Tentatively scheduled for Feb. 2026.
Adobe ColdFusion Enterprise 2023 - EPA procured the necessary license,  Leidos will no longer need to purchase via ODC.
XACTA – eBusiness CMA Year 1 assessment update – Complete / No vulnerabilities found.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1672876800000, 1672876800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbjj000nstjksax9gusj', 'import-adam-vanenwyck', 'ebusiness', NULL, NULL, 1643752800000, '01/29:
Mod P00008 awarded 01/28/2026
Mod. Incrementally fund Option Period through May 1st
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
EBusiness Application Enhancement:
eBusiness Releases
9.16.02 Maintenance Release – Scheduled 2/24/2026
Budget allocation enhancements,
Making Adobe AD group levels at the Agency level rather than by organization, and
CE process enhancements
Snow API (Status)
9.15 Enhancements:
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions
Future Enhancements:
Orders Payload for IPL Basic and IPL Core (waiting for SN DEV)
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in February/March
Additional updates to home page, forms, buttons
Brief Demo – Leidos reviewed the proposed color schemes on several screens with COR. COR approved the color changes.  Leidos will target doing a brief demo for the CAG in March..
Enhance Continuous Evaluations (CE)
Jon Merical has completed coding the business rules recently agreed upon with John Goldsby.  There are a significant number of complex cases that had to be programmed.  The updates have been moved to our QA environment for preliminary testing.
Adobe ColdFusion Enterprise 2023 – Development Team is reviewing 2023 for backwards compatibility. EPA has purchased the Adobe ColdFusion Enterprise 2023 license.  COR noted it can be per application, server or instance.  Per server likely would be the most cost-effective solution. Currently there are three virtual servers that support eBusiness.  Leidos will discuss further with EPA after development team completes the effort for backwards compatibility.
FY2026 rate recalculation – Leidos previously provided summarized EAC data to assist with this effort.  Budget Execution (BE) data is also being updated in eBusiness', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1643414400000, 1643414400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytbzr000wstjkggtxokip', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1780434000000, '6/1:
Alt. COR working on PRs for two modifications
Mod. 003:  De-obligation of majority of T&M (CLIN 0002) funding
Mod.  004:  COR change (to Michelle Cuilla)
Alt. COR working to update EPA (Adobe web page)
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc06000ystjkrto4t0y3', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1779224400000, '5/19:
FITARA Approved.
IGCE Completed.
Zero dollar PR Completed.
EO Compliance Form Approved.
Market Research Completed.
SRO-being reviewed by Garrett 5/19.
Meeting with Contracts 5/13.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc0n0010stjkxoet5krq', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1775595600000, '4/7: Recompete FY26-27 FITARA Submitted for review 3/31/26', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc130012stjkx002272v', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1764712800000, '11/26:  Awarded.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1764115200000, 1764115200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc1m0014stjkypkvcdxt', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1735682400000, '12/23:
Modification P00001 Awarded.
Purpose of modification is to change CO and CS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1734912000000, 1734912000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc270016stjkd93vfffw', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1705442400000, '01/05:  PR-OFA-26-00131 submitted to contracts.  Purpose of this PR is to switch the COR and Alt. COR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1704412800000, 1704412800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc2o0018stjk00k4qt6c', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1673992800000, '1/13:  No changes/updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1673568000000, 1673568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc36001astjkikv5dirw', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1643752800000, '1/27:  No changes/updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1643241600000, 1643241600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc3o001cstjk46ty839b', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1613512800000, '2/10:  No Changes/updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1612915200000, 1612915200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc3x001estjkbghxebhr', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1583272800000, '2/24:  Starting recompete process for initial package development in June', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1582502400000, 1582502400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc49001gstjkq9g8uujk', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1553029200000, '3/10:  Developing IGCE for submission of EO compliance form for recompete period  11/27/26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1552176000000, 1552176000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytc4k001istjktnkjqkj6', 'import-garrett-hayes', 'import-contract-832e8c8ddb89f3f257fe9c8e', NULL, NULL, 1522789200000, '3/24:  FY26-27 CGER EO Compliance with IGCE Approved 3/20.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1521849600000, 1521849600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcfi001sstjkx8fzkwpd', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1781643600000, 'Update 06/16:
OIG Support:
Removed project Jira work from TC to ITED.
Invoice:
April lagging Invoice has been submitted for payment.
Received May Invoice 6/16. EPA and GSA currently reviewing the May Invoice.
DOL SCA Aduit Invoices (3) have been reviewed by EPA and GSA.
We will be using OY1, OY2 and OY3 rate adjustment to off set some of the invoices. Waiting for GovCIO us final numbers for adjustments.
Funding:
Funding run out 30 Sep.
MODS:
MOD 52 will be for incremental funding.
On-boarding:
2 contractor added to ESSET
2 Removed
Other Contract Actions:
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcfr001ustjka01fm809', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1759870800000, 'Update 10/07/2025:
OIG Support:
Reviewed OIG FY26 SOW approach with Ron Butler and Chris Shafer.
A meeting will be scheduled to review the SOW ''s with OIG.
Invoice:
August invoice was approved and submitted for payment.
Waiting for GovCio to submit Septembers invoice.
Funding:
New funding 3mil was received by GSA.
The new funding run out date for everything is 11/15.
MODS:
MOD 42 was awarded for Incremental Funding.
On-boarding:
2 contractors
Removed 5', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcfz001wstjkulh3bun4', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1761080400000, 'Update 10/21/2025:
OIG Support:
Our first and second meeting was completed to review the SOW ''s with OIG.
Invoice:
August submitted for payment.
Waiting for GovCio to submit Septembers invoice.
Funding:
New funding 13,275mil was sent to GSA.
The new funding run out date for everything is 12/31.
MODS:
MOD 43 is pending for Incremental Funding.
On-boarding:
0 contractors
Removed 8', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761004800000, 1761004800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcg7001ystjkmukohhxk', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1762293600000, 'Update 11/04/2025:
OIG Support:
We are on hold with OIG because of Furlough. .
Invoice:
August submitted for payment.
Waiting for GovCio to submit Septembers invoice.
Funding:
New funding 13,275mil was received by GSA.
The new funding run out date for everything is 12/31.
MODS:
MOD 43 is pending for Incremental Funding.
On-boarding:
0 contractors
Removed 4', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762214400000, 1762214400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcgg0020stjkjvi2hngx', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1770760800000, 'Update 01/29/2026:
OIG Support:
We are working on reviewing the Statement of Requirements.
Invoice:
December invoice has been submitted for payment.
Funding:
New funding 4,828,850 mil being sent to GSA.
The new funding run out date will be 4/30.
MODS:
The next MOD is pending for Incremental Funding and Award Fee.
On-boarding:
9 contractors
Removed 2
Other Contract Actions:
Deliverables are currently being reviewed to be removed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcgo0022stjkfyf6rnxz', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1771970400000, 'Update 02/25/2026:
OIG Support:
I met with EESET and directed them to start working on identify O&M and TC projects. Once the projects are identified we will start to work them into the process of how TC projects should be managed and worked. This will allow us to have the proper reach back for the specialized staff when needed on projects.
Invoice:
January invoice has been approved by EPA.
Funding:
New funding 4,828,850 mil being sent to GSA.
The new funding run out date will be 4/30.
MODS:
The next MOD is pending for Incremental Funding and Award Fee.
On-boarding:
3 contractors
Removed 1
Other Contract Actions:
Deliverables 8 to be removed for a total of 350 hours a year in savings.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771977600000, 1771977600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcgw0024stjklm8jxzlx', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1774386000000, 'Update 03/24/2026:
OIG Support:
Draft Registrations – SOW: We are reviewing Calvert’s (OIG) comments.
Draft Registration Consolidation: Ron Butler advises we anticipate the (3) Infrastructure Registrations to be consolidated to (1) and the (3) Low Code / No Code Registrations to be consolidated to (1).
Staffing Approach: Based on OIG guidance on budget constraints, we have reworked a staffing plan.  This is the precursor to the revised price estimate.
Revised OIG TC Service pricing: Based on OIG budget guidance, the consolidated Registrations, the staffing approach, and the actuals to date, the ESSET team will refactor the Registrations proposals.
Invoice:
January invoice has been approved by EPA.
DOL SCA Aduit Invoices have been received by EPA.
Funding:
New funding received by GSA.
Overall OP3 funding will increase by $4,828,850 from $66,396,764 to $71,225,614. Overall TO funding will increase by $4,828,850 from $282,302,971 to $287,131,821.
The new funding run out date will be 4/20.
MODS:
MOD 47 awarded for Incremental funding
The next MOD will incorporate Hayden Shock as AAS alternate COR (ACOR) for the ESSET task order .
On-boarding:
1 contractor added to ESSET
Removed 1
Other Contract Actions:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytch50026stjkn1ggzs13', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1775595600000, 'Update 04/07/2026:
OIG Support:
We have the consolidated Registration information in hand:  6 Registrations will be consolidated into two Registrations.
The Revised registrations (Infrastructure and Low Code / No Code) are in their draft state and ready to be shipped.
Pricing for the revised approach will get started this week. We had two internal steps that moved forward yesterday in terms of lowering cost to OIG by converting resources to GovCIO.
We can start the revised management engagement. From here, I expect we will meet every two weeks once we get back in cadence.
Sending the revised price proposal back to OIG through the ESSET TC Tracker is the logical next step. However, this will not have a material impact as we are aiming to fit within OIG’s current budget for FY26.
Invoice:
DOL SCA Aduit Invoices (3) have been received by EPA. Will wants to meet with GSA about before TPOC can approve these invoices.
Funding:
The new funding run out date will be 4/20.
Waiting for
MODS:
The next MOD 48 will incorporate Hayden Shock as AAS alternate COR (ACOR) for the ESSET task order .
On-boarding:
0 contractor added to ESSET
Removed 0
Other Contract Actions:
CT overage actions :
Debbie was charging to CT and she is management and should have charged her time to ZZ.
We have found more managers charging time to CT. They will have there charges removed.
Contractors have started taking leave.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytche0028stjkdlximnvn', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1776805200000, 'Update 04/21/2026:
OIG Support:
The 6 Registrations was consolidated into two Registrations.
A new SOW was submitted from James Conrad for DEV/Jira.
This will be reviewed and OIG will be reminded that DEV/Jira resides on MAINES.
Invoice:
DOL SCA Aduit Invoices (3) have been received by EPA.
GSA Kent is reviewing the CCDR''s again. He has some more questions for GovCIO.
Funding:
Funding received and new funding run out date. 4 July 26
Funding runout date will change when we re-align funds from Base Year – Option Year 2.
MODS:
MOD 48 will incorporate Hayden Shock as AAS alternate COR (ACOR) for the ESSET task order and incrementally fund contract for a few days until the ceiling can be raised.
MOD 49 Awarded - raised ceiling for CLIN 3002.
MOD 50 Awarded – added funding to Option Year 3
MOD 51 will be for new Option Year 4 and Funding  ( 3 June 26 )
On-boarding:
1 contractor added to ESSET
Removed 0', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytchm002astjkfhusxx22', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1778014800000, 'Update 05/05/2026:
OIG Support:
The 6 Registrations was consolidated into two Registrations.
A new SOW was submitted from James Conrad for DEV/Jira.
This will be reviewed and OIG will be reminded that DEV/Jira resides on MAINES.
Invoice:
DOL SCA Aduit Invoices (3) have been received by EPA.
GSA Kent is still reviewing the CCDR''s.
Funding:
Funding received and new funding run out date. 4 July 26
Funding runout date will change when we re-align funds from Base Year – Option Year 2.
MODS:
MOD 48 will incorporate Hayden Shock as AAS alternate COR (ACOR) for the ESSET task order and incrementally fund contract for a few days until the ceiling can be raised.
MOD 49 Awarded - raised ceiling for CLIN 3002.
MOD 50 Awarded – added funding to Option Year 3
MOD 51 will be for new Option Year 4 and Funding  ( 3 June 26 )
On-boarding:
1 contractor added to ESSET
Removed 0
Other Contract Actions:  CT Overage -
CT -
Initial RIF Candidates:  We are still targeting a 5/1 execution of these moves.  There are still a few names that may be exchanged based upon conversations with both our internal team as well as with the EPA.  As long as we identify the names (and solidify them) by Friday, we should be on target for this timeframe.
ESSET Management Review:  The team met with Willie this morning to discuss some of the potential management changes that could be implemented in addition to the initial RIF candidates.  GovCIO owes Willie the updated documentation by tomorrow morning.  We have no reason to believe we won''t make that date.
Rate Adjustment:  We are still working with GSA regarding the timing of this.  However, during last Wednesday''s meeting, it seemed as if the EPA was looking to use that credit to be applied to DOL/SCA situation.
Team Communication:  GovCIO reiterated to the team today to please update their upcoming vacation time within CONNECT to assist us in providing more accurate EAC information.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcht002cstjkoc3q9gy0', 'import-michelle-cuilla', 'import-contract-057dbdf775d573de25e7b743', NULL, NULL, 1748984400000, 'Update 06/02:
OIG Support:
Everything is going well and no new updates.
Invoice:
April''s Invoice has been submitted for payment.
DOL SCA Aduit Invoices (3) have been received by EPA and GSA. These will be discussed at the next quarterly meeting with GSA.
Looking at using OY1, OY2 and OY3 rate adjustment to off set some of the invoices.
Funding:
Waiting on next round of funding 24 million approved but not sent yet.
Funding run out 12 June.
MODS:
MOD 51 will be for new Option Year 4 and Funding. ( 3 June 26 )
On-boarding:
2 contractor added to ESSET
10 Removed
Other Contract Actions:
Christopher Ritsch has been removed as the contract PM.
Bill Price is the contractors recommendation as the new PM.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1748822400000, 1748822400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcip002fstjk2hd8s38b', 'import-adam-vanenwyck', 'import-contract-3a6aa924799c90ebc86046d3', NULL, NULL, 1779224400000, '5/19/2026:
Invoice:
Invoice for April has been reviewed and submitted for GSA approval.  May''s is expected to be delivered in the first week of April.
Funding:
Current funding is expected to last through 30 June.
CGER for $30.5M has been approved.
Mods:
Mod 46 is realigning CSIRC''s appropriated 25/26 funding from OY3 to OY4.
Mod 47 will increase the MAINES total ceiling by $90M.  Anything higher will require the Senior Procurement Executive''s review and approval and will add months to the modification''s review.
Mod 48 will add funding (hopefully for the remainder of FY26).
One of the above mods will also include the Award Fee for the previous period and a revision to the number of monthly Deliverables.
New Contractor/Personnel:
No new contractor personnel were added to the task order in the past two weeks.
TZ Projects:
No issues.
RIPS:
No issues.
Misc:
SLAs will be reviewed and revised 19 May.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcjq002istjkiey9vmj9', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1781643600000, '6/16/26
EVML -
Nothing new
HPC -
Nothing new
Funding -
The current funding run out date is (8 Oct 26).
MODS -
MOD 30  - will be the next MOD for incremental funding.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcjy002kstjk8tv57vp8', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1759870800000, '10/7/2025
Deliverable 26 reviewed and approved
GDIT has shutdown plans in place. Contractors are currently working during the shutdown as the contract is funded through December.
SLURM, RHEL, & GPFS renewals verified
Four research requests for FY26 received. Current guidance is to continue projects into FY26 until given more detail', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytck7002mstjky8hnmov5', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1729630800000, '10/21/ 2025
Invoice & Deliverables
Received all deliverables on time for September 2025
Funding
Funding in the amount of $950,000.00 has been approved to fund the contract through December 31, 2025.
Mods
NA', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729468800000, 1729468800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytckl002ostjkc9ksnwm6', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1762293600000, 'Update 11/4/25
Invoice & Deliverables
No new submittals
Funding
Waiting on signed EO compliance form
EPA HESC Program Manager (Heidi Paulsen) working on FY26 requested projects forecasting. Heidi was furloughed 10/27/25.
Mods
Partial Shutdown Notice received from GSA on 10-27-25
Heidi proposed pausing work on HEXSIM and TrackMyAir
Waiting for MOD for incremental funding.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762214400000, 1762214400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcku002qstjkaea8oszr', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1763503200000, 'Update 11/18/25
Invoice & Deliverables
October Deliverables received and concurrence sent to GSA
October Invoice received and concurrence sent to GSA
Funding
Need remains at $950,000,000 to fund from 12/24 through 12/31, 2025
Mods
No new Mods
Contractor Staff Onboarding & Offboarding
(1) onboard
(2) offboard', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763424000000, 1763424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcl2002sstjkfb2nojad', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1764712800000, '12/2/25
Invoice & Deliverables
No changes
Funding
Need remains at $950,000,000 to fund from 12/24 through 12/31, 2025
$600,000 for organizational and $350,000 for GSA costs.
Funding commitments required by 12/3 from organization SRO''s
GSA has been notified of possible stop work order resulting in lack of funding.
GSA requires December funding from the EPA by 12/17/25 to process before runout date of 12/24
Mods
No new Mods
Contractor Staff Onboarding & Offboarding
(1) onboard
(0) offboard', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1764633600000, 1764633600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcla002ustjkvaxqmmls', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1765922400000, '12/16/25
Invoice & Deliverables
CCDR and all monthly deliverables received for November 2025
Funding
Incremental Funding received for period through end of January 2026
Mods
No new Mods
Contractor Staff Onboarding & Offboarding
(0) onboard
(0) offboard', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765843200000, 1765843200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytclh002wstjk39f2p2ko', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1767132000000, '12/30/25
Invoice & Deliverables
December 2025 deliverables due by 1/15/26
Funding
Incremental Funding received for period through end of January 2026
Mods
No new Mods
Contractor Staff Onboarding & Offboarding
(0) onboard
(0) offboard', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767052800000, 1767052800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytclq002ystjkdooqzxey', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1768341600000, '1/13/26
No changes to report', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768262400000, 1768262400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytclz0030stjkrh6u76k0', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1769551200000, '1/27/26
Invoice & deliverables for December approved.
Tasked with reducing deliverables to obtain cost savings- in progress
Contractor staff changes: One FTE removed
De-obligation of 350k brings funding runout date to early March. Incremental funding thru April 30 received $448,424.
Tiffany sending out letter to HPC users/management that if they are using the service they will need to pay for using the service.
As a result of ORD no longer existing, centrally funded projects will be ended in the next 6 months when there is no more funding.
Project Highlights in progress: Voluntary ASM cleanup; FY26 HPC proposals due in February; SYSCat Moderate ATO; EMV Lproject plans;
ASM database reconciliation', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769472000000, 1769472000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcm70032stjkgdq94vhy', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1770760800000, '2/10/26
The current performance period (OY3) is due to end on April 3, 2026.
GSA requires funding no later than March 15, 2026
Program Manager (PM) Justification for postponing HESC Restructuring:
HPC:  Will Lominack sent out an email,  on January 28th to all the HPC PIs and their top managers, with a requirement to start paying for HPC services by the end of Feb.   shortly beginning setting up new SC accounts for the new offices, so the restructuring of HPC is in progress.
EMVL:  Heidi Paulsen has been meeting with a variety of EPA Divisions (OCSPP, OW, etc) to help them learn about how HESC services support their new staff and hopefully drive new business.  There are  3 potential new projects.
PM office waiting for responses from all the offices on HPC needs and funding.
PM office has had the opportunity to speak to more relevant Divisions, bring in additional projects and pivot to the new program offices.  Once contractor staff is lost, it will be difficult to replace them with people of the same caliber.
PM Office agree that changes will need to be made, but they have OSIM funding for a number of the EMVL projects for the first half of this FY, and OAR funding for HPC until May.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcme0034stjk3fv3kmzd', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1771970400000, '2/24/26
Incremental funding $448,242 EO Compliance approved 2/16/26
HPC FY26 project applications due February 27
EMVL MicroSAP project may no longer be funded due to lack of program office approval', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcmm0036stjkpz6lmkb9', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1773176400000, '3/10/26
Incremental funding pending $448,242 for 4/1/26 through 5/12/26.
CPARS reviews submitted to GSA 3/4/26.
Letters sent out to Program Information offices requesting EMVL project plans and funding by 3/31/26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcmv0038stjkd7mwj93h', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1774386000000, '3/24/26
Funding runout date currently May 2
Incremental funding request to Garrett on 3/24/26 in the amount of $450,000 through June 1.
EMVL funding commitments for FY26 have been coming in to Heidi Paulisen with a requested commitment date of 3/31/26.
TPOC will be sending out a follow-up to Heidi''s funding commitment letter to the SROs encouraging funding commitments and advise of possible service interruptions/stop work.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcn3003astjknajp1vma', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1775595600000, '4/7/26
EVML project requests are received and registrations finalized. Meeting for transitioning Heidi''s work to Jamila and Brian.
HPC Resource requests: 34 project requests so far, plus an OASES spreadsheet that lists 6 more projects.  5 more submissions expected, and 5 projects that won’t submit applications but do want to keep their data. Approximately 9 PIs have not responded yet. GDIT is following up with the people involved. Come April 1st, GDIT will turn off access to queues for anyone who hasn’t applied and send automatic notifications to anyone who goes over the time limit (in computing hours) that they requested. They have the technical capability of turning off projects if they exceed their allocation. GDIT is starting the FY27 request process in June, but whether we start then or decide that system use applications are due then is an open question for Heidi or Jamila.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcnb003cstjkdpulgrie', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1776805200000, '4/21/26
EVML -
projects are currently transitioning from Heidi''s work to Jamila Guy and Brian Stitt.
HPC -
Resource requests: 34 project requests so far, plus an OASES spreadsheet that lists 6 more projects.  5 more submissions expected, and 5 projects that won’t submit applications but do want to keep their data. Approximately 9 PIs have not responded yet. GDIT is following up with the people involved.
Funding -
The current funding run out date is (1 June 26).
MODS -
MOD 27 -  exercised Option Year 4 (4 April 26)
MOD 28  - will be for incremental funding
Oracle FY26 (Garrett)
Monday, November 3, 2025
10:26 AM
Oracle Software Update License and Support Renewal
Award by date: 03/31/26
COR:  Sergey Minchenkov/ALT. COR:  Dawn Lamb
CO/CS: Brad Werwick
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcnj003estjkr5nu6rlo', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1776805200000, '04/21: No Updates. There should not be any updates until next recompete, beginning in 09/26.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcnr003gstjk97y5pm4o', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1774386000000, '03/24: NNG15SC59B / 68HERF26F0053 awarded on 03/20. Total dollar value $3,829,621.64.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytco0003istjk8qlhhzb1', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1773176400000, '03/10: Solicitation posted. Q&A closes 03/09. Solicitation closes 03/13. CGER and SRO approval received. Waiting on LOAs to route funded PR for approval.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytco8003kstjkwqc2zih7', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1771970400000, '02/24: $0PR and APP package with CO. OGC approved revised LSJ, and CO is routing for review and signature. Program office is drafting technical requirements in case OGC determines we cannot proceed with LSJ. Funded PR is in SRO approval process.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcoh003mstjk3pdogoeb', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1762293600000, '11/03: FY26 CSI List received from program office, APP document and IGCE created, and FITARA submitted and awaiting approval. Once FITARA approval is received, documents will be submitted to OAS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcoo003ostjkygbb91sy', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1732053600000, '11/18: FY26 CSI List received from program office, APP document and IGCE created, and FITARA approval received. All documentation sent to OCPO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1731888000000, 1731888000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcow003qstjk2f0j09ms', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1703023200000, '12/16: FY26 CSI List received from program office, APP document and IGCE created, and FITARA approval received. All documentation sent to OCPO. PR-OFA-26-00085 routed to OFA 12/17. Funding approved at $5M.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1702684800000, 1702684800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcp3003sstjk9s6tkyjy', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1673992800000, '01/05: PR and APP package with CO. Revised LSJ received from and due back to CO by COB 01/07. APP Kickoff meeting with new CO scheduled for 01/12.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1672876800000, 1672876800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcpb003ustjk77awl0l7', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1643752800000, '01/29: $0PR and APP package with CO. Funded PR to be submitted week 02/02.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1643414400000, 1643414400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcpk003wstjkxpgixu58', 'import-dawn-lamb', 'hesc-ii', NULL, NULL, 1613512800000, '02/10: $0PR and APP package with CO. Revised LSJ with OGC for review. Program office is drafting technical requirements in case OGC determines we cannot proceed with LSJ. Funded PR is in SRO approval process.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1612915200000, 1612915200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcqk0040stjkqbm7ichl', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1781643600000, '06/16: No Updates. Contract funded through remainder of FY26.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcqt0042stjkg823q0hn', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1780434000000, '06/02: No Updates. Contract funded through remainder of FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780358400000, 1780358400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcr30044stjkec6nnamt', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1779224400000, '05/19: No Updates. Contract funded through remainder of FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcrc0046stjk7lhhlt5j', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1778014800000, '05/05: No Updates. Contract funded through remainder of FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcrl0048stjkh59fxrym', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1776805200000, '04/21: No Updates. Contract funded through remainder of FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcrt004astjkaf5tcnry', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1775595600000, '04/07: Contract funded through remainder of FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcs0004cstjk1lw3zk5e', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1774386000000, '03/25: No Updates. Contract funded through 04/30.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774396800000, 1774396800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcs8004estjkmlobvjc7', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1773176400000, '03/10: Contract funded through 04/30.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcsf004gstjkixkyra3e', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1771970400000, '02/24: No updates. Contract funded through 03/15. PR to exercise OP3 and fund 03/16-04/30 is with OCPO and is in progress.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcso004istjklsfzonqu', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1759870800000, '10/07: Key personnel updated.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcsv004kstjk1f46m6we', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1729630800000, '10/21: Funding for 12/01/25 - 12/31/25 approved by WCFD Division Director. PR-OMS-26-00045 created, funding approved, and EO Compliance Review form submitted and waiting for approval. Once EO Compliance Review form is approved, PR will be routed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729468800000, 1729468800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytct3004mstjk1zzbptdd', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1699394400000, '11/03: Contract funded through 12/31', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698969600000, 1698969600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytctb004ostjkbfjp6yyi', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1669154400000, '11/18: No updates. Contract funded through 12/31', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1668729600000, 1668729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytctj004qstjkay8bhnbb', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1640124000000, '12/16: Contract funded through 12/31. Funding approved 01/01/26 - 04/30/26. PR-OFA-26-00089 in progress to fund the balance of OP2 from 01/01/26 - 03/15/26. Funding approved and EO Compliance Review form approved. PR-OFA-26-00090 to exercise OP3 and fund OP3 03/16/26 - 04/30/26 also in progress. Funding approved, and corrected EO Compliance Review form in-progress.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1639612800000, 1639612800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytctq004sstjk29hm6w6s', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1609884000000, '01/05: Contract funded through 03/15. EO Compliance Review form and PR to exercise OP3 and fund 03/16-04/30 in progress.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1609804800000, 1609804800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytctx004ustjkdmwjf2de', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1580853600000, '01/29: Contract funded through 03/15. PR to exercise OP3 and fund 03/16-04/30 is with OCPO and is in progress.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1580256000000, 1580256000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcu5004wstjki52tfkj6', 'import-garrett-hayes', 'import-contract-3cca6c65f4f89588245aa152', NULL, NULL, 1550613600000, '02/10: No updates. Contract funded through 03/15. PR to exercise OP3 and fund 03/16-04/30 is with OCPO and is in progress.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1549756800000, 1549756800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcv5004zstjk7kvzxj9b', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1780434000000, '06/01/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OCEFT has expressed an interest in purchasing 5 licenses in Aug 2026.  COR is working with them in developing and submitting their EAS PR.
OASIS has expressed interest in 1 license.  COR plans to combine these two requirements into one BPA Call Order.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcve0051stjki4hkmavr', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1778014800000, '05/04/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR (officially) that they are not renewing their current licenses (expires April 24th).
OCEFT has expressed an interest in purchasing 5 licenses in Aug 2026.  COR is working with them in developing and submitting their EAS PR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcvm0053stjkn78bu1kd', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1776805200000, '04/21/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license.  However, the BPA order minimum is 5.  The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcvw0055stjkxx7efx5k', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1775595600000, '04/07/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license.  However, the BPA order minimum is 5.  The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcw60057stjkh98egzrs', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1774386000000, '03/24/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OW informed the COR that they are unsure if they will have funding available to renew their current license (expires April 24th).
OCEFT has a need for 1 license.  However, the BPA order minimum is 5.  The COR is looking into pairing OCEFT''s order with another office to meet that minimum.
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.
COR will follow up with customer this week.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcwg0059stjkftbao4qr', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1773176400000, '03/02/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
COR assisting OW and OCEFT BPA Call Order to be awarded mid April
OCIO and OA are looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcwt005bstjkz015jq8y', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1771970400000, '02/17/2026:
No funding required on BPA.
BPA Actions:
None upcoming.
BPA Call Orders:
OIG & OCHCO renewals awarded 2/11/2026
OA is looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcx5005dstjkxs15yjaw', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1759870800000, '10/06:
BPA Actions:
Exercise Option Period 2 by 2/22/2026.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025.  Remaining need confirmed.  Nancy will coordinate with users to determine Brand Admin and license count.  She will submit to COR by mid-December
OIG has also inquired about renewing their Qualtrics products.
COR is working with OIG to define their requirment.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759708800000, 1759708800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcxg005fstjkvawwiyul', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1729630800000, '10/21:
BPA Actions:
Exercise Option Period 2 by 2/22/2026.  PR-OMS-26-00018 has been accepted by ITAD.  The vendor has been notified of the Government''s intent to exercise Option Period 2.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025.  Remaining need confirmed.  Nancy will coordinate with users to determine Brand Admin and license count.  She will submit to COR by mid-December.
OIG has also inquired about renewing their Qualtrics products.
OIG has submitted their requirement.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729468800000, 1729468800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcxs005hstjkkolb81rd', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1699394400000, '11/03:
No funding required on BPA.
BPA Actions:
Exercise Option Period 2 by 2/22/2026.  PR-OMS-26-00018 has been accepted by ITAD.  The vendor has been notified of the Government''s intent to exercise Option Period 2.
BPA Call Orders:
COR met with Nancy Broom 9/10/2025.  Remaining need confirmed.  Nancy will coordinate with users to determine Brand Admin and license count.  She will submit to COR by mid-December.
OIG has also inquired about renewing their Qualtrics products.
OIG has submitted their requirement.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698969600000, 1698969600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcy2005jstjk9bon03f6', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1673992800000, '01/05:
No funding required on BPA.
BPA Actions:
Option Period 2 exercised.  Current period expires 2/22/2027.
BPA Call Orders:
PR-OFA-26-00068 – OIG renewal by 2/1/2026
PR-OFA-26-00106 – OCHCO renewal by 2/1/2026
COR met with Nancy Broom 9/10/2025.  Remaining need confirmed.  Nancy will coordinate with users to determine Brand Admin and license count.  She will submit to COR by mid-December.
Followed up with Nancy 1/5/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1672876800000, 1672876800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcyg005lstjkve3ryrgp', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1770760800000, '01/29/2026:
No funding required on BPA.
BPA Actions:
Option Period 2 exercised.  Current period expires 2/22/2027.
BPA Call Orders:
PR-OFA-26-00068 – OIG renewal by 2/1/2026
PR-OFA-26-00106 – OCHCO renewal by 2/1/2026
COR met with Nancy Broom 9/10/2025.  Remaining need confirmed.  Nancy will coordinate with users to determine Brand Admin and license count.  She will submit to COR by mid-December.
Followed up with Nancy 1/5/2026
Nancy is still attempting to consolidate former ORD users
OA is looking into purchasing Employee Experience licenses for all EPA employees (similar to previous OEPM order)
COR provided OA with information and is awaiting requirements.
FY26 Microsoft ELA
Tuesday, February 24, 2026
4:22 PM
Legacy Microsoft BPA (Kim)
Current POP Expiration: 4/30/2027
Ultimate Contract Expiration: 4/30/2029
Contract Number:  68HERF26A0009
COR: Kim Farmer/Alt. COR:  Garrett Hayes
CO/CS:  Kaela Back
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769644800000, 1769644800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcyu005nstjkhjps17pm', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1763503200000, '11/17/25
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763337600000, 1763337600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytcz9005pstjku8i4bxu2', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1758661200000, '9/20/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1758326400000, 1758326400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytczo005rstjkjm2u3jko', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1763503200000, '11/16/25
APP/Milestones Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763251200000, 1763251200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd04005tstjk4lizc7hv', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1763503200000, '11/15/2025', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763164800000, 1763164800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd0i005vstjkyjc0ail5', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1776805200000, '4/13/26
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776038400000, 1776038400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd0x005xstjkjsrf9v8b', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1776805200000, '4/14/2026
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776124800000, 1776124800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd1b005zstjk7aqelxqd', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1778014800000, '4/23/2026
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd1p0061stjk3i3n7s3f', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1778014800000, '4/28/2026
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777334400000, 1777334400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd250063stjkm76vxcnd', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1778014800000, '4/23/2026
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd2i0065stjk0fj6mh4y', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1779224400000, '5/15/2026
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778803200000, 1778803200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd2x0067stjklitxh4cb', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1750194000000, '6/16
Second call order awarded 6/3
Sill waiting on compliance memo from Region 10', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1750032000000, 1750032000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd3d0069stjkk86bycru', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1747774800000, '5/15
Awarded 5/15
First Call order awarded 5/16
Second Call order PR in process 5/18
New software buy for Region 10 in process 5/18
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1747267200000, 1747267200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd3t006bstjkjzu0xgq2', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1746565200000, '4/30:
TEP was required, final report signed and accepted by CO 4/29.
CO anticipates sending award recommendation to OGE by 5/1.
CO anticipates award no later than 5/15.
Microsoft stated all current licenses will remain usable for up to 30 days.
No cost is anticipated for extension of current licenses while waiting for award.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1745971200000, 1745971200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd49006dstjk22plvqjs', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1745355600000, '04/22:
All final proposals are due tomorrow.  (No TEP is needed).
Request for Proposal (RFP) will need to go to OGC and Advocates Office to approve within 5 days.
Award anticipated by 4/30/2026.  If 4/30/2026 deadline doesn''t get met, then EPA can pay compensation to extend deadline.
OFA has 9 offices, and each one is to submit a separate PR to approve funding.  COR has only received only one PR.  COR is waiting on 8 OFA Offices to submit their funded PR as it will not be fully awarded until then.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1745280000000, 1745280000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd4o006fstjk0642z6ho', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1744146000000, '03/30:
COR contacted all Microsoft Customers to submit their orders no later than 4/10/2026.
COR waiting for final award to be awarded by April 30, 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1743292800000, 1743292800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd4z006hstjk4tvk5q21', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1744146000000, '3/27:  Brand Name Justification approved by the Office of General Counsel.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1743033600000, 1743033600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd5b006jstjka3seoqyf', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1730844000000, '11/3 Meeting with ITAD to map the recompete.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1730592000000, 1730592000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd5m006lstjk02dyyc7q', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1703023200000, '12/15 COR submitted PR (PR-OFA-26-00141) but was delayed to routing issues.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1702598400000, 1702598400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd5w006nstjku7ohvskd', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1673992800000, '1/5:  Due to EAS routing issues, COR resubmitted (PR-OFA-26-00141) and routed to Contracting Team.  The PR is for a recompete, with an anticipated award by March 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1672876800000, 1672876800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd67006pstjk60rah7xp', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1643752800000, '1/21: Approved compliance memo received.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1642723200000, 1642723200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd6j006rstjkcbxjwka9', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1612303200000, '1/28:  The PR is currently with CO, who is reviewing the APP (submitted in Sept. 2025) and Statement of Work (SOW).  The CO is new and asking the COR questions to
become more familiar with the contract.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1611792000000, 1611792000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd6v006tstjk72ll0du5', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1582063200000, '2/10:  CO received comments from OGCE concerning Limited Source Justification (LSJ) for named source.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1581292800000, 1581292800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd76006vstjks8hcqrbp', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1550613600000, '2/12:  Additional language supporting LSJ submitted to CO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1549929600000, 1549929600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd7h006xstjkx82x456m', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1519164000000, '2/13: CO submitted updated LSJ to OGC for review and approval.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1518480000000, 1518480000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd7s006zstjkbkr3gmgl', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1488924000000, '2/27:  The Office of General Counsel (OGC) rejected Microsoft name approval.  Currently elevated to Tiffany by Will for assistance.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1488153600000, 1488153600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd870071stjkcb6dutov', 'import-adam-vanenwyck', 'import-contract-5f48f8cdadd6d7029a70c638', NULL, NULL, 1459890000000, '03/27:  Limited Source Justification was approved by Office of General Counsel (brand name approved).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1459036800000, 1459036800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd9i0074stjkpv0nwlx8', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1780434000000, '5/29:
COR still reviewing and adding feedback to TLG''s deliverable "Service Review and Improvement Recommendation Report".
COR waiting for TLG to submit April''s Invoice (include back Billing for FY26) in IPP to approve.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780012800000, 1780012800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytd9t0076stjkwfevhrt6', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1779224400000, '5/18:
COR pulled back April’s invoice in STAR in order for TLG to replace invoice with new invoice including back billing.
TLG resubmitted invoice to reflect back billing.  This was a $9,706.55 difference.  New invoice is now $33,991.18 and original invoice was $24,284.63.
Service and Project Management section reviewed and approved invoice (to include back billing).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779062400000, 1779062400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytda50078stjkoi19dklx', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1779224400000, '5/16:
TLG met with the COR, Program Office, and Acting Section Chief (IT Service Desk Section) to discuss 373 printers never billed.
TLG stated the error was caused by a column in spreadsheet that was mislabeled as “LTCP” and TLG thought the mislabel would charge EPA twice.  The “LTCP” were filtered out and never charged.
TLG indicated there was 330 printers not reported since May 2025.  40 more printers are on registry but came up in May 2025.
Action Section Chief let TLG know that FY 26 can be back billed to customers, but we can not back bill for FY 25.
Agreed that TLG can back bill but only for FY26 and the estimated amounts ranges from $1,000 to $2,000 a month.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778889600000, 1778889600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdal007astjkhxb6g8v5', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1779224400000, '5/12:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778544000000, 1778544000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdb0007cstjkx786hrt9', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1779224400000, '5/12:  TLG Submitted deliverable – Service Review and Improvement Recommendation Report.  COR will review and provide feedback.
TLG Submitted April’s Invoice w/o any back billing.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778544000000, 1778544000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdbe007estjkiowvckyy', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1779224400000, '5/8:  COR did not receive update on 373 printers as TLG is still investigating and asked for extension until 5/12/2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778198400000, 1778198400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdbs007gstjkg3ihbm2t', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '5/5:  COR requested update on 373 printers still not reporting .  TLG is supposedly meeting w/Chris Costa to determine how to bill EPA.  Requested update by 5/8/26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdc4007istjk1v5y2h8y', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/30:  All printing devices are reporting in through LDCM and should see less and less manual requests for toners, and should be automated.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777507200000, 1777507200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdch007kstjk3wyrjzvb', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/28:  Let TLG know that about 300 to 373 printers have not been included in our billing.  Program searched in invoice and don''t have any of these serial #s.  Program Office Jean Gabriel also indicated that this coudl have happened more then a year ago or even since they started.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777334400000, 1777334400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdcs007mstjkyqrel2dp', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/24:
PR submitted for incremental funding of $60K to cover May through end of July 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776988800000, 1776988800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdd8007ostjkld6jqi5o', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/21:
Still waiting for printer toner update and asked for tracking number twice.  Gvae wrong tracking #.  Been since 4/14/2026 was the original request for toner.
Completed CPARS for 2025 for The Lioce Group – MPS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdeg007qstjkqkmxkq0x', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/16:  Premier toner was received and still asking about other toner for 833 -- Tix # INC1862071', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776297600000, 1776297600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytder007sstjkp1zytyk1', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/14:
Customers are not happy over these toners.    Toners should arrive by tomorrow into the Country.
Let TLG know about another toner that was running out of toner in region 3 and gave tix #.  Not premier Tix # INC1862071', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776124800000, 1776124800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdf2007ustjk4r1seabe', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/13:
still waiting on status of premier printer.
Asking when will new printers be connected to LDCM.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776038400000, 1776038400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdfe007wstjkaiw5pufm', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/10:  Toner for 833 printer are on back order and will arrive in the country next week.  Toner @ HQ (premier printer ) still waiting on .  Toner @ HQ (premier printer ) still waiting on.  TLG stated toner was shipped on 4/8/26 that toner was shipped, but still waiting.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775779200000, 1775779200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdfq007ystjkrhw6vh56', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '4/2:  HQ:  Premier printer toner was out and inoperable.  Toner overnighted (delivered supposedly on 4/3) but tehcnician didn''t receive until Monday, April 6, 2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775088000000, 1775088000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdg20080stjk7414brkb', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '3/31:
Meeting scheduled between Contracting Officer, Contract Specialist, Brad Werwick, COR, and TLG (Prim Contractor) to discuss the problem of not meeting the contract requirements, and what the solution will be.  The problem is sub contractor didn''t connect new printers (from new procurement) to LDCM to monitor toners, etc.  And toners were not automatically ordered and this was a contract requirement.  The underlying problem was an agreement between the Prime Contactor and Sub Contractor has to sign agreement because EPA added new printer models.  This was not an issue with EPA MPS COntract as the PWS clearly states printers could be up to 3,000 printers in fleet (even if all regions joined).
Region 1 hasn''t received expedited printer toner yet.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774915200000, 1774915200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdge0082stjksswg4ipp', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '3/27:  Region 1 had another new printer out of toner and COR contacted TLG (Prime Contractor) to expediate new toner.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774569600000, 1774569600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdgp0084stjkw3g18teo', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '3/26:  Region 1 had another toner out.  (New printer) (this one was delivered later date almost a week 4/3/2026).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774483200000, 1774483200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdh00086stjkscolw6c2', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/25:
COR met with Brad Werwick, Contracting Officer, and Contract Specialist to discuss the issue of the Prime not meeting requirements of contract on not connecting new printers to tool and not ordering toners automatically.
Region 1 did receive toner for 1st printer out of ink (this took a week) (initial request was on 3/18/2026 and the region didn''t receive it until March 25, 2026)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774396800000, 1774396800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdhb0088stjk1le0grc0', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/24:
Region 1s printer became inoperable (no ink in toner).
COR finally got a response form sub contractor who stated it’s the issue as mentioned on last weeks call (about their MOD).
Region 1''s new printer was no longer working as there was no toner.
Sub contractor is trying to work out something with prime for additional funding to cover these new printers. Prime Contractor has to sign a new agreement with Sub Contractor.
MPS Technician told Program Office that he was ordered to stop ordering any supplies unitl MOD is made with Prime Contractor (not a MOD w EPA).
COR met with Contract Specialist (CO was out of office) regarding the Prime not meeting requirements of connecting new printers to LDCM and getting toners ordered automatically.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdhn008astjkqb4agq3l', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/23:
Program Office reached out to COR to escalate problem of no response from Lexmark/Subcontractor.
COR reached out to Prime Contractor TLG and Sub contractor for toner not being provided.  TLG (Prime) claimed they didn''t know that Lexmark would stop supplying toner to new printers (from previous procurement) and not connect new printers to LDCM.  No response from sub contractor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774224000000, 1774224000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdhw008cstjkkfxm6eyj', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/20:  Region 1 still didn''t have any response from subcontractor, and reached out to Lexmark again.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773964800000, 1773964800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdi8008estjkvsnaapjw', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/18:  Region 1 contacted Lexmark regarding a low toner for new printer.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773792000000, 1773792000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdik008gstjkftpkoroe', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/17:  Approved Invoice in IPP for February usage.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773705600000, 1773705600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdit008istjkaficccb9', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1774386000000, '3/12:  Received February''s invoice and usage report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773273600000, 1773273600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdj7008kstjkqq3hj4cf', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '3/05:  TLG presented to the Contracting Officer and Contract Specialist the Quarterly Program Briefing.  CO and CS gave feedback and requested a few changes for next report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772668800000, 1772668800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdji008mstjkhao4u303', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '2/27:  TLG Submitted updated Quarterly Program Briefing Report.  COR scheduled meeting with CO for TLG to present this report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdjt008ostjkfhkxn7e4', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '2/26:  Requested Quarterly Briefing Report with Changes.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772064000000, 1772064000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdk4008qstjk1gz4p5jq', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1771970400000, '2/19:
COR approved invoice in IPP for January 2026 usage.
COR submitted PR PR-OFA-26-00310 to deobligate funds of $189,332.81 for CLIN 1001 (COR confirmed w/Vendor that all invoices have been paid for 2025).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771459200000, 1771459200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdkh008sstjkecma0a06', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1771970400000, '2/17:    COR approved January usage invoice in STAR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdks008ustjkumrejd10', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1771970400000, '2/17:  MOD P0010 to incrementally fund contract for 1 month until end of April 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdl3008wstjk98eyzw56', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1771970400000, '2/12:  COR submitted PR (PR-OFA-26-00297) to incrementally fund CLIN2001 (OY2) for 1 more month until end of April 2026 (in amount of $20K).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770854400000, 1770854400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdle008ystjkhgkkalmb', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1769551200000, '1/23:
COR received the Quarterly Program briefing to review and give potential feedback if needed.  COR will also schedule a meeting for the Program Manager
to present to the CO and CS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769126400000, 1769126400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdlo0090stjkolf2ru7n', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1769551200000, '1/21:  COR submitted EO Complaince form to incremental fund for an additional month (April 2026).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768953600000, 1768953600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdly0092stjk6jcu6o4k', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1768341600000, '1/14:
COR and Alt COR met with new CO and new CS for introduction and give an overview of MPS', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768348800000, 1768348800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdma0094stjkcv978f2x', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1768341600000, '1/05:
COR requested changes to the Quarterly Program Briefing and waiting on the final version.
Jan. 2026 Printer Refresh Order #1 - FY26
Wednesday, January 28, 2026
2:12 PM
Printer Refresh and Accessories (Dawn)
Current POP Expiration:   - A.R.O. 45 days
Ultimate Contract Expiration:  TBD
Contract Number: TBD
COR: Dawn Lamb
CO/CS:  Kaela Back
Update table below with actual milestones
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767571200000, 1767571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdml0096stjkops42dih', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1769551200000, '1/22/2026
APP Submitted
n/a
APP/Milestones Approved
n/a
n/a
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769040000000, 1769040000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdmw0098stjk0j0328vy', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '4/4/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775260800000, 1775260800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdn8009astjkei5saphi', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/14/2026
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776124800000, 1776124800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdnj009cstjklyt6c7j9', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/22/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776816000000, 1776816000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdnw009estjk13to7rnr', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/20/2026
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776643200000, 1776643200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdo9009gstjkbrql6uo0', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/24/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776988800000, 1776988800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdoo009istjk138c6w7d', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/25/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777075200000, 1777075200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdp0009kstjkfmzsuhbu', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '04/23/26
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdpd009mstjk1hkbotb4', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/26/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777161600000, 1777161600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdpn009ostjkbx0yfr3w', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1781643600000, '06/12/26
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781222400000, 1781222400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdpy009qstjksa4f2mlf', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/27/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777248000000, 1777248000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdq7009sstjkmyd9j84w', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '05/01/2026
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777593600000, 1777593600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdqi009ustjk0tqpvoye', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1778014800000, '4/27:  Contract was awarded to The Lioce Group w delivery date of 6/12/2026.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777248000000, 1777248000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdqt009wstjk3i1oolio', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/14:  CO solicited for 26 printers (including printers, stand, and staple finishers).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776124800000, 1776124800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdr3009ystjkuxwnwhde', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1776805200000, '4/13:  COR spoke to CO who stated just received back the brand name specific.  COs next is to solicit', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776038400000, 1776038400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdre00a0stjktfnjosmx', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1775595600000, '4/2:  COR waiting for contract to be awarded for new printer procurement.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775088000000, 1775088000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdrr00a2stjkz9eu18ci', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '3/09;  CO has accepted modification and awaiting PR to be processed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773014400000, 1773014400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytds000a4stjkyk2mdi2t', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '3/04:  COR modified the PR to decrease quantity 26 printers and accessories as requested by the Service Management Division.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772582400000, 1772582400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdsd00a6stjkpv8f5whg', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1773176400000, '2/27:  PR still being processing and waiting to be awarded', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdsq00a8stjk2zla8915', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1770760800000, '2/5:  Contracting Assigned a buyer:  Kaela Back', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770249600000, 1770249600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdt200aastjk1iqi0yir', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1770760800000, '02/04: PR Submitted (PR-OFA-26-00145) and routed to FCO for approval for 49 Lexmark Printers to replenish inventory.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770163200000, 1770163200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdtc00acstjk46xwa2lj', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1769551200000, '1/28:  FITARA Team fixing issue w/FITARA Approval Number as code didn''t work in in EAS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769558400000, 1769558400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdto00aestjkzgxjwx4q', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1769551200000, '1/26:  FITARA Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769385600000, 1769385600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdtz00agstjkely8t8ga', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1768341600000, '1/12:  EO Compliance form was approved for $300K for entire year of 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768176000000, 1768176000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdua00aistjk2f0dbq0m', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1768341600000, '1/06: COR Submitted FITARA for approval.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767657600000, 1767657600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdum00akstjk4a4y4mli', 'import-dawn-lamb', 'ebusiness', NULL, NULL, 1767132000000, '12/29:  COR submitted EO Compliance form for $300K for entire year of 2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdvp00anstjk7vxfkdvc', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1781643600000, '06/16:
Funding -
TPOC requesting from program offices -
Incremental Funding (14) - applying previously approved $407K - in-progress
Funding unfunded projects / all funding requests through 09/30 (15) - in-progress
Goal - fund all projects through 09/30 / prepare program offices to forward fund projects at least through 11/30
Transition to G-Invoicing
EPA generated GT&C - with GSA now for action.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdw000apstjkmcnqnku8', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1780434000000, '06/02:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project (12) - DONE
Exercising/incrementally funding OP1 (13) - DONE
Incremental Funding (14) - applying previously approved $407K - in-progress
Funding unfunded projects / all funding requests through 09/30 (15) - in-progress
Goal - fund all projects through 09/30 / prepare program offices to forward fund projects at least through 11/30
Transition to G-Invoicing
EPA generated GT&C - with GSA now for action.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780358400000, 1780358400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdwc00arstjkzmqq5n63', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1779224400000, '05/19:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project - DONE
Exercising/incrementally funding OP1 - DONE
Funding unfunded projects / all funding requests through 09/30 - in-progress
Goal - fund all projects through 09/30 / prepare program offices to forward fund projects at least through 11/30
Transition to G-Invoicing
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdwn00atstjk2vfdq5di', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1778014800000, '05/05:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project - DONE
Funds for OP1 per project
TPOC working on funding package to send to OCPO - only outstanding requirement is Multiple Appropriations Memo. With SRO for approval.
Anticipate submitting funding package next week, week of 05/03.
Total Dollar Value: $834K. $834K + $250K balance from base year will fund about 2 months
TPOC will work with OCPO/GSA to move any remaining funds from GAVETS 1 to GAVETS 2.
Next Option Period is 05/13/26
Transition to G-Invoicing
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdx000avstjkk5upppee', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1776805200000, '04/21:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project
Funding package sent to GSA
TPOC will work with OCPO/GSA to update 7600B/LOA Funding Spreadsheet if required
Total Dollar Value: $513K
Around $300K required for balance of base. Remainder will roll over to OP1 after invoicing for base period is complete.
Funds for OP1 per project
TPOC working on funding package to send to OCPO - only outstanding requirement is Multiple Appropriations Memo
Anticipate submitting funding package next week, week of 04/27.
Total Dollar Value: $1.2M - will fund about 2 months
Next Option Period is 05/13/26
Transition to G-Invoicing
TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdxe00axstjkbkwc695v', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1775595600000, '4/07:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project
Waiting on SRO approval
Due to TPOC 04/03, will go to GSA week of 04/06
Total Dollar Value: $275,115.75
Funds for OP1 per project
Waiting on SRO approval
Due to TPOC 04/10, will go to GSA week of 04/13
Total Dollar Value: $1,874,314.62
Next Option Period is 05/13/26
Transition to G-Invoicing
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdxq00azstjksbjv7ry6', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1774386000000, '03/25:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from program offices -
Funds for balance of base period per project
Due to TPOC 04/03, will go to GSA week of 04/06
Total Dollar Value: $275,115.75
Funds for OP1 per project
Due to TPOC 04/10, will go to GSA week of 04/13
Total Dollar Value: $1,874,314.62
TPOC submitted CGER, will need for SRO approval
Next Option Period is 05/13/26
Transition to G-Invoicing
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774396800000, 1774396800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdy000b1stjkp1fcz8jm', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1773176400000, '03/10:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
TPOC requesting from contractor -
Status of funds for balance of base period per project
LOE for OP1 per project
Next Option Period is 05/13/26 - EPA can provide whatever funding it is able to put on contract.
TPOC will use status of funds and LOE to work with program offices on funding docs for balance of base period and OP1 exercise
Transition to G-Invoicing
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773100800000, 1773100800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdya00b3stjki6ba8xw8', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1771970400000, '02/24:
Transition -
Transition processed. Garrett Hayes is TPOC, Michelle Cuilla is alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Funding -
Next funding action will be this month. Should be requiring funds for the balance of the Period of Performance.
Next Option Period is 05/13/26 - GSA was requesting ~30% of Option Period. This turned out to be incorrect, and EPA can provide whatever funding it is able to put on contract.
Transition to G-Invoicing
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771891200000, 1771891200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdyl00b5stjk1xqbxz0e', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1768341600000, '01/05: High-level transition kickoff meeting held 12/15. Both ITOD TPOC and current TPOC were out of office 12/19 - 01/05. Detailed transition meetings scheduled to begin week of 01/05. Official transition date has not yet been finalized.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767571200000, 1767571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdyw00b7stjkrr536nds', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1738101600000, '01/29:
Transition in process. Garrett Hayes will be TPOC, Michelle Cuilla will be alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg. GSA is beginning paperwork to process transition.
Next funding action will be in February.
Official transition date has not yet been finalized.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1738108800000, 1738108800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytdz800b9stjk4v0xubqu', 'import-garrett-hayes', 'import-contract-8bdd5dee44f90d09fd873e19', NULL, NULL, 1707861600000, '02/10:
Transition -
Transition in process. Garrett Hayes will be TPOC, Michelle Cuilla will be alternate TPOC, and Dave Smith will stay on as alternate TPOC until transition is complete and GAVETS is back in steady state post-reorg.
Paperwork has been submitted but will not be processed until after next funding action is complete. Should be sometime this month.
Official transition date has not yet been finalized.
Funding -
Next funding action will be this month. Should be requiring funds for the balance of the Period of Performance
Next Option Period is 05/13/26 - GSA is requesting ~30% of Option Period.
Transition to G-Invoicing
Incoming TPOC will generate GT&C in G-Invoicing so vehicle can be moved into system post-option period exercise.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1707523200000, 1707523200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte0j00bcstjk3nozzoua', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1780434000000, '5/27/2026
General
Primary COR Responsibilities transferred from Valisha Jackson to Andrew Rhoades 18 May 2026.
There was not a transition plan or meeting held.
I am prioritizing getting OY4 funding over to NITAAC before the 1 June deadline.  Once that has been completed, I''ll begin sorting through documentation and coordinating more with EOB on ITI3 tasks.
GSS Customer Meetings
ITOD Customer Meeting (EPA Scientific Support) to be held on 28 May 2026
Funding
$5.57M to cover 6 months of OY4 (August 28, 2026-March 2, 2027) is working.
Email sent to Kristen Arel, copying Temberly James, 18 May for SRO routing and signature.  Kristen confirmed receipt stating she would "start the review now".
A follow up email was sent to Kristen on 21 May.  Andy Prugar said their branch had reiterated the urgency of the review and signature with Kristen''s branch chief on 21 May.
Kristen responded on 22 May asking if the CGER form wasn''t received and she couldn''t route until she had the CGER form.
The CGER form was sent back within minutes.
A follow up email was sent on 26 May.
A response was sent 27 May that the Routing and Concurrence form was sent up for SRO signature that morning.
An Email was sent to Temberly with high importance on 20 May requesting her review of the IA package and if there was any way to get the process started while we were waiting on SRO signature of the Routing and Concurrence form.  No response.
A follow up email was sent on 22 May.  No response.
A follow up email was sent on 26 May.  The response was "This (referring to the Routing and Concurrence form) needs to be signed by the SRO.  I believe I remember Craig routing this so it might be in someone''s inbox".
Risk: The deadline for this, which was specified in the above stated emails, is 1 June.  The Routing and Concurrence form was sent for SRO signature on 18 May and was routed to the SRO 27 May.  The IA package cannot start getting input into G-INV until SRO signature.  NITAAC''s 1 June deadline is at risk of not being met and there is no sense of urgency from the offices responsible for SRO signature and submitting the IA package to NITAAC.  Should NITAAC be unwilling to accept the funding to exercise OY4, ITI3 will expire 27 August 2026.
Patriot PM Key Personnel
Advised by Patriot on Monday, May 4, 2026 that Program Manager, Jack Venturo left the company effective immediately
Dipak Patnaik has taken on interim PM responsibilities until a full time PM has been onboarded.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779840000000, 1779840000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte0u00bestjk8kn19gej', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1778014800000, '5/5/2026
General
COR Documentation provided to NITAAC personnel on April 28, 2026
Craig Hammel communicated that transfer would be effective May 1, 2026 but no formal contract modification has taken place
ORD Tiger Team was to be concluded as of April 30, 2026 which Valisha was advised of on April 29, 2026 during the GSS/ITI3 ITOD Weekly
GSS/ITI3 Weekly Meetings
GSS/ITI3 ITOD Weekly scheduled for Wednesdays at 3:30 p.m.
Hosted by Willie Abney and co-lead by Valisha Jackson
RISK: ITOD personnel have been meeting with Patriot personnel regarding knowledge management efforts, but no known documentation/ knowledge capture of the meetings are currently being centrally maintained by any ITOD personnel
GSS Customer Meetings
ITOD Customer Meeting was held on April 30, 2026
Meeting was to be recorded, but Valisha has not yet viewed the meeting and/or next steps
Scientific System Fusion Teams
Valisha was  invited to the EPA Scientific Systems Fusion Team meetings on Mondays as of Monday, May 4, 2026 but was unable to attend
Funding
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026
Was advised on Wednesday, April 29, 2026 by J. Cunningham that these funds have been allocated for other efforts.
Advised Willie Abney who said he would follow up with James regarding this
OY3Q4 funding has been signed by EPA and NITAAC on May 5, 2026 for a June 1, 2026 start date
Mod still needs to be done by the CO
Option Year 4 Funding Actions
See email thread from Valisha on Monday, May 4, 2026
$5.57M to cover August 28, 2026-March 2, 2027
Risk: CGER Form will need to be expedited through approval process
General Risk
Valisha does not currently feel comfortable being named as COR to this vehicle with financial responsibilities e.g. approving invoices when there is no documented manner to validate the time being billed to the government for the services delivered e.g. tickets with work details, project plans, technical direction documents, etc...
This risk remains, despite being required to submit COR nomination forms
Patriot PM Key Personnel
Advised by Patriot on Monday, May 4, 2026 that Program Manager, Jack Venturo left the company effective immediately
Meeting with the VP of Service Delivery to on Friday 5/8/2026 to address immediate program management needs and risk', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777939200000, 1777939200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte1400bgstjkr0f5ffhx', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1776805200000, '04/22/2026:
General
Major actions pending from meeting with T.McNeil and W. Abney on Monday, April 20, 2026 include
information on the 6 month period of performance for Option Year 4
Breakdown of PWS with options for realignment, descoping, cost reduction, etc...
Weekly transition meeting resume on Wednesday, April 22, 2026 at 10:30 a.m. with Craig Hammel
Will be able to provide more information afterwards
Funding
OY3Q4 funding is queued in G-Invoicing with all associated documents awaiting NIH action
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026
Need to check on status of this action and year of funding currently in use on the vehicle
Risk
Valisha does not currently feel comfortable being named as COR to this vehicle with financial responsibilities e.g. approving invoices when there is no documented manner to validate the time being billed to the government for the services delivered e.g. tickets with work details, project plans, technical direction documents, etc...
General
Briefing with T. McNeill, W.Lominack, V. Jackson and M. Fays on March 2, 2026
As of 3/2/2026 - T.McNeill advised that ATO will be extended, but no info on extension date
Advised Craig Hammel on March 4, 2026
GSS infrastructure is expected to be assumed by IT Operations Division
Within Brandi Surmmons Branch; no specific FTE named
Has there been discussion about appropriated FTE moving to EOB to perform support?  We cannot have WCF employees supporting work that is not in the Fund.  This should be a question in our next transition meeting.
T. McNeill requested a contractor Led Overview Presentation tentatively scheduled for April 15, 2026 at 9:00 a.m.
Valisha documented requirements for presentation to inform agenda
Reviewed by and discussed with M. Fays on March 5, 2026
Reviewed by Craig Hammel on March 9, 2026
Sent to contractor on 3/10/2026; draft due 3/24/2026
Meeting will be in-person at EPA Headquarters
Craig is working to facilitate an intro meeting between NITAAC CO, Christopher Cunningham, Valisha and Andrew Rhoades in the next couple of weeks
Next standing weekly contract transition meeting scheduled for March 11, 2026 at 10:30 a.m.
Funding
OY3Q4 funding is queued in G-Invoicing with all associated documents but awaiting SRO signature
Niki Maslin/Alva Daniels were emailed February 3, 2026 for SRO signature
As of March 5, 2026 still awaiting action
Approximately $891k in 25/26 funding from OY2 and approximately $31k from OY3Q1 remains on the contract to be de-obligated according to Craig on March 4, 2026
As of March 4,  2026v NITAAC awaiting 7600B from Temberly James – current Project Officer to decrease funding
DW-075-95981901 is the IA', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776816000000, 1776816000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte1f00bistjkaq21rd8z', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1770760800000, '2/10/2026:
Transition Meeting – Scheduled for 2/11/2026 at 10:30 a.m.
Ongoing Risk –
Lack of ownership of the GSS system and/or any of the technical roles required for direction, oversight, and general program management are major block in transition planning and execution
No ISO creates risks related to NIST adherence, among other security concerns and added costs to the agency', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte1p00bkstjktw9hyhhf', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1769551200000, '1/28:
Transition Meeting – Invoicing Processes and Documentation was the primary focus held on 1/14/2026 at 10:30 a.m.
Meeting notes and actions items distributed to all invitees on 1/14/2026
All agenda items were not covered; will work with Craig to address those matters via email and offline discussions
Attendees: Craig Hammel, Valisha Jackson, Andrew Rhodes, Michael Fays, and Kristen Gaster Invited but did not attend: James Cunningham and Jon Richardson
Weekly transition meetings are scheduled on Wednesdays from 10:30 – 11:30 a.m.
Kristen Gastner attended the 1/14/2026 meeting as there are former ORD personnel who fulfill required roles related to the business needs of this contract, who have been assigned to her section. She will attend based on agenda items to be covered
Meeting scheduled for 1/21/2026 will focus on the transition plan outline developed by Valisha and any lapse planning activities and information
Valisha has requested access to the vendor under the Task 1 Firm Fixed Price to help to facilitate some of the knowledge management due to Craig''s limited bandwidth.
RISK –
Lack of ownership of the GSS system and/or any of the technical roles required for direction, oversight, and general program management are major block in transition planning and execution
No ISO creates risks related to NIST adherence, among other security concerns and added costs to the agency
Funding
An Executive Compliance Form has been routed by James Cunningham and Craig Hammel to fund the contract through the end of the Option Year, August 27, 2026
Note: This action was suggested to be transitioned to ITO, however, until there is a documented bona fide business need to support the activities currently being delivered, this is not something that Valisha, on behalf of ITO will be comfortable doing.
Lapse Planning (Time Sensitive)
Craig Hammel is working with the vendor and James Cunningham to determine if this vehicle and its activities will still be considered exempted and/or excepted; as well as Craig and Jon Richardson as excepted personnel.
In the most recent lapse, Craig reported that because the contract was funded, ORD decisionmakers permitted work to continue as planned.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769558400000, 1769558400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte2100bmstjkiibn3jms', 'import-michelle-cuilla', 'iti-iii', NULL, NULL, 1768341600000, '01/05:
This contract vehicle is still in the early stages of transition and currently remains with the current personnel Craig Hammel, formerly of ORD
Valisha Jackson has been identified as the to-be COR and Andrew Rhodes will be the Alt-COR
No specific transition-in date has been determined as of yet
RISK: It remains unclear how the separation of duties will be managed to delegate contract management functions and technical program direction based on the current functions
RISK: Current ATO expires June 2026; there is no IMO, SIO, or ISO currently identified to own this
Valisha has been actively reviewing contract related files and emails to develop a transition in plan and timeline.
This effort was paused over the last two weeks due to leave but resumed on Monday, January 5, 2026
Invoice Processing Transition Meeting is scheduled for January 14, 2026
Contract Period of Performance was split into quarters for the current option year based on ORD management direction.
Q1: 8/28/2025-12/1/2025
Q2: 12/2/2025 - 2/28/2026
Q3: 3/1/2026 - 5/31/2026
Q4: 6/1/2026 -8/27/2026
This was done via a formal contract modification
Funding - Current funding at a contract level is through Q3, May 31, 2026
RISK: Funding for this vehicle was single sourced out of ORD, with no cost recovery model
ACTION REQUIRED: CBI Access Request CBI-0007431 https://oppt.lightning.force.com/lightning/r/CBI_Access_Request__c/a06SJ00000ktoHqYAI/view
Required for CBI related functions on the contract
Submitted to Craig Hammel as the DCO, and Will Lominack as the First Line Supervisor, because Michael Fays does not come up in the system', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767571200000, 1767571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte3500bpstjkhhsfpcsq', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-eae8e00c70a495083e0607af', NULL, NULL, 1780434000000, '6/1/2026
I met with the previous contract owner (he said he was never delegated authority as a COR) 1 June 2026 and toured RTP''s main building to better understand what the devices were and what they monitored.  They''re small devices attached to the refrigeration units that wirelessly broadcast to a few centralized router like devices.  These devices are attached to the network and send the data to a dashboard for temperature and maintenance monitoring.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte3j00brstjkbecmc0m0', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-eae8e00c70a495083e0607af', NULL, NULL, 1780434000000, '5/27/2026
General: BLUF: I know very little about this contract other than it expires in August.
I''m investigating what this contract completely entails.  The documentation I''ve seen doesn''t appear to be current.  Prior year awards appear to be closed out and it seems like they''re only ordering replacement parts each year.  I haven''t seen a contract maintaining the equipment with a PoP yet.  However, when I asked the current COR, the response was "It''s just an order - you''re in the last option year so a clean slate going forward.  No options to exercise.  August 2026 will be the end of the PoP and we have the latest invoice for the following year ready for you."', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779840000000, 1779840000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte4k00bustjkt58itsyz', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, NULL, 1782853200000, 'TrueTandem (Garrett)
Monday, June 22, 2026
9:01 AM
TrueTandem (Garrett) Current POP Expiration:
Ultimate Contract Expiration:
Contract Number:
COR: Garrett Hayes/ALT. COR:  Dawn Lamb
CO:  TBD
CS:  TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782238549670, 1782238549670);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte5o00bxstjk48go987y', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, NULL, 1782853200000, 'IMCS – V (Shela)
Monday, January 05, 2026
10:20 AM
Information Management Center  Services (IMCS) - V – 3 Task Orders
COR:  Shela Poke-Williams
Please review each subtab for each Task Orders
ABACCO Blackfish (Shela) - Contract Number: 68HERD23D0002
AGILE - Contract Number:  68HERD23D003
DAYCOM - Contract Number:  68HERD23D0001', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782238549710, 1782238549710);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte6r00c0stjkm5zbfgc3', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1781643600000, '6/10', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781049600000, 1781049600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte7300c2stjkta029q29', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1776805200000, '4/15/2026: Received the Award of Modification P00008 to Task Order 68HERD23F0103 (Web Support for the Office of the Chief Financial Office) under Contract 68HERD23D0002 which exercises Option Period 3 (OP 3), provides funding in the amount of $107,223.60 (thereby fulling funding CLIN 3001) and extends the period of performance until 04/30/2027.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776211200000, 1776211200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte7e00c4stjku55yvivw', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1774386000000, '3/24/2026: 80% funding notification was sent on 3/6', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte7q00c6stjkr1cgc51a', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1773176400000, '2/27/2026: OCFO, OY2 is funded through 4/30/25. We are still waiting on a modification to exercise/fund OY3. Abaco will be sending the 85% funding notification by 3/6.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772150400000, 1772150400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte8100c8stjk89gmocn0', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1769551200000, '01/28:
Information emailed and received for updates within the task orders of the Contract Abaco from the CO.
Abaco Blackfish (Library Services, Records and Web Support) – 68HERD23D0002, the original amount of Abaco contract was $4,515,094.59, with pop of 11/01/2022 – 10/31/2027.
Two (2) task orders under Abaco Blackfish, which are as follows:
68HERD23F0052, pop 3/1/2025 – 2/28/2026, total amount is $117,054.46, funding remaining - $18,679.31.
68HERD23F0103, pop 5/1/2025 – 4/30/2026, total amount is $105,174.48, funding remaining - $35,058.16.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769558400000, 1769558400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte8e00castjkwn8stjf7', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1739311200000, '02/10:
No updates to present.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739145600000, 1739145600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte8q00ccstjk08b7csbz', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1709071200000, '2/24:
This is for the IMCS V Contract concerning record keeping and storage.
From Ryan Philbrick, this is a follow up email to the conversation that we had yesterday, about potential cost savings at the agency. As part of an ongoing effort to quantify and document agency wide cost savings associated with centralizing paper records management activities at the National Digitization Centers (NDCs), we are requesting some assistance in obtaining some acquisition documents for the ICMS contract.
Specifically, we are requesting copies of the Performance Work Statements and Independent Government Cost Estimates for all active and recently completed task orders under the ICMS vehicle. We want to analyze the material in order to try to quantify the cost savings we could potentially realize by centralizing the management of paper records storage, handling, file room operations, cataloging, and other records management services.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1708732800000, 1708732800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte9300cestjk1qfzyref', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1678827600000, '3/9:
Financial Summary,', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1678320000000, 1678320000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte9e00cgstjkmlpjp5x4', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1648587600000, '3/24
D0002 Financial Summary: Total Ceiling $4,515.094.59, amount obligated $3.902,816.83, amount originally invoiced $3,653,311.37, amount paid $3,653,311.37. Remaining approved amount $260,978.94, % of funds used 94%, ODC funds obligated $47,067.29, funds remaining $13,973.48
No significant difficulties encountered during this reporting period.
F0052 Financial Summary: Total Ceiling $ 117,054.46, amount obligated $105,056.64, amount invoiced $105,056.64, amount paid $105,056.64, % of funds used 100%, ODC funds obligated $11,997.82, ODC fund invoiced $10,882.99, ODC funds remaining $1,114.83, remaining approved amount 1,114.83.
Difficulties Encountered:
On February 2, access to the EPA Network server was down for most of the day making it impossible to search the EPA Library Catalog. Eventually it was restored. This has happened 2 other times, both for a shorter duration during this reporting period.
On February 24, access to EPA Duluth’s American Chemical Society’s journals (Analytical Chemistry, Chemical Research in Toxicology, and Journal Agricultural and Food Chemistry) was temporarily blocked but was restored within hours after the Librarian sent an email to ACS’s Sales Department and a phone call to ACS’s technical support.
F0103 Financial Summary: Total Ceiling $105,174.48, amount obligated $105,174.48, amount invoiced $87,645.40, amount paid $87,645.40, % of funds used 83%, remaining approved amount $17,529.08.
Difficulties Encountered
No significant difficulties encountered during this reporting period.
Anticipated Activity
OCFO was recently reorganized into a new office (OFA), and the Information Specialist will continue to assist in merging web content for this process. The Information Specialist is involved with a project to move policy content into an agency-wide policy catalog', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1648080000000, 1648080000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyte9p00cistjkgmtw2yf8', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1618347600000, '4/09
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1617926400000, 1617926400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytea100ckstjkthqalu3y', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1588107600000, '4/21
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1587427200000, 1587427200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytead00cmstjk8uifxe5o', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1556658000000, '4/30
We meet with the CO on the IMCS V contract to discuss some procedural issues, and the upcoming re-compete. I will be sending out info on the re-compete early next year.  I was asked by the CO to gently remind the TCORs of the following:
All PRs for option exercise should be submitted 90 days prior to end of current POP.
Once a task order expires, the option cannot be exercised.
Lack of an option exercise does not result in a stop work; it results in a task order ending.
A stop work cannot be used in leu of an option exercise.
If the option is not exercised by end of current POP, the task order must be re-competed, and no work will be done until a new task order is awarded.
TOCORs are responsible for tracking their funding and submitting PRs prior to funding deficit.  Incremental funding should be submitted 45 days prior to required obligation.
All PRs should be routed to COR for review before submitting to CO.
Approved Compliance memos are required to be submitted as attachments to all EAS actions.
I intend to set up a monthly “Office Hours” meeting in Teams soon, to allow for any issues, concerns or questions you may have. You do not need to wait for Teams office hours if you have an immediate question, feel free to call, teams chat or email me any time. Thank you so much for your ongoing support.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1556582400000, 1556582400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteap00costjkubacb82w', 'import-shela-poke-williams', 'import-contract-5c4031542012d126e56612ca', NULL, NULL, 1527627600000, '5/19
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1526688000000, 1526688000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytebv00crstjke4kc0v9w', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1781643600000, '6/10
Agile monthly technical report 3/28 - 4/24, no tasks orders - 68HERD23D0003
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781049600000, 1781049600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytec800ctstjkqa85lw1u', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1769551200000, '1/28:
Information emailed and received for updates within the task orders of the Contract Agile from the CO.
Agile Decision Sciences supports (Library and Records Management) - 68HERD23D0003, the original amount of the contract is $160,086,284, with pop of 11/1/2022 - 10/31/2027.
As of 1/28/2026, there are twenty-two (22) task orders under Agile, they are listed below:
68HERD23F0041, pop 2/1/2023 – 1/31/2026 – total amount is $2,298,050.00, funding remaining - $925,326.00
68HERD23F0043, pop 2/1/22023 – 1/31/2026 – total mount is $291,583.00, funding remaining - $82,231.00 68HERD23F0044, pop 4/1/2023 – 3/31/2026 – total amount is $13,066,044.00, funding remaining - $163,719.00 68HERD23F0060, pop 3/1/2023 – 2/28/2026 – total amount is $3,316,107.00, funding remaining - $1,351,210.00 68HERD23F0072, pop 4/1/2023 – 3/31/2026 – total amount is $413,296.00, funding remaining - $167,536.00 68HERD23F0073, pop 4/1/2023 – 3/31/2026 – total amount is $201.492.00, funding remaining - $8,903.00 68HERD23F0086, pop 5/1/2025 – 4/30/2026 – total amount is $291,607.00, funding remaining - $44,135.00 68HERD23F0087, pop 4/1/2023 - 3/31/2026 – total amount is $1,897,218.00, funding remaining - $793,699.00 68HERD23F0090, pop 4/1/2023 - 3/31/2025 – total amount is $1,273,655.00, funding remaining - $776,942.00 68HERD23F0091, pop 4/1/2023 – 4/30/2026 – total amount is $603,135.00, funding remaining - $244,503.00 68HERD23F0100, pop 5/1/2023 – 4/30/2026 – total amount is $598,925.00, funding remaining - $267,569.00 68HERD23F0101, pop 5/1/2023 – 4/30/2026 – total amount is $4,208,928.00, funding remaining, $1,687,237.00 68HERD23F0102, pop 5/1/2023 – 4/30/2026 – total amount is $1,519,356.00, funding remaining, $837,846.00 68HERD23F0107, pop 5/1/2023 – 4/30/2026 – total amount is $1,238,192.00, funding remaining, $565,528.00 68HERD23F0111, pop 5/1/2023 – 4/30/2026 – total amount is $1,146,698.00, funding remaining, $476,660.00 68HERD23F0113, pop 5/1/2023 – 4/30/2026 – total amount is $3,166,074.00, funding remaining, $1,330,144.00 68HERD23F0117, pop 5/1/2023 – 4/30/2026 – total amount is $656,547.00, funding remaining, $309,929.00 68HERD23F0123, pop 6/1/2023 – 5/31/2025 – total amount is $609,589.00, funding remaining, $370,480.00 68HERD24F0012, pop 12/4/2023 – 1/3/2026 – total amount is $947,661.00, funding remaining, $573,681.00 68HERD25F0083, pop 6/25/2025 – 6/24/2026 – total amount is $6,770,712.00, funding remaining $6,325,207.00 68HERD26F0008, pop 4/30/2026 – 4/30/2028 – total amount is $6,046,514.00, funding remaining $5,976,514.00 68HERF26F0001, pop 1/1/2026 – 4/30/2026 – total amount is $2,351,787.20, funding remaining $2,256,787.20.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769558400000, 1769558400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteck00cvstjk67j1krij', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1739311200000, '2/10:
No update to present', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739145600000, 1739145600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytecx00cxstjktm4gawj1', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1709071200000, '2/24:
This is for the IMCS V Contract concerning record keeping and storage.
From Ryan Philbrick, this is a follow up email to the conversation that we had yesterday, about potential cost savings at the agency. As part of an ongoing effort to quantify and document agency wide cost savings associated with centralizing paper records management activities at the National Digitization Centers (NDCs), we are requesting some assistance in obtaining some acquisition documents for the ICMS contract.
Specifically, we are requesting copies of the Performance Work Statements and Independent Government Cost Estimates for all active and recently completed task orders under the ICMS vehicle. We want to analyze the material in order to try to quantify the cost savings we could potentially realize by centralizing the management of paper records storage, handling, file room operations, cataloging, and other records management services.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1708732800000, 1708732800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytedb00czstjk4804q0cx', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1678827600000, '3/9
Task Order Contract Value $ 687,978.70
Task Order Funding Value $ 210,000.00
% of Funding Spent 35.71%
Funding Required to Complete EAC $ 477,978.70', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1678320000000, 1678320000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytedm00d1stjk20tx8532', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1648587600000, '3/24
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1648080000000, 1648080000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytedw00d3stjk0416dcmt', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1618347600000, '4/09
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1617926400000, 1617926400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytee700d5stjk4nui5n66', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1588107600000, '4/21
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1587427200000, 1587427200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteej00d7stjkx0jkxc6d', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1556658000000, '4/30
We meet with the CO on the IMCS V contract to discuss some procedural issues, and the upcoming re-compete. I will be sending out info on the re-compete early next year.  I was asked by the CO to gently remind the TCORs of the following:
All PRs for option exercise should be submitted 90 days prior to end of current POP.
Once a task order expires, the option cannot be exercised.
Lack of an option exercise does not result in a stop work; it results in a task order ending.
A stop work cannot be used in leu of an option exercise.
If the option is not exercised by end of current POP, the task order must be re-competed, and no work will be done until a new task order is awarded.
TOCORs are responsible for tracking their funding and submitting PRs prior to funding deficit.  Incremental funding should be submitted 45 days prior to required obligation.
All PRs should be routed to COR for review before submitting to CO.
Approved Compliance memos are required to be submitted as attachments to all EAS actions.
I intend to set up a monthly “Office Hours” meeting in Teams soon, to allow for any issues, concerns or questions you may have. You do not need to wait for Teams office hours if you have an immediate question, feel free to call, teams chat or email me any time. Thank you so much for your ongoing support.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1556582400000, 1556582400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteet00d9stjkyqzxokmb', 'import-shela-poke-williams', 'import-contract-be12f0eecafb0baa6f69f8dd', NULL, NULL, 1527627600000, '5/19
No updates', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1526688000000, 1526688000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytefp00dcstjkgzqs7wm1', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1781643600000, '6/10
No Update
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781049600000, 1781049600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytefy00destjk92yfnl1p', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1769551200000, '01/28:
Daycom (Records Management Services Superfund, and Library Services) – 68HERD23D0001, the original amount of Daycom contract was $ 203,052,645.00, with pop of 11/01/2022 – 10/31/2027. As of 1/28/2026, there are six (6) task orders under Daycom they are listed below:
68HE0523F0013 Region 5 GLNPO, pop is 2/1/2023 - 12/31/2027, total amount $437,292.96, funding remaining- $184,335.84.
68HE0523F0031 Region 5 Superfund, pop is 3/20/2023 - 2/29/2028, total amount $2,784,814.11, funding remaining- $1,246,318.32.
68HERD23F0112 Region 4 Superfund- pop is 5/1/2023 - 4/30/2028, total amount is $2,954,240.64, funding remaining- $1,413,771.96.
68HE0823F0030 Region 8 Records Management, pop is 5/15/2023 - 5/14/2028, total amount is $4,525,040.52, funding remaining- $2,028,368.21.
68HE0325F0103 Region 3 Records Management, pop is 12/1/2025 - 11/30/2027, total amount is $2,119,163.04, funding remaining- $2,041,443.87.
68HE0726F0017 Region 10 Library Services, pop is 12/1/2025 - 4/30/2028, total amount is $397,011.30, funding remaining- $384,478.75.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769558400000, 1769558400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteg500dgstjkdw0in33k', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1739311200000, '2/10:
No update to present.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739145600000, 1739145600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytegg00distjk7j98iu0v', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1709071200000, '2/24:
This is for the IMCS V Contract concerning record keeping and storage.
From Ryan Philbrick, this is a follow up email to the conversation that we had yesterday, about potential cost savings at the agency. As part of an ongoing effort to quantify and document agency wide cost savings associated with centralizing paper records management activities at the National Digitization Centers (NDCs), we are requesting some assistance in obtaining some acquisition documents for the ICMS contract.
Specifically, we are requesting copies of the Performance Work Statements and Independent Government Cost Estimates for all active and recently completed task orders under the ICMS vehicle. We want to analyze the material in order to try to quantify the cost savings we could potentially realize by centralizing the management of paper records storage, handling, file room operations, cataloging, and other records management services.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1708732800000, 1708732800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytegr00dkstjkhfq53zq4', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1678827600000, '3/9
1 CLIN 2001 – 01 January 2026- 31 January 2026 $49,219.58 $49,219.58
TOTAL DUE $49,219.58
Option Year 2:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1678320000000, 1678320000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteh100dmstjkie95ih5m', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1746565200000, '5/1/2025-4/30/2026
Remaining Funds Allocations $147,658.78
Total Contract Amount $590,635.00
Funds Allocated 33.33%
Total Funded $590,635.00 Total Amount Billed $49,219.58', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1746057600000, 1746057600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytehc00dostjknyf48k81', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1742936400000, '3/24
No Update', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1742774400000, 1742774400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteho00dqstjk96rdnu8v', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1712696400000, '4/09
No Update', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1712620800000, 1712620800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytehy00dsstjk8q44bipn', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1682456400000, '4/21
No update', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1682035200000, 1682035200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytei800dustjktzbwwib6', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1652216400000, '4/30
We meet with the CO on the IMCS V contract to discuss some procedural issues, and the upcoming re-compete. I will be sending out info on the re-compete early next year.  I was asked by the CO to gently remind the TCORs of the following:
All PRs for option exercise should be submitted 90 days prior to end of current POP.
Once a task order expires, the option cannot be exercised.
Lack of an option exercise does not result in a stop work; it results in a task order ending.
A stop work cannot be used in leu of an option exercise.
If the option is not exercised by end of current POP, the task order must be re-competed, and no work will be done until a new task order is awarded.
TOCORs are responsible for tracking their funding and submitting PRs prior to funding deficit.  Incremental funding should be submitted 45 days prior to required obligation.
All PRs should be routed to COR for review before submitting to CO.
Approved Compliance memos are required to be submitted as attachments to all EAS actions.
I intend to set up a monthly “Office Hours” meeting in Teams soon, to allow for any issues, concerns or questions you may have. You do not need to wait for Teams office hours if you have an immediate question, feel free to call, teams chat or email me any time. Thank you so much for your ongoing support.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1651276800000, 1651276800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteih00dwstjkvaefesvm', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1621976400000, '5/19
No updates
New Awards and Recompetes
Wednesday, June 5, 2024
10:02 AM
Upcoming Procurement
Contract End Date
PALT Start
Submit APP (PALT + 2 weeks)
Engagement Meeting
Submit SRO (APP + 2 weeks)
Submit CGER (SRO + 2 Weeks)
Notes
Adobe', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1621382400000, 1621382400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteis00dystjkifhxb1ia', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1796162400000, '11/26/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1795651200000, 1795651200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytej300e0stjk81rxsuyz', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1780434000000, '5/26/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779753600000, 1779753600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteje00e2stjkpetcou16', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1781643600000, '6/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytejp00e4stjkp6x3o150', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1779224400000, '5/13/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1778630400000, 1778630400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytek200e6stjkpnb4dtmw', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1779224400000, '5/19/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779148800000, 1779148800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytekg00e8stjk57lfqyum', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1774386000000, '3/20/2026
IMCS-V', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773964800000, 1773964800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteks00eastjk9cetftcd', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1825189200000, '10/31/2027', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1824940800000, 1824940800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytel600ecstjkwfv5ncut', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1778014800000, '4/30/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777507200000, 1777507200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytelj00eestjk4pq6b9zx', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1776805200000, '4/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776297600000, 1776297600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytely00egstjkxr8zeunp', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1776805200000, '4/9/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775692800000, 1775692800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytemc00eistjkuek6ka5e', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1775595600000, '4/2/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775088000000, 1775088000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytemp00ekstjkm7quysxy', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1774386000000, '3/19/2026
Confirm PALT
MD - T-Mobile', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773878400000, 1773878400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyten100emstjk7uvnllm3', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1782853200000, '6/30/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782777600000, 1782777600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytenf00eostjkjceryyzk', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1775595600000, '3/30/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774828800000, 1774828800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytent00eqstjk1ux5x1h1', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1774386000000, '3/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773619200000, 1773619200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteo800esstjkzttn0oqq', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1773176400000, '3/9/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773014400000, 1773014400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteol00eustjk5mxv5c0r', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1773176400000, '3/2/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytep000ewstjkmm506mp1', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1771970400000, '2/16/2026
MD - Verizon', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771200000000, 1771200000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytepk00eystjkl8b622nt', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1771970400000, '2/16/2026
MD - AT&T', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771200000000, 1771200000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteq700f0stjku6y0szw1', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1771970400000, '2/16/2026
MPS', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771200000000, 1771200000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteqn00f2stjks3hmysbg', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1799791200000, '12/31/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1798675200000, 1798675200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyter100f4stjk00puulev', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1786482000000, '7/30/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1785369600000, 1785369600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyterg00f6stjk35st5p2z', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1752613200000, '7/15/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784073600000, 1784073600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteru00f8stjk5e5hj9fb', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1752613200000, '7/9/2026
SRO submitted 6/17/2026
EO Compliance approved on 6/12/2026
ITI3', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1783555200000, 1783555200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytes700fastjks7glhyqh', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1820350800000, '8/27/2027', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1819324800000, 1819324800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytesl00fcstjk0uhk59l6', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1788901200000, '8/27/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1787788800000, 1787788800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytesz00festjk4uop5jdy', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1787691600000, '8/13/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1786579200000, 1786579200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteta00fgstjk0fej3d03', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1786482000000, '8/6/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1785974400000, 1785974400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytetk00fistjkcansh5ms', 'import-shela-poke-williams', 'import-contract-050f0bd7f3153f89a03aad6f', NULL, NULL, 1753822800000, '7/16/2026
IA
FedEx and UPS Shipping
ITI-3 ()
Sunday, May 31, 2026
7:04 PM', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784160000000, 1784160000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteuh00flstjkxklr23i3', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '6/1: Working on IGCE to get compliance memo started.  There are 7 task orders that did not transfer to Brad Werwick''s office and we do not have access to them in EAS.  We are working to get the documentation for them in order to complete the IGCE.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteus00fnstjkry9mwe4x', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '6/1:  FITARA is not required for this recompete, determined in previous recompete that this was not an IT program
FY27 Adobe ELA
Wednesday, April 22, 2026
2:50 PM
Adobe ELA (Michelle)
Current POP Expiration: 11/26/2026
Ultimate Contract Expiration: 11/26/2026
Contract Number: NNG15SD38B
Order Number:
COR: Michelle Cuilla /Alt: Adam VanEnwyck
CO/CS: Brad Werwick/Kaela Back
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytev200fpstjkt51bt52f', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1778014800000, '4/24/2026
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776988800000, 1776988800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytevb00frstjkbqd12ung', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1781643600000, '6/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytevl00ftstjkjkn5079n', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1781643600000, '6/05/2026
APP/Milestones Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780617600000, 1780617600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytevt00fvstjkuhspd3l2', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1782853200000, '6/29/2026
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782691200000, 1782691200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytew200fxstjkcz58qequ', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1752613200000, '7/05/2026
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1783209600000, 1783209600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytewb00fzstjk88tpg9z0', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1752613200000, '7/10/2026
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1783641600000, 1783641600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytewl00g1stjkap9lcvru', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1753822800000, '7/20/2026
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784505600000, 1784505600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytewu00g3stjkcljpczt2', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1786482000000, '7/30/2026
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1785369600000, 1785369600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytex400g5stjk3rv0p1bw', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1796162400000, '11/26/2026
Current Updates
Date 6/2/26
FITARA Approved.
IGCE Completed.
Zero dollar PR created:  PR-OFA-26-00304
EO Compliance Form Approved.
Market Research Completed.
SRO Approval – Approved 6/2.
APP was sent on 6/16.
Past Updates:
Date 5/19/26
FITARA Approved.
IGCE Completed.
Zero dollar PR Completed.
EO Compliance Form Approved.
Market Research Completed.
SRO-being reviewed by Garrett 5/19.
Meeting with Contracts 5/13.
FedEx and UPS Shipping
Tuesday, February 24, 2026
4:20 PM
FedEx and UPS Shipping – BPA Call Order (Adam)
Current POP Expiration: TBD
Ultimate Contract Expiration: TBD
Contract Number: TBD
COR: Adam VanEnwyck
CO/CS:  TBD
EAS Date
Milestone
Actual Date
CMS Forecast
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1795651200000, 1795651200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytexd00g7stjkenelxgsr', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1752613200000, '07/10/2026
APP/Milestones Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1783641600000, 1783641600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytexn00g9stjk4zn4fubw', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1753822800000, '07/17/2026
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784246400000, 1784246400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytexx00gbstjko5k0e64z', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1753822800000, '07/24/2026
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784851200000, 1784851200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytey700gdstjk2cj4vacy', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1787691600000, '08/14/2026
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1786665600000, 1786665600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteyg00gfstjkhaaok0r9', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1788901200000, '08/28/2026
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1787875200000, 1787875200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteyp00ghstjkv6s1o01m', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1790110800000, '09/11/2026
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1789084800000, 1789084800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqyteyy00gjstjk755y6d73', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1791320400000, '09/30/2026
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1790726400000, 1790726400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytez700glstjkgycwetf3', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '06/01/2026:
Updated CMS Forecast Dates
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytezf00gnstjklomo956j', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1778014800000, '05/04/2026:
Adam reviewed proposed changes to the SOW template.  This review generated more process questions for the BPA COR.
Adam to submit additional questions to BPA COR (Rob Fox) by end of week', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytezo00gpstjkc87asd24', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1776805200000, '04/21/2026:
Adam met with Terri 3/17/2026 to address questions, discuss BPA Call Order requirement, and pay current shipping invoices via CC
Adam to submit questions to BPA COR (Rob Fox) by end of week', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytezx00grstjkhy31243p', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1774386000000, '03/24/2026:
Adam met with Terri 3/17/2026 to address questions, discuss BPA Call Order requirement, and pay current shipping invoices via CC
Adam to submit questions to BPA COR (Rob Fox) by end of week', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf0600gtstjkgmrd3q00', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1773176400000, '03/02/2026:
Adam met with Terri''s team 2/25/2026 to address questions, discuss BPA Call Order requirement
Terri''s team to review notes and confirm questions for BPA COR.
Once questions are confirmed/formalized, Adam will send to BPA COR (Rob Fox)
Shredding Contract
Tuesday, April 07, 2026
8:37 AM
Shredding Contract (Adam)
Current POP Expiration: TBD
Ultimate Contract Expiration: TBD
Contract Number: TBD
COR: Adam VanEnwyck
CO/CS:  TBD
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received
APP Submitted
APP/Milestones Approved
Solicitation Issued
Solicitation Closes
TEP Complete
Final Proposals
Award
* NOTE:  Table not updated because order likely not necessary.
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf0e00gvstjkvpngbhni', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1748984400000, '6/01:  No new update.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1748736000000, 1748736000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf0o00gxstjkctud2qaq', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1746565200000, '5/04:  * No contract or purchase order anticipated at this time.  RTP Facilities has a shredding event planned for NCC in July.  COR confirmed with Facilities that the shredding event planned for the NCC will apply to confidential business information.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1746316800000, 1746316800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf0x00gzstjkhtw6ktu1', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1745355600000, '4/21:  RTP Facilities has a shredding event planned for NCC in July.  COR reached out to confirm event can accommodate confidential documents.  Awaiting confirmation.
MPS Recompete
Tuesday, February 24, 2026
4:20 PM
MPS Recompete - (Dawn)
Current POP Expiration: TBD
Ultimate Contract Expiration: TBD
Contract Number: TBD
COR:  Dawn Lamb
CO/CS:  TBD
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1745193600000, 1745193600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf1700h1stjk7hp34bnu', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '5/29/2026
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780012800000, 1780012800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf1e00h3stjka746upyu', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1781643600000, '6/16/2026
APP/Milestones Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781568000000, 1781568000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf1p00h5stjkw9gcpt5n', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1753822800000, '7/16/2026
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1784160000000, 1784160000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf1y00h7stjkxnyeztx4', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1792530000000, '10/14/2026
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1791936000000, 1791936000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf2600h9stjk3ph2nw20', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1793743200000, '10/31/2026
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1793404800000, 1793404800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf2f00hbstjk4clk4l5j', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1794952800000, '11/15/2026
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1794700800000, 1794700800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf2p00hdstjk5ly3vx8n', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1796162400000, '11/30/2026
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1795996800000, 1795996800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf2z00hfstjkfu0ht821', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1797372000000, '12/15/2026
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1797292800000, 1797292800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf3700hhstjk0jt0iesr', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1782853200000, '06/18:
EO Compliance was approved on 6/12/2026.
Request for SRO Approval was submitted on 6/16/2026.
Request for FITARA approval was submitted on 6/17/2026.
COR is currently working on APP.
COR revised PWS to add task of monitoring non lexmark printers per Program''s Office request.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1781740800000, 1781740800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf3i00hjstjkli5lqfdg', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '06/02:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780358400000, 1780358400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf3t00hlstjk3r3v56v1', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '6/1:  Both IT Service Branch Section and Endpoint Services Branch have concluded that the task of Print Queue Management will be added to new MPS Contract Recompete.
Sent draft MPS PWS out that reflects this added PWs and waiting on everyone approval by 6/3/2026.
EO Compliance was submitted for approval.
COR Is currently working on drafting the FITARA', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf4500hnstjkn8aaypmr', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '05/29:
COR revised added additional data to reflect the back billing charges for FY26 printers that was  never billed.
COR finalized IGCE.  COR is now drafting EO Compliance form to submit by June 1, 2026.
Both Endpoint Services Branch and IT Service Branch are currently determining which contract will complete task of Print Queue Management (mtg scheduled for 6/1/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780012800000, 1780012800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf4i00hpstjkaam6euji', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '5/27:
COR Scheduled meeting to meet with ESSET Engineering to discuss the current section of MPS PWS included a section called "EPA Service Desk Priority Levels".  COR requested ESSET Engineer to update this section and to send a more recent copy of the "MPS Incident Ticket Handling Process"   document by Tuesday, June 2, 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779840000000, 1779840000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf4u00hrstjk7n7qze70', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1780434000000, '5/21:
COR scheduled a meeting to meet with the Endpoint Services Branch and IT Service Branch to resolve which Contract (MPS or ESSET) will be assigned the task of Print Queue Management.
Some discussion was skill set and cost.  That is could cost more for ESSET to complete task.
Program Office found the task was success having ESSET complete the task.
Conclusion to meeting indicated more discussions were needed as it was still not determined which contract will be completing this task.
COR asked for a resolution soon so recompete milestones are not delayed.
Separate discussion was made between Branch Chiefs.
COR scheduled a meeting for Monday, June 1, 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1779321600000, 1779321600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf5500htstjkqw5dcc5s', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1778014800000, '04/30:
COR is pulling data from previous FY and analyzing data, while creating a draft IGCE.
COR requested from Service Management team data on non Lexmark printers for FY24, FY25, and FY26.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777507200000, 1777507200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf5g00hvstjkwyn5dmpg', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1778014800000, '04/23:
COR is working on market research.
COR is researching GSA for Managed Print Service vendors.   COR will reach out to vendors is not enough information is listed.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776902400000, 1776902400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf5s00hxstjkl9cwnxmb', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1776805200000, '4/18:  COR Submitted PWS to the Program office to get their review and edits.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776470400000, 1776470400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf6400hzstjk3sin8e6y', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1775595600000, '03/27:
COR made minor edits to PWS.
COR is reviewing older notes and meeting with ESSET COR to discuss moving printers.
Legacy Contracts
Thursday, January 15, 2026
2:06 PM
Feb. 2026 Printer Accessories Order for FY26
Wednesday, February 18, 2026
10:24 AM
Printer Refresh and Accessories (Dawn)
Current POP Expiration:   - A.R.O. 45 days
Ultimate Contract Expiration:  - A.R.O. 45 days
Contract Number:   68HERF26P0034
COR: Dawn Lamb
CO/CS:  Kaela Back
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received
n/A
APP Submitted
n/a', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774569600000, 1774569600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf6h00i1stjka6tbkfp6', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1763503200000, '11/16/25
APP/Milestones Approved
n/a', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763251200000, 1763251200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf6u00i3stjk20m0nvk2', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1764712800000, '12/01/25
Solicitation Issued
n/a', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1764547200000, 1764547200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf7900i5stjkw5xruasj', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1765922400000, '12/16/25
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765843200000, 1765843200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf7m00i7stjkvj1bos62', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1773176400000, '3/2/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf7z00i9stjkpv5p2gyx', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1767132000000, '12/31/25
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767139200000, 1767139200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf8b00ibstjkjhsedjsj', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1774386000000, '3/20/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773964800000, 1773964800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf8o00idstjknevhaujx', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1769551200000, '01/15/26
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768435200000, 1768435200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf9200ifstjkfyz2xqlk', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1771970400000, '02/14/26
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771027200000, 1771027200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf9f00ihstjklv0q29wu', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1774386000000, '3/20/2026
Current Updates:`', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773964800000, 1773964800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytf9s00ijstjkes2jibyf', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1744146000000, '4/1:  Invoice approved by COR in IPP.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1743465600000, 1743465600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfa600ilstjk9epwqaj4', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1742936400000, '3/23:  Invoice received and COR approved invoice in IPP', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1742688000000, 1742688000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfak00instjkizzu44vr', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1742936400000, '3/20:  2 staples finishers were received and confirmed by Landover Warehouse.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1742428800000, 1742428800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfax00ipstjk490vu487', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1742936400000, '3/20:  Contract fully awarded', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1742428800000, 1742428800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfbb00irstjkdluo8oaz', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1740520800000, '2/18:  COR submitted PR (PR-OFA-26-00302) for 2 printer accessories (internal stapler Finishers) for Lexmark 833G printer – for 2 offices (OIG and another Ofc. @ HQ).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739836800000, 1739836800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfbr00itstjkale6hyzq', 'import-shela-poke-williams', 'import-contract-65355f1c5465ef3091ebbb1b', NULL, NULL, 1740520800000, '2/17  Program office expedited an order for 2 internal staple finishers and can be installed with installation.  Both finishers – one for HQ (OIG) and the other for printer in inventory.
COR completed necessary paperwork for PR to be submitted, waiting on FCO to give LOA.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739750400000, 1739750400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfd300iwstjkomujuuql', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1752613200000, '7/3: Pending Second Part(new CSI) award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1783036800000, 1783036800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfdh00iystjkme15vo41', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1753822800000, '7/19: Needed to answer questions from GSA to Award und NASA SEWP; Will be awarded on Friday, July 19, 2024', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1752883200000, 1752883200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfdu00j0stjkoh4j6psa', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1722373200000, '7/30: Clarity regarding new licenses (Oracle New CSI) obtained after further conversation with Oracle.  Expected award date is Friday 8/9.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1722297600000, 1722297600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfe800j2stjk0taryvag', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1692133200000, '8/9: EPAs Oracle team met with Oracle and now have clarity to complete the Order.  (est. Completion date is 8/16)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1691539200000, 1691539200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfem00j4stjk7jhd6r0v', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1660683600000, '8/16 Oracle Part 2 New CSIs pending award just waiting on vendor to respond', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1660608000000, 1660608000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfey00j6stjkcexaftpz', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1630443600000, '8/23 (Part 2)  Quote came back for $750K; need to amend the PR to add additional $45K', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1629676800000, 1629676800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytffd00j8stjkp2ex4gm2', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1598994000000, '8/30 (Part 2) Oracle Awarded', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1598745600000, 1598745600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytffq00jastjkkliorfoc', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1568754000000, '9/6 N/A', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1567728000000, 1567728000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfg300jcstjkdodd2rpj', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1538514000000, '9/20 N/A', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1537401600000, 1537401600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfgk00jestjk4xm57l88', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1508274000000, '10/8:   ORACLE is scheduling a meeting soon with Technical Customer to discuss OLAP, and confirm the need.  ORACLE wants to ensure the customer is making correct decision on purchasing CSI licenses (price range 50K to 60K).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1507420800000, 1507420800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfgy00jgstjkia2l3w8u', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1478034000000, '10/22 Meeting with Oracle schedule 10/24', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1477094400000, 1477094400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfhd00jistjk5dbnkrsr', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1446588000000, '11/1 Conducted Meeting and there is no need to add extra CSI', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1446336000000, 1446336000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfhr00jkstjku05omqqt', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1416348000000, '11/15 Waiting on the updated CSI list to start the APP for FY25 renewal', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1416009600000, 1416009600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfi300jmstjkt2pmgdxu', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1388527200000, '12/20 (Michelle Cuilla) awaiting updated CSI list from Tim Richards. Once CSI list is received, will be able to proceed with APPs and PRs', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1387497600000, 1387497600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfih00jostjksyc5tttn', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1357077600000, '12/31: Sergey took over as COR from Michelle
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1356912000000, 1356912000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfiu00jqstjk34749n9f', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1328047200000, '01/27: No new updates on this contract. See "2025 ORACLE" for the follow-on contract for calendar year 2025.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1327622400000, 1327622400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfq500khstjk5ewdwk9m', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1416348000000, '11/15 Waiting on the updated CSI list to start the APP for FY25 renewal.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1416009600000, 1416009600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfqj00kjstjklf7c6f27', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1388527200000, '12/20 awaiting updated CSI list from Tim Richards. Once CSI list is received, will be able to proceed with APPs and PRs.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1387497600000, 1387497600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfqx00klstjkmgv3cf1k', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1357077600000, '12/31  Sergey took over as the COR from Michelle.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1356912000000, 1356912000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfra00knstjkt32ld2jh', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1326837600000, '01/10 OITO/EOD expected to provide updated CSI list by COB 01/10.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1326153600000, 1326153600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfrm00kpstjkssyaku9z', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1295388000000, '01/17 EOD (Tim Richards/Alan M) now expect to have CSI list complete no earlier than 1/24; the team they are waiting on for additional information has requested an extension until 1/24.  Alan also indicated there is a new requirement for a small purchase for new licenses with the renewal.  At this point, EOD estimates the renewal cost be about $4.1M, assuming an 8% mark-up of the costs from last year.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1295222400000, 1295222400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfrz00krstjkgj9h5yzr', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1265148000000, '01/28: Initial Oracle Procurement Package has been submitted - APP-OMS-25-00013 and $0 Planning PR PR-OMS-25-00395 have both been routed for review with IGCE at $4,720,028.80. SRO approval received. CS should finish his review sometime this week, and CO will begin his review after that.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1264636800000, 1264636800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfsf00ktstjk4abk7t5o', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1234908000000, '02/11: FITARA approved 02/04, and PR PR-OMS-25-00395 amended to include FITARA approval. Updated CSI list received from SME, and COR is working with SME to finalize new IGCE. CS/CO review still ongoing with goal to produce a milestone chart in the next two weeks. Funding should be available to submit funded PR shortly.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1234310400000, 1234310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfsr00kvstjkrgd2y59c', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1204668000000, '02/25: Updated CSI list/IGCE provided to CO with guidance on understanding CSI List/IGCE provided by SME. CO review of APP and $0PR still ongoing. CS has submitted 1900-37 Small Business Review Form to OSDBU for review. ITAD is advising a total small business set aside, and approval is expected quickly. CS has advised that funded PR should be submitted within the next week, and COR has begun the process to submit funded PR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1203897600000, 1203897600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytft500kxstjk3rvw7t7c', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1174424400000, '03/11: RFQ set to close at 09:00am on 03/17. Once quote is received, funding and LOAs can be added to PR-OMS-25-00596. EO Compliance Review form received and attached to PR. Awaiting SRO approval and quote to proceed with PR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1173571200000, 1173571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytftk00kzstjk93gii1e9', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1144184400000, '03/25: RFQ closed 03/23. PR-OMS-25-00596 has been routed for approval. SRO pre-approval is received and signed EO Compliance Review form is attached. PR will route up through SRO for official approval. Quote sent to TPOC. License QTYs have been accepted, and agency is going back to vendor/Oracle to clarify terminations.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1143244800000, 1143244800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfty00l1stjko8egy92t', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1113944400000, '4/08: EPA FY25 Consolidated Oracle Procurement awarded 03/31. COR confirmed with TPOC that no additional FY25 license procurement should be required.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1112918400000, 1112918400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfua00l3stjk9yetm3wq', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1083704400000, '04/22: EPA FY25 Consolidated Oracle Procurement awarded 03/31. COR confirmed with TPOC that no additional FY25 license procurement should be required. Unless there is another FY25 procurement action, there should not be another update until we begin working on the FY26 procurement in September.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1082592000000, 1082592000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfuo00l5stjka9xe2cxb', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1052254800000, '05/06: COR confirmed with TPOC that no additional FY25 license procurement should be required. Unless there is another FY25 procurement action, there should not be another update until we begin working on the FY26 procurement in September.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1052179200000, 1052179200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfv100l7stjkkq3sozfy', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1023224400000, '05/29: CPARS for the previous versions of the Oracle contract were assigned to Sergey and completed in CPARS.gov.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1022630400000, 1022630400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfve00l9stjksuzshpf9', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 992984400000, '06/17: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 992736000000, 992736000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfvr00lbstjks796wvpp', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 962744400000, '06/30: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 962323200000, 962323200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfw300ldstjk2tjncuhj', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 932504400000, '07/14: Paid the submitted vendor invoices for the last quarter.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 931910400000, 931910400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfwh00lfstjkc517nwqu', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 902264400000, '07/31: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 901843200000, 901843200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfwu00lhstjkvxlioo9r', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 872024400000, '08/12: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 871344000000, 871344000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfx700ljstjkknzd5szr', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 841784400000, '08/27: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 841104000000, 841104000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfxk00llstjkdrqszue2', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 811544400000, '09/10: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 810691200000, 810691200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfxx00lnstjko6o3x76p', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 781304400000, '09/22: No updates.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 780192000000, 780192000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfyb00lpstjk443srlyr', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 751064400000, '10/07: Garrett and Sergey began developing the APP for the contract''s renewal in April 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 749952000000, 749952000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfyp00lrstjkznxyyx3w', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 719614800000, '10/21: Garrett took the lead on developing the APP for the contract''s renewal in April 2026; Sergey serves as his backup.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 719625600000, 719625600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfz300ltstjknae5qww5', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 689378400000, '11/03: Garrett took the lead on developing the APP for the contract''s renewal in April 2026; Sergey serves as his backup.
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 689126400000, 689126400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytfzi00lvstjkj348j5ed', 'cmpx2emsj0001788vfgr7eaal', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 666396000000, '02/10: No new updates. Garrett took the lead on developing the APP for the contract''s renewal in April 2026; Sergey serves as his backup.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 666144000000, 666144000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg0t00lystjkmdwwz6xe', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1770760800000, '2/11:  COR approved invoice for Ladover Warehouse – that excluded a damaged printer.  Waiting on next steps for damaged pritner to be delivered to Landover Warehouse.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770768000000, 1770768000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg1700m0stjkx3rdw2tu', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1759870800000, '10/7:  COR created a PR mod to add installation to printer refresh order for Regions 3 and 4.  COR is waiting on Line of Accounting to come in from the Finance team.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759795200000, 1759795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg1j00m2stjknw06vaad', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1729630800000, '10/14:  COR created sharepoint site for all POC @ regions, HQ, and RTP to access documents pertaining to printer deliveries.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1728864000000, 1728864000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg1z00m4stjkaulu1a50', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1698181200000, '10/15:  COR submitted PR to MOD existing contract award for installation in 2 regions (4 locations).  PR-OMS-26-00007 – MODP0001.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1697328000000, 1697328000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg2c00m6stjks9u1t3ad', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1666731600000, '10/22:  Shipping and delivery are suspended until shutdown is over.  COR is waiting to hear about delivery to only the Landover Warehouse.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1666396800000, 1666396800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg2p00m8stjkf5i6lz1f', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1636495200000, '11/3:  Later determined that Landover Warehouse will have someone available if EPA is fully involved with the Government shutdown.  Estimated delivery for Landover Warehouse will happen the week of November 17, 2025.  Landover Warehouse has a contractor who is essential and will be notified via email with a definite delivery date.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1635897600000, 1635897600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg3300mastjk6wv776i7', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1606255200000, '11/17:
COR met with Vendor to resume processing printer order and resume delivery as Government shutdown concluded.
Requested a document from Vendor to reflect information needed for installations (in Region 3 and 4).
MOD is still in pending status as Vendor has not signed the MOD for installation (Region 3 and 4).  Vendor felt the MOD needed a location correction.  Waiting for CO to respond to Vendor.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1605571200000, 1605571200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg3g00mcstjkr2iozhc7', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1574805600000, '11/26:
Printers were delivered and received @ Landover Warehosue (Hyattsville, MD), with one printer still missing as its on backorder (833).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1574726400000, 1574726400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg3u00mestjkr4cw36yl', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1544565600000, '12/3:
Printers were delivered and received @ Region 1 (Boston, MA).  Will wait for them to scan and confirm serial #s to ensure they match what the vendor had.
REGION 1 - Certificate of Insurance was filled out by ATI (Carrier) and now with Region 3 Facilities team (building owner).   Printers will not be picked up by ATI - carrier (from warehouse) until an appointment is scheduled.  Waiting for Reg. 1 to give next steps.
Region 1 will send COR and Program Office the serial #s scanned to ensure it matches what the vendor sent.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1543795200000, 1543795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg4800mgstjkql23zlkj', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1515535200000, '1/5:
Received all printers except for Philadelphia, PA Region 3.  Waiting for the carrier to confirm a date and time to deliver that should happen this week.
COR obtaining pictures of damaged printer and box that needs to be replaced.  This damaged printer originally was received in Landover warehouse that was transferred to the COOP.  COOP found it damaged once it was unpacked.  Waiting for next steps.
Received invoices for some of the printers and the COR needs to confirm the printer were received.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1515110400000, 1515110400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg4n00mistjk766my98d', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1485295200000, '1/21:  Damaged Printer was picked up', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1484956800000, 1484956800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg5000mkstjkt91gzot4', 'import-dawn-lamb', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1455055200000, '2/5:
COR approved invoices for printers delivered to Region 1 (Boston), Region 3 (Philadelphia and Ft. Meade), and Region 4 (Athens, GA and Atlanta, GA).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1454630400000, 1454630400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg6a00mnstjksmcr9vi0', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1770760800000, '2/10:  CO received comments from OGCE concerning Limited Source Justification (LSJ) for named source.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770681600000, 1770681600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg6o00mpstjks0m6igr3', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1762293600000, '11/3 Meeting with ITAD to map the recompete.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762128000000, 1762128000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg7400mrstjk7ymgksqt', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1734472800000, '12/15 COR submitted PR (PR-OFA-26-00141) but was delayed to routing issues.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1734220800000, 1734220800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg7j00mtstjkme9kibpi', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1705442400000, '1/5:  Due to EAS routing issues, COR resubmitted (PR-OFA-26-00141) and routed to Contracting Team.  The PR is for a recompete, with an anticipated award by March 2026.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1704412800000, 1704412800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg7w00mvstjk7npenubv', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1675202400000, '1/21: Approved compliance memo received.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1674259200000, 1674259200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg8900mxstjkvwwrei7y', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1643752800000, '1/28:  The PR is currently with CO, who is reviewing the APP (submitted in Sept. 2025) and Statement of Work (SOW).  The CO is new and asking the COR questions to
become more familiar with the contract.
EMDC (Enterprise Mobile Device Coverage) (Sergey)
Friday, May 31, 2024
12:40 PM
Extended Mobile Device Coverage
Move this to Legacy Contracts
COR: Sergey Minchenkov / Garrett Hayes
CO/CS: Scott Tharp / Tomeka Hall
Status: On Track
EAS Date
Milestone
Actual Date
CMB Forecast
FITARA Approval Received', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1643328000000, 1643328000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg8l00mzstjkr5ok37wo', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1756242000000, '8/14/25
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1755129600000, 1755129600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg8x00n1stjkn70yvw52', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1756242000000, '8/18/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1755475200000, 1755475200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg9a00n3stjke2hokumb', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1763503200000, '11/16/25
APP/Milestones Approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763251200000, 1763251200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg9l00n5stjkln0exan8', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1764712800000, '12/01/25
Solicitation Issued', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1764547200000, 1764547200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytg9w00n7stjkiu4jigb7', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1762293600000, '11/1/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761955200000, 1761955200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytga700n9stjk2ljzpk3k', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1765922400000, '12/16/25
Solicitation Closes', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765843200000, 1765843200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgak00nbstjkamc8ulab', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1763503200000, '11/15/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763164800000, 1763164800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgaw00ndstjkdpyovcfv', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1767132000000, '12/31/25
TEP Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767139200000, 1767139200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgb900nfstjkguhuar3s', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1765922400000, '12/15/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765756800000, 1765756800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgbm00nhstjk06d2cbdf', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1769551200000, '01/15/26
Final Proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1768435200000, 1768435200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgc000njstjkkllz8wgc', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1767132000000, '12/20/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766188800000, 1766188800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgcg00nlstjkf3xvziqa', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1771970400000, '02/14/26
Award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771027200000, 1771027200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgcu00nnstjkrab47g4j', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1767132000000, '12/31/25
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767139200000, 1767139200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgd500npstjkn8ilw4uv', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1739311200000, '02/10:
The BPAs with all three carriers - AT&T Mobility, Verizon Wireless, and T-Mobile USA - were awarded on 01/15/2026.
Individual EMDC call orders were awarded to AT&T on 01/28/2026 and Verizon on 01/29/2026, and performance under these call orders began on 02/01/2026.
Call orders will have the period of performance of 5 months ( = February to June 2026), so as to align them with the legacy T-Mobile contract''s timeframe:
As per the previous decision, EPA will continue to utilize the legacy T-Mobile contract until its expiration on 06/30/2026.
In February-March 2026, COR will work on developing the follow-on call orders for all three carriers that will start on July 1, 2026 and will potentially last multiple years.
Please see individual tabs for "Mobile - EMDC - AT&T" and "Mobile - EMDC - Verizon" for future updates.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1739145600000, 1739145600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgdk00nrstjko1fb9wul', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1728421200000, '10/07:
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy AT&T and Verizon contracts. (T-Mobile contract will run through 06/30/2026.)
Revised FITARA request is pending for the CIO''s approval. (All other parties reviewed the request and recommended approval.)
COR has been working with HQAD to address their comments and make revisions to the PWS.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1728259200000, 1728259200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgdy00ntstjkc24uu5yt', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1728421200000, '10/07:
HQAD committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy AT&T and Verizon contracts. (T-Mobile contract will run through 06/30/2026.)
On 10/16/2025, HQAD acknowledged that they have the necessary paperwork (PWS, etc.) to begin the procurement process.
HQAD plans to release the solicitation to the industry by the end of October.
HQAD plans to conduct the TEP review in early December.
Revised FITARA request is pending for the CIO''s approval. (All other parties, including the CTO, reviewed the request and recommended approval.)', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1728259200000, 1728259200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgea00nvstjk10gj0c3i', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1699394400000, '11/03:
HQAD is still committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contract.
Revised FITARA request was approved by the CIO on 10/22/2025.
RFQ for the EMDC procurement was issued to the industry on 10/30/2025.
HQAD is working to secure three BPAs with all three major carriers (AT&T, T-Mobile, Verizon Wireless).
TEP is expected to be conducted in early December.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698969600000, 1698969600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgek00nxstjkaju7rdqk', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1669154400000, '11/18:
HQAD is still committed to awarding the revised EMDC contract by 12/31/2025, i.e. prior to the expiration of the legacy contracts.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1668729600000, 1668729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytges00nzstjkozbdws8u', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1762293600000, '10/30/2025 - RFQ for the EMDC procurement was issued to the industry.
HQAD is working to secure three BPAs with all three major carriers (AT&T, T-Mobile, Verizon Wireless).', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1761782400000, 1761782400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgez00o1stjkm0xuftnf', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1763503200000, '11/07/2025 - Vendors'' follow-up questions were received by HQAD and forwarded to OITO', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762473600000, 1762473600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgf700o3stjkylfdiwoj', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1763503200000, '11/12/2025 - OITO provided responses to the vendors'' questions to HQAD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1762905600000, 1762905600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgfg00o5stjkqhrnh9qy', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1763503200000, '11/17/2025 - HQAD received additional follow-up questions from the vendors
As of 11/18/2025, COR is working with OITO''s SMEs to provide the answers', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1763337600000, 1763337600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgfp00o7stjkwqacyu7q', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1765922400000, '12/05/2025 (tentative) - Due date for the vendors'' technical and price proposals', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1764892800000, 1764892800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgfy00o9stjkncqeeie8', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1765922400000, '12/10/2025 (tentative) - TEP reviews will begin', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1765324800000, 1765324800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgg600obstjkblem7qct', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1767132000000, '12/31/2025 (tentative) - EMDC contract award date.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1767139200000, 1767139200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytggd00odstjkapznaunx', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1767132000000, '12/29:
On 12/16/2025, HQAD committed to awarding the EMDC Blanket Purchase Agreements with three carriers by 12/31/2025.
As of 12/29/2025, HQAD has not made the award yet, but the path forward that prevents lapse in mobile support is as following:
In January 2026, we will continue to use legacy mobile contracts:
We will continue to use the legacy T-Mobile contract till its expiration on 06/30/2026. On 12/22/2025, the contract was incrementally funded with $350K to cover costs through February 2026.
Legacy AT&T contract was extended for the month of January 2026 on 12/22/2025.
Legacy Verizon contract was extended for the month of January 2026 on 12/22/2025.
In February 2026, we will switch AT&T and Verizon to the EMDC contract:
PRs to initiate and fund the AT&T (PR-OFA-26-00124) and Verizon (PR-OFA-26-00125) call orders under EMDC were submitted to HQAD on 12/29/2025.
The goal is to award the call orders by 01/31/2026 (and HQAD had previously requested the processing time of one month for these actions).
Call orders will have the period of performance of 5 months ( = February to June 2026), so as to align them with the legacy T-Mobile contract.
In February-March 2026, COR will work on developing the follow-on call orders for all three carriers that will start on July 1, 2026 and will potentially last multiple years.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1766966400000, 1766966400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytggl00ofstjkct7k833t', 'import-kim-farmer', 'import-contract-614f28f4029854f21450b5c7', NULL, NULL, 1738101600000, '01/29:
The BPAs with all three carriers - AT&T Mobility, Verizon Wireless, and T-Mobile USA - were awarded on 01/15/2026.
As of 02/01/2026, we will switch AT&T and Verizon to the EMDC contract:
Call orders will have the period of performance of 5 months ( = February to June 2026), so as to align them with the legacy T-Mobile contract''s timeframe:
Call order with AT&T was enacted on 01/28/2026.
Call order with Verizon is expected to be enacted on 01/29/2026:
Verizon submitted their proposal for the call order on 01/26, and revised their proposal after a series of conversations with the COR and the Contract Specialist on 01/28.
COR reviewed the proposal, and submitted the evaluation to the Contract Specialist on 01/28.
Call order is expected to be awarded today (01/29).
As per the previous decision, EPA will continue to utilize the legacy T-Mobile contract until its expiration on 06/30/2026.
In February-March 2026, COR will work on developing the follow-on call orders for all three carriers that will start on July 1, 2026 and will potentially last multiple years.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1738108800000, 1738108800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytghc00oistjka1yr3sa7', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1769551200000, '01/27: Awarded 01/14. No updates until award effort. These will start again around 10/25.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769472000000, 1769472000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytghj00okstjkhwhjt2wf', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1759870800000, '10/8 Renewal efforts will begin towards the end of October as this is due to appropriated funds being used.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759881600000, 1759881600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytghq00omstjku3k3dcm3', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1729630800000, '10/22 Pending/verification of subscriptions from Tiffany before requesting a quote.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729555200000, 1729555200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytghy00oostjknzirowzt', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1699394400000, '11/1 Waiting on Quote from vendor before submitting documents and PR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698796800000, 1698796800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgi600oqstjk589mwcdn', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1669154400000, '11/15 Submitted the funding PR for renewal for $168k', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1668470400000, 1668470400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgif00osstjkipvuahhc', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1638914400000, '12/2: No updates for the current task order.  New award status is under the New Awards and Recompetes Infotech report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1638403200000, 1638403200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgin00oustjkuvl40zgr', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1608674400000, '12/16: No updates for the current task order.  New award status is under the New Awards and Recompetes Infotech report.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1608076800000, 1608076800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgiv00owstjkwzsu25qw', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1578434400000, '12/30: Contracting office notified me that the new award will not be in place by 10 January.  They requested that a modification to extend the current PoP be created.  Contractor stated an extension is not possible, however, notified the CO that if they were willing to provide a notice of intent for the new award, they would continue services.  The CO has not responded.  I''m following up.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1577664000000, 1577664000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgj300oystjk05yuakqr', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1548194400000, '01/14: Awarded 01/14.
PC (Laptops) Refresh (Kim)
Tuesday, January 21, 2025
9:28 AM
COR:  Kim Farmer
CO/CS:  Brad Werwick
Status:  On Track
High-Level Maintenance:
EAS Date
Milestone
Actual Date
CMB Forecast
N/A
FITARA Approval Received
GSA Attached to APP', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1547424000000, 1547424000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgjb00p0stjk06cng1rj', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/15/25
APP Submitted', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736899200000, 1736899200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgjn00p2stjkwy3of9fx', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/10/2025
N/A
APP/Milestones Approved
N/A', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736467200000, 1736467200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgjv00p4stjkwta9uf86', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/14/25
Market Research Complete', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736812800000, 1736812800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgk400p6stjkn2zp1jtg', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/10/25', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736467200000, 1736467200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgkc00p8stjk50cpk8s1', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/15/25
Zero Dollar PR', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736899200000, 1736899200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgkj00pastjkj0czix38', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/15/25
N/A
TEP Complete
N/A (GSA Schedule)
N/A
Award
N/A (GSA Schedule)
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736899200000, 1736899200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgkr00pcstjk1z5mgzqz', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/15:  Planning PR (PR-OMS-25-00387) submitted for approval to include IGCE that lists the quote for the entire year.  Currently with Will, and then route to Tiffany and Vaughn.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736899200000, 1736899200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgky00pestjkcnhkq2ym', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1736892000000, '1/14: Funding PR (PR-OMS-25-00379) submitted for 1st order.  Waiting on funding to be available.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1736812800000, 1736812800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgl600pgstjkv8ljusg0', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1706652000000, '1/21:
PC refresh. Planning PR submitted last Wednesday PR-OMS-25-00387
Funding PR submitted last Tuesday PR-OMS-25-00379
Funding PR is on hold at Carla’s request. Michelle Wiggins has and is waiting on funding to be available.
Planning PR is in approval route, currently with the Contracting Office.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1705795200000, 1705795200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgld00pistjkhd2rdl77', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1675202400000, '1/27 SRO approved memo', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1674777600000, 1674777600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytglk00pkstjkxmxlzmap', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1675202400000, '1/27 APP updated and resubmitted with COR nomination.
Planning PR is in ITAD.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1674777600000, 1674777600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgls00pmstjki8c8s3w8', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1644962400000, '2/12 Waiting on Funding approval to purchase laptops.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1644624000000, 1644624000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytglz00postjkafppaawy', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1615928400000, '3/11:  PR is on hold and waiting on new compliance memo to be signed.
4//9: Updated IGCE and count submitted for DOGE review and signature', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1615420800000, 1615420800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgm700pqstjkrc6dlkis', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1586898000000, '4/15: EO memo approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1586908800000, 1586908800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgmf00psstjkj2d06exq', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1555448400000, '4/16: final package submitted to ITAD for award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1555372800000, 1555372800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgmn00pustjkauf5ymwx', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1525208400000, '4/29: Awarded PR-OMS-25-00379', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1524960000000, 1524960000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgmz00pwstjkndvjnd1t', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1503435600000, '8/18 received quote and IGCE, compliance memo submitted.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1503014400000, 1503014400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgn800pystjkbktvezkz', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1473195600000, '8/25 Compliance memo approved', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1472083200000, 1472083200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgng00q0stjkpc4pv9dj', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1440536400000, '8/26 PR-OMS-25-01159 submitted for final CY 25 buy $5,881,912.52', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1440547200000, 1440547200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgnp00q2stjk3wtzioc7', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1410296400000, '9/09 Awarded
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1410220800000, 1410220800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgny00q4stjkzrhl00lu', 'import-garrett-hayes', 'import-contract-f3407cda0843798fd3d706e6', NULL, NULL, 1771970400000, '02/17/26 PR OFA-26-00301 submitted for FY 26 first laptop buy', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgos00q7stjkoqyttpaz', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, NULL, 1773176400000, '3/11:  The Task order will not have option year 2 exercised.  A new task order is set to be issued by May 1, 2025 will include both Headquarters and RTP.
This task order ends 4/30/25, it will not be renewed
Past Updates:
FFP task order was fully funded on 04/25/2024 for current option period.  no further updates expected until March of 2025 for next option period award', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773187200000, 1773187200000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgp100q9stjkub63z6l5', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, NULL, 1727211600000, '9/25/2024 no updates expected until March of 2025.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1727222400000, 1727222400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgpb00qbstjkcp0qbv2y', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, NULL, 1705442400000, '1/15:  COR and CO finalized evaluation criteria after several exchanges.  COR and CMB Chief currently reviewing CO''s comments for SOW, and COR will respond to CO Tuesday, 1/21.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1705276800000, 1705276800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgpm00qdstjksqaqq90u', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, NULL, 1675202400000, '1/28:  No updates.
Current Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1674864000000, 1674864000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgpv00qfstjk1jzpbhq4', 'import-kim-farmer', 'import-contract-d3b1aa0179954f23527943d1', NULL, NULL, 1647378000000, '3/11:  The Task order will not have option year 2 exercised.  A new task order is set to be issued by May 1, 2025 will include both Headquarters and RTP.
This task order ends 4/30/25, it will not be renewed', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1646956800000, 1646956800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgqy00qistjkw0ypsmiu', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1774386000000, '3/17:  Fully awarded Contract # 68HERF26F0048.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1773705600000, 1773705600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgrb00qkstjk1r3l04og', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1769551200000, '1/27:  EO Compliance form was submitted for approval in the amount of $$2,674,940.46.  COR is completing other documentation that is required for PR.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1769472000000, 1769472000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgrn00qmstjkgfepbh50', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1770760800000, '2/11/26 Tech office submitted revised IGCE increasing cost to $2,704,288.86', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770768000000, 1770768000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgry00qostjkzelao8ai', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1771970400000, '2/12/26 revised compliance memo submitted for additional cost', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770854400000, 1770854400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgsc00qqstjkpqf7sbie', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1771970400000, '2/13/26 approved Compliance memo for increase received.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1770940800000, 1770940800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqytgsq00qsstjkhg7q1s8p', 'import-kim-farmer', 'import-contract-c36e2aadda827ded8c159f09', NULL, NULL, 1771970400000, '2/17/26 PR-OFA-26-00301 submitted to FCO.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdkn10002q4el6azpss15', 'demo-contributor', 'import-contract-d30fe6889e2da89ade70e94c', NULL, NULL, 1780434000000, 'Status update for 2024 Printer Refresh and Accessories: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1782239491261, 1782239491261);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdkn10003q4elj6oxf2re', 'demo-contributor', 'import-contract-d30fe6889e2da89ade70e94c', NULL, NULL, 1781643600000, 'WAR update for 2024 Printer Refresh and Accessories: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1782239491261, 1782239491261);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdkng0006q4elown6w94c', 'demo-contributor', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1780434000000, 'Status update for 2025 ORACLE: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1782239491276, 1782239491276);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdkng0007q4el0h29esb2', 'demo-contributor', 'import-contract-baf0be6e5b1e6094b8e3775d', NULL, NULL, 1781643600000, 'WAR update for 2025 ORACLE: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1782239491276, 1782239491276);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdknv000aq4elyr6yeoq9', 'demo-contributor', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1780434000000, 'Status update for 2025 Printer Refresh 2nd Order CY24: requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1782239491291, 1782239491291);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqqzdknv000bq4el2wl1wm4r', 'demo-contributor', 'import-contract-f0484471e8858bfc2db838ff', NULL, NULL, 1781643600000, 'WAR update for 2025 Printer Refresh 2nd Order CY24: draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1782239491291, 1782239491291);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r29s001qq4eluwdct1q2', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1780434000000, '06/01:
Exercise Option Period 2
COR notified CO of intent to exercise Option Period 2 on 6/1/2026
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only.  Completed (Sat) May 30, 2026
eBusiness Enhancements
#20216 - Enhanced Search - Search all collections
#20167 - Exception Report for Account CPIC Specific IT Code vs Funding Profile:  COR to set up meeting with requestor to discuss requirements
#20181 - PR Module: Modify PR proportional buttons on IT Distribution Tab to Prevent Variances by Tower:  Meeting set up (6/10 with requestor to discuss requirements
Snow API (Status)
EISDSUPT Orders/Deprovisions: This will be deployed in the 10.02 release
Orders Payload for IPL Basic and IPL Core - Testing in DEV environment in-process, SNOW was put on-hold 05/21.
508 Compliance:
Rico Grids currently being re-written with Sencha EXTJS Infinite Grid
Mobile Device Refresh – As of early this afternoon, 19 people still need to sign their acknowledgement form. Leidos has been assisting the MD Support team with device refresh questions. 1,910 registrations have been updated with new device information to date.
Workflow request for SRO and facilities approval of location moves
eBusiness  has provided LOE and estimate to Facilities, awaiting decision.
Cross Charging Enhancement Proposal – A meeting has been scheduled for June 4th to further discuss EPA’s proposal of the requirement.
Workflow change request from Deputy CIO to change remote location selection.
Willie reviewed proposed solution with Deputy CIO.  eBusiness team is waiting for further direction.
Past Updates:', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1780272000000, 1780272000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r29y001sq4el75kk31ed', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1778014800000, '05/04:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
eBusiness 10.01 Application Server, Windows OS, Apache WS and impacted code only.  Target release date (Sat) May 30, 2026 – Testing underway
eBusiness Enhancements
#20216 - Enhanced Search - Search all collections
#20167 - Exception Report for Account CPIC Specific IT Code vs Funding Profile
#20181 - PR Module: Modify PR proportional buttons on IT Distribution Tab to Prevent Variances by Tower
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Mobile Device Refresh – As of early this 4/30/26, 28 people still need to sign their acknowledgement form. Leidos has been assisting the MD Support team with device refresh questions. 1,379 registrations have been updated with new device information to date.
Workflow request for SRO and facilities approval of location moves
COR to review proposed cost with Section Manager
Cross Charging Enhancement Proposal – A meeting has been scheduled for May 19 to further discuss EPA’s proposal of the requirement', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1777852800000, 1777852800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2a5001uq4el6jddjrfk', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1776805200000, '04/21:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s).
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Budget module training 4/6/2026
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1776729600000, 1776729600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2ab001wq4elwl9dglsb', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1775595600000, '04/07:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s).
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Budget module training 4/6/2026
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1775520000000, 1775520000000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2ah001yq4eld2dm42va', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1774386000000, '03/24:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
10.0 Release – Plans are to Deploy on April 7, 2026 – This will include the eBusiness facelift and the ability for Account Managers to initiate registration transfers to their account(s). Leidos demonstrated the facelift in the March CAG meeting held yesterday.  Larry will request an AppScan on Monday, March 23rd.
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”.  This will satisfy the open security vulnerability POAM.
eBusiness Enhancements
#20176 – Make PRs Editable for the Creator and the First Approver – Approved as written. The team also discussed allowing approvers (up to the FCO approval step) to make changes and require reapproval.  It was decided that this could get messy and cause considerable back and forth with a PR. PRs are easy to create and rejected PRs can be copied.  Modifying the copy buttons to prevent negative variances by tower was also discussed. Brandi noted the buttons often provide problematic results for PRs created after the initial PR. Jimmy requested that Brandi provide requirements for consideration.
#20165 - Add Field to Account Screen to Indicate CPIC Specific IT Codes Required – Approved for use one code two characters in length.
#20166 - Display Account CPIC Specific IT code on PR Screen – Approved
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Adobe – Migrated AD groups from Org specific groups to agency level groups for each product – Completed 19 March 2026.  The migration went smoothly with the exception of Adobe Acrobat Pro.  There was an issue associated with there being more than 10,000 licenses that had to be addressed.  The issue has been resolved.
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
Leidos presented a brief demo to the CAG during the March meeting.
Release planned for April 7th
eBusiness Budget Module
Initialize FY2027 Budget Planning data and establish a schedule. – Completed 03/11/2026
CCMgrInput step – Opened 03/16/2026', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1774310400000, 1774310400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2ap0020q4eltci23h7y', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1773176400000, '03/02:
Incoming Political Appointee Support
Leidos providing continuous monitoring of PSS and eBusiness (High Priority).
eBusiness Application Enhancement:
eBusiness Releases
9.16.03 Maintenance Release – Deployed on February 24, 2026 – The updates were database only changes.  Highlights include Budget allocation enhancements, making Adobe AD group levels at the Agency level rather than by organization, the new CE process enhancements, and adding phone numbers to the ArcGIS views.
9.17 is now 10.0
10.0 Release – Plans are to Deploy on April 7, 2026 – This should include the eBusiness facelift. Leidos plans on demonstrating this in the March CAG meeting.
eBusiness 10.0 will include ColdFusion 2021 Update 23 with a roll-back of the search package to 330334.  This is to support eTMS #20036 – “Update Excel Apache POI Functions to support changes in ColdFusion 2021 Update 21”
This will satisfy the open security vulnerability POAM.
Snow API (Status)
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions – deployed 2/24
Future Enhancements - Orders Payload for IPL Basic and IPL Core (SN waiting for approval)
Enhance Continuous Evaluations (CE) - Deployed in the 9.16.03 released on February 24th.  March billing will include adjustments back thru FY25
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in March 2026
Additional updates to home page, forms, buttons
Brief Demo – Leidos will target doing a brief demo for the CAG in March.
CT Lite (Regions 5 & 8)
Pre-kickoff strategic planning meeting in March.
eBusiness Budget Module
Need to initialize FY2027 Budget Planning data and establish a schedule.  Tentative plans are to initialize after FY26 BE updates have been completed and revised rates have been finalized.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1772409600000, 1772409600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2aw0022q4elmrnlrx3d', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1771970400000, '02/17:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
EBusiness Application Enhancement:
eBusiness Releases
9.16.02 Maintenance Release – Scheduled 2/24/2026
Budget allocation enhancements,
Making Adobe AD group levels at the Agency level rather than by organization, and
Snow API (Status)
9.15 Enhancements:
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions
Future Enhancements:
Orders Payload for IPL Basic and IPL Core (waiting for SN DEV)
FY27 Forecasting workshops
Two Teams sessions on April 14 (9:30 AM and 2:00 PM).
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in March 2026
Additional updates to home page, forms, buttons
Brief Demo – Leidos will target doing a brief demo for the CAG in March.
CT Lite (Regions 5 & 8)
Target implementation in February (Leidos).
Chris contacted Michelle Graf re additional Regions; no response yet.
Many Regions pushing back; consider alternate management/billing approach. CTREG FY2026 usage counts down across the board (Craig).
eBusiness Budget Module
Initialize FY2027 planning mid–late February after FY26 BE updates and rate finalization.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1771286400000, 1771286400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2b60024q4eldth2z08g', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1759870800000, '10/06:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
DRP (Groups 2 [1,732] and 3)/VERA Personnel - Leidos received an updated DRP 3.0 list on Tuesday and cancelled DA and MW registrations for all personnel with administrative leave dates of September 30th or prior. HR has moved most of the DRP personnel to OMS and put them in the OMS-OHCO-RCD-PSB-PSSB office.
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
Leidos continuing to work.  Follow up meeting scheduled for 10/8.
MS products available in eBusiness Phase 2:
No new update
SNOW API:
CT/MP – Orders, Cancellations, Moves all in production
MP – Location moves – Test with release 9.15
MD Cancellations – Test with release 9.15
MD Rescinded Cancellations – Test with release 9.15', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1759708800000, 1759708800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2bc0026q4elp2f0h6ho', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1729630800000, '10/21:
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
Phone services (IPLCORE and IPLBASIC) want RITMs via API to be created
eBusiness Modernization/Facelift – moving forward after progress demo feedback
508 Compliance – Phase 1 was completed as part of release 9.14; more compliance enhancements will be in future releases, including 9.15.  Some are on hold because they will be addressed with the facelift.
ColdFusion Update 21 Hotfix status
Adobe ColdFusion Enterprise 2023 - Leidos attended a meeting with Timothy Adobe (Timothy Pontier) on October 8th. Adam noted EPA will buy the license for eBusiness and Leidos no longer needs to explore buying it under ODCs.
XACTA – eBusiness CMA Year 1 assessment update – Currently reviewing the revisions/changes required in XACTA for NIST 800-53 Rev 5. Meeting weekly with Eric Maule, the assigned POC. Michelle Gyimah is the accessor that has been assigned to eBusiness for the CMA Y1 review.  It was determined that the dates in the email were incorrect and the eBusiness assessment dates are:
PBC Submissions due:                                     October 30, 2025
Assessment begins:                                          November 10, 2025
Assessment testing concludes on:                      TBD
Assessment package delivery by:                       TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1729468800000, 1729468800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2bk0028q4el00snxp60', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1699394400000, '11/03:
Funded through January 10th, 2026
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
New Enhancement – Orders payload for LF products IPLCORE nad IPLBASIC - #20094 assigned.
eBusiness Modernization/Facelift – moving forward after progress demo feedback.
Adobe ColdFusion Enterprise 2023 - EPA will procure the necessary licence,  Leidos will no longer purchase via ODC.
XACTA – eBusiness CMA Year 1 assessment update – Currently reviewing the revisions/changes required in XACTA for NIST 800-53 Rev 5. Meeting weekly with Eric Maule, the assigned POC. Michelle Gyimah is the accessor that has been assigned to eBusiness for the CMA Y1 review.  It was determined that the dates in the email were incorrect and the eBusiness assessment dates are:
PBC Submissions due:                                     October 30, 2025
Assessment begins:                                          November 10, 2025
Assessment testing concludes on:                      TBD
Assessment package delivery by:                       TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1698969600000, 1698969600000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2br002aq4elsucjki1s', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1673992800000, '01/05:
Mod P00006 awarded 12/12/2025
Mod. Changes CO to Kaela Back
Funded through January 10th, 2026
Funding PR-OFA-26-00072 assigned to  new CO (Kaela Back) on 12/22/2025
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
Information Management (IM) Activity (ongoing meetings/Status) – Carla Diaz is now the IM Activity Manager.  Ongoing weekly meetings are continuing for now.
EBusiness Application Enhancement:
eBusiness Releases
9.15 Release – Scheduled Tuesday, 11/18
Snow API (Status)
9.15 Enhancements:
MP Location Moves
Include ‘Special Instructions’ with CT Moves
Include decal/SN with MP orders when available
MD cancellations and rescinds
New Enhancement – Orders payload for LF products IPLCORE and IPLBASIC - #20094 assigned.
eBusiness Modernization/Facelift – eBusiness team to provide demo to operations group and CAG.  Tentatively scheduled for Feb. 2026.
Adobe ColdFusion Enterprise 2023 - EPA procured the necessary license,  Leidos will no longer need to purchase via ODC.
XACTA – eBusiness CMA Year 1 assessment update – Complete / No vulnerabilities found.', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1672876800000, 1672876800000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r2bz002cq4eleecbpvgo', 'import-adam-vanenwyck', 'import-contract-8e811cb28d5f5d3761ca5634', NULL, NULL, 1643752800000, '01/29:
Mod P00008 awarded 01/28/2026
Mod. Incrementally fund Option Period through May 1st
Incoming Political Appointee Support
Leidos providing continuous support (High Priority).
EBusiness Application Enhancement:
eBusiness Releases
9.16.02 Maintenance Release – Scheduled 2/24/2026
Budget allocation enhancements,
Making Adobe AD group levels at the Agency level rather than by organization, and
CE process enhancements
Snow API (Status)
9.15 Enhancements:
Add New VDI Product VDIELITE to API Integration for Orders and Deprovisions
Future Enhancements:
Orders Payload for IPL Basic and IPL Core (waiting for SN DEV)
eBusiness Modernization/Facelift:
eBusiness Menu, Home Page, Catalog and application color theme targeted for 9.17 in February/March
Additional updates to home page, forms, buttons
Brief Demo – Leidos reviewed the proposed color schemes on several screens with COR. COR approved the color changes.  Leidos will target doing a brief demo for the CAG in March..
Enhance Continuous Evaluations (CE)
Jon Merical has completed coding the business rules recently agreed upon with John Goldsby.  There are a significant number of complex cases that had to be programmed.  The updates have been moved to our QA environment for preliminary testing.
Adobe ColdFusion Enterprise 2023 – Development Team is reviewing 2023 for backwards compatibility. EPA has purchased the Adobe ColdFusion Enterprise 2023 license.  COR noted it can be per application, server or instance.  Per server likely would be the most cost-effective solution. Currently there are three virtual servers that support eBusiness.  Leidos will discuss further with EPA after development team completes the effort for backwards compatibility.
FY2026 rate recalculation – Leidos previously provided summarized EAC data to assist with this effort.  Budget Execution (BE) data is also being updated in eBusiness', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1643414400000, 1643414400000);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r35w0033q4el1reoceg1', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, NULL, 1782853200000, 'TrueTandem (Garrett)
Monday, June 22, 2026
9:01 AM
TrueTandem (Garrett) Current POP Expiration:
Ultimate Contract Expiration:
Contract Number:
COR: Garrett Hayes/ALT. COR:  Dawn Lamb
CO:  TBD
CS:  TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782241801386, 1782241801386);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0r36r0036q4elese1rril', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, NULL, 1782853200000, 'IMCS – V (Shela)
Monday, January 05, 2026
10:20 AM
Information Management Center  Services (IMCS) - V – 3 Task Orders
COR:  Shela Poke-Williams
Please review each subtab for each Task Orders
ABACCO Blackfish (Shela) - Contract Number: 68HERD23D0002
AGILE - Contract Number:  68HERD23D003
DAYCOM - Contract Number:  68HERD23D0001', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782241801413, 1782241801413);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0xkps005lq4elnvrogvr4', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, NULL, 1782853200000, 'TrueTandem (Garrett)
Monday, June 22, 2026
9:01 AM
TrueTandem (Garrett) Current POP Expiration:
Ultimate Contract Expiration:
Contract Number:
COR: Garrett Hayes/ALT. COR:  Dawn Lamb
CO:  TBD
CS:  TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782242104072, 1782242104072);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr0xkqg005oq4elbxgv08ph', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, NULL, 1782853200000, 'IMCS – V (Shela)
Monday, January 05, 2026
10:20 AM
Information Management Center  Services (IMCS) - V – 3 Task Orders
COR:  Shela Poke-Williams
Please review each subtab for each Task Orders
ABACCO Blackfish (Shela) - Contract Number: 68HERD23D0002
AGILE - Contract Number:  68HERD23D003
DAYCOM - Contract Number:  68HERD23D0001', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782242104095, 1782242104095);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr1es22007dq4elgg4oh8r6', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, NULL, 1782853200000, 'TrueTandem (Garrett)
Monday, June 22, 2026
9:01 AM
TrueTandem (Garrett) Current POP Expiration:
Ultimate Contract Expiration:
Contract Number:
COR: Garrett Hayes/ALT. COR:  Dawn Lamb
CO:  TBD
CS:  TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782242906744, 1782242906744);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr1es2o007fq4elc99cuduo', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, NULL, 1782853200000, 'IMCS – V (Shela)
Monday, January 05, 2026
10:20 AM
Information Management Center  Services (IMCS) - V – 3 Task Orders
COR:  Shela Poke-Williams
Please review each subtab for each Task Orders
ABACCO Blackfish (Shela) - Contract Number: 68HERD23D0002
AGILE - Contract Number:  68HERD23D003
DAYCOM - Contract Number:  68HERD23D0001', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782242906766, 1782242906766);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr1h7cg000311a3ngwzqfkf', 'import-garrett-hayes', 'import-contract-ca130e3ffe78ee6a16735530', NULL, NULL, 1782853200000, 'TrueTandem (Garrett)
Monday, June 22, 2026
9:01 AM
TrueTandem (Garrett) Current POP Expiration:
Ultimate Contract Expiration:
Contract Number:
COR: Garrett Hayes/ALT. COR:  Dawn Lamb
CO:  TBD
CS:  TBD', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782243019863, 1782243019863);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqr1h7d2000511a3mlrhanfk', 'import-shela-poke-williams', 'import-contract-43ff00ad21c61d3a413f4cf1', NULL, NULL, 1782853200000, 'IMCS – V (Shela)
Monday, January 05, 2026
10:20 AM
Information Management Center  Services (IMCS) - V – 3 Task Orders
COR:  Shela Poke-Williams
Please review each subtab for each Task Orders
ABACCO Blackfish (Shela) - Contract Number: 68HERD23D0002
AGILE - Contract Number:  68HERD23D003
DAYCOM - Contract Number:  68HERD23D0001', NULL, NULL, NULL, 'APPROVED', 0, NULL, NULL, NULL, NULL, 1782243019886, 1782243019886);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqsdr1wg0002au3u6e9kq8qz', 'demo-contributor', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1780434000000, 'Status update for AT&T (via EMDC) (call order): requirements review and milestone planning completed.', NULL, NULL, NULL, 'IN_REVIEW', 0, NULL, NULL, NULL, NULL, 1782324100960, 1782324100960);
INSERT INTO submissions (id, userId, projectId, componentId, contractId, weekOf, rawText, terseText, terseVersion, aiConfidence, status, isAiGenerated, editedBy, publishedAt, oneNotePageId, deletedAt, createdAt, updatedAt) VALUES ('cmqsdr1wg0003au3u7itmx1tm', 'demo-contributor', 'import-contract-b539f4fd85c22b1a2d0f63ba', NULL, NULL, 1781643600000, 'WAR update for AT&T (via EMDC) (call order): draft deliverables submitted and awaiting Program Overseer review.', NULL, NULL, NULL, 'SUBMITTED', 0, NULL, NULL, NULL, NULL, 1782324100960, 1782324100960);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmouegy8r000w90ud5j57ixzb', 'cmoudt700000490udj7pqy88k', 'demo-overseer', 'APPROVED', NULL, NULL, NULL, NULL, 1778092676955, 1778092676955);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmouejqqo001190ud1h4bj7vb', 'cmot2uw4m000vvqrvwsxljdis', 'demo-overseer', 'APPROVED', NULL, NULL, NULL, NULL, 1778092807201, 1778092807201);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmouept53001790ud5z1vxnmk', 'cmouep2rh001590udcwe5tekw', 'demo-overseer', 'APPROVED', NULL, NULL, NULL, NULL, 1778093090248, 1778093090248);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmouetx2p001i90udikvvghlc', 'cmoueqtz7001e90udfytucahq', 'demo-overseer', 'APPROVED', NULL, NULL, NULL, NULL, 1778093281969, 1778093281969);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmougrj9d000111fp5lch0zhf', 'cmouer8dj001g90ud2bgj7tkc', 'demo-overseer', 'APPROVED', NULL, NULL, NULL, NULL, 1778096529985, 1778096529985);
INSERT INTO reviews (id, submissionId, reviewerId, status, comment, originalText, editedText, editReason, createdAt, updatedAt) VALUES ('cmpx32jd70002fb2b3ab187sx', 'cmpx2fx3r0003jzb5l8uov8hc', 'demo-overseer', 'APPROVED', 'Cleared pending review by Program Overseer for current bi-weekly period.', NULL, NULL, NULL, 1780431709580, 1780431709580);
INSERT INTO workflow_states (id, submissionId, currentStage, assignedTo, dueDate, notes, updatedAt) VALUES ('cmoukjuer000c11fp61lhbuaz', 'cmoukhygp000811fp58khwdft', 'APPROVED', NULL, NULL, NULL, 1778102889648);
INSERT INTO workflow_states (id, submissionId, currentStage, assignedTo, dueDate, notes, updatedAt) VALUES ('cmp33j06g0006iza9r4eojchv', 'cmoukj6w3000a11fptfea8pmo', 'APPROVED', NULL, NULL, NULL, 1778618492582);
INSERT INTO workflow_states (id, submissionId, currentStage, assignedTo, dueDate, notes, updatedAt) VALUES ('cmpx33cya0005jzb5vzai9k6h', 'cmpx2emt60005788vw940jfvk', 'APPROVED', NULL, NULL, NULL, 1780431747921);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmouegy8z000y90udys49a82q', 'REVIEW_CREATED', 'demo-overseer', 'review', 'cmoudt700000490udj7pqy88k', '{"status":"APPROVED","reviewRecorded":true}', NULL, NULL, 1778092676963);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmouejqqt001390udkzz25umy', 'REVIEW_CREATED', 'demo-overseer', 'review', 'cmot2uw4m000vvqrvwsxljdis', '{"status":"APPROVED","reviewRecorded":true}', NULL, NULL, 1778092807205);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmouept58001990udk9e0ni9k', 'REVIEW_CREATED', 'demo-overseer', 'review', 'cmouep2rh001590udcwe5tekw', '{"status":"APPROVED","reviewRecorded":true}', NULL, NULL, 1778093090252);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmouetx2u001k90udlqlofgtc', 'REVIEW_CREATED', 'demo-overseer', 'review', 'cmoueqtz7001e90udfytucahq', '{"status":"APPROVED","reviewRecorded":true}', NULL, NULL, 1778093281974);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmougrj9j000311fpiykpy45t', 'REVIEW_CREATED', 'demo-overseer', 'review', 'cmouer8dj001g90ud2bgj7tkc', '{"status":"APPROVED","reviewRecorded":true}', NULL, NULL, 1778096529992);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmoukjuf3000e11fpumvidhif', 'SUBMISSION_APPROVED', 'demo-overseer', 'submission', 'cmoukhygp000811fp58khwdft', '{"approverName":"Demo Program Overseer"}', NULL, NULL, 1778102889664);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp1mrkqt0001errpl28yo29l', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"EIS"}', NULL, NULL, 1778529872837);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp1mrnck0003errpxwqsdyvi', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"BOB"}', NULL, NULL, 1778529876213);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp30b7zc0001oy0x7u7gcu4d', 'CONTRIBUTOR_SETTINGS_UPDATED', 'demo-overseer', 'system', NULL, '{"changedFields":["deadlineOverrideEnabled"]}', NULL, NULL, 1778613090597);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp30d7wa0005oy0xy52h6pcz', 'USER_ASSIGNED_TO_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"BOB"}', NULL, NULL, 1778613183803);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp30d9rl0007oy0xac3h9162', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"BOB"}', NULL, NULL, 1778613186226);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp33j06o0008iza90019tbwf', 'SUBMISSION_APPROVED', 'demo-overseer', 'submission', 'cmoukj6w3000a11fptfea8pmo', '{"approverName":"Demo Program Overseer"}', NULL, NULL, 1778618492592);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp33k84p000aiza9rrr6ihtt', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"EIS"}', NULL, NULL, 1778618549546);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp33krul000ciza9nz54ifdy', 'CONTRIBUTOR_SETTINGS_UPDATED', 'demo-overseer', 'system', NULL, '{"changedFields":["deadlineOverrideEnabled"]}', NULL, NULL, 1778618575101);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp43yas400013ipp5432nbdl', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"EIS"}', NULL, NULL, 1778679672339);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmp43ybmk00033ippjg17gyww', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"EIS"}', NULL, NULL, 1778679673436);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmpx32jd80004fb2b24mgwy37', 'SUBMISSION_APPROVED', 'demo-overseer', 'submission', 'cmpx2fx3r0003jzb5l8uov8hc', '{"source":"ops-script","reason":"Clear pending review for current bi-weekly submission","periodId":"2026-06-P1","approvedAt":"2026-06-02T20:21:49.580Z"}', NULL, NULL, 1780431709581);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmpx33cyf0007jzb508fei2f8', 'SUBMISSION_APPROVED', 'demo-overseer', 'submission', 'cmpx2emt60005788vw940jfvk', '{"approverName":"Demo Program Overseer"}', NULL, NULL, 1780431747927);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmpx4mrf70009jzb53f3z95vs', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'demo-contributor', '{"targetUserEmail":"contributor@demo.epa.gov","targetUserName":"Contributor","projectName":"EIS (Enterprise Infrastructure Services) Task Order"}', NULL, NULL, 1780434332756);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmpx4mu3u000bjzb5dsokm03i', 'USER_UNASSIGNED_FROM_PROJECT', 'demo-overseer', 'user', 'cmpx2emsj0001788vfgr7eaal', '{"targetUserEmail":"sergey.minchenkov@import.local","targetUserName":"Sergey Minchenkov","projectName":"EIS (Enterprise Infrastructure Services) Task Order"}', NULL, NULL, 1780434336234);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqxuat10017kj721bht5dss', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqxu9rv0003kj72i11l9qv7', '{"jobId":"cmqqxu9rv0003kj72i11l9qv7","mode":"dry-run","filesProcessed":38,"projectsUpserted":38,"assignmentsCreated":110,"submissionsCreated":276}', NULL, NULL, 1782236912437);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqxvlv7001qkj72co9hqhqz', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqxvkt40019kj72hwtn7zhh', '{"jobId":"cmqqxvkt40019kj72hwtn7zhh","mode":"dry-run","filesProcessed":15,"projectsUpserted":15,"assignmentsCreated":13,"submissionsCreated":276}', NULL, NULL, 1782236973427);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqxvyr400fckj72g4p7bl1a', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqxvwjd001skj72j984fxbe', '{"jobId":"cmqqxvwjd001skj72j984fxbe","mode":"apply","filesProcessed":15,"projectsUpserted":15,"assignmentsCreated":13,"submissionsCreated":229}', NULL, NULL, 1782236990129);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqybfun001q4skfxiepz0gs', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqybe3g00014skfgjrhmds8', '{"jobId":"cmqqybe3g00014skfgjrhmds8","mode":"dry-run","filesProcessed":59,"projectsUpserted":59,"assignmentsCreated":59,"submissionsCreated":920}', NULL, NULL, 1782237712128);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqyf5zh0018w1hw8fezkols', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqyf4hs0001w1hwhh6gk7ke', '{"jobId":"cmqqyf4hs0001w1hwhh6gk7ke","mode":"dry-run","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":41,"submissionsCreated":917}', NULL, NULL, 1782237885965);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqqytgzi00rzstjkl2xcodpv', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqqyt8iy0001stjkaat9pe4r', '{"jobId":"cmqqyt8iy0001stjkaat9pe4r","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":41,"submissionsCreated":461}', NULL, NULL, 1782238553406);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr0o9vj001kq4el20salg2k', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr0o8b3000dq4elsprxxkh4', '{"jobId":"cmqr0o8b3000dq4elsprxxkh4","mode":"dry-run","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":41,"submissionsCreated":917}', NULL, NULL, 1782241670143);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr0r41c004qq4elo7llybp0', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr0r0ke001mq4ele94z1q3m', '{"jobId":"cmqr0r0ke001mq4ele94z1q3m","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":41,"submissionsCreated":14}', NULL, NULL, 1782241802544);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr0xl1p0078q4elwozbx6ax', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr0xix0004sq4elx3u0kq1v', '{"jobId":"cmqr0xix0004sq4elx3u0kq1v","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":41,"submissionsCreated":2}', NULL, NULL, 1782242104525);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr1aiie001814b0ssl2yuaa', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr1ah0k000114b0f686v4oc', '{"jobId":"cmqr1ah0k000114b0f686v4oc","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":0,"submissionsCreated":0}', NULL, NULL, 1782242707767);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr1esdc008mq4ela0xc0vkj', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr1eqi9007aq4el74crvu1g', '{"jobId":"cmqr1eqi9007aq4el74crvu1g","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":1,"submissionsCreated":2}', NULL, NULL, 1782242907168);
INSERT INTO audit_logs (id, action, userId, resourceType, resourceId, metadata, ipAddress, userAgent, createdAt) VALUES ('cmqr1h7qh001c11a38pcondx8', 'DATA_IMPORTED', 'demo-admin', 'system', 'cmqr1h4ur000111a3r8r9ty9v', '{"jobId":"cmqr1h4ur000111a3r8r9ty9v","mode":"apply","filesProcessed":41,"projectsUpserted":41,"assignmentsCreated":0,"submissionsCreated":2}', NULL, NULL, 1782243020394);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqxu9rv0003kj72i11l9qv7', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 1, 'COMPLETED', 38, 38, 110, 110, 276, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Contract Management Section.docx#68HERD22F0007: no historical submissions parsed from source. | Contract Management Section.docx#68HERD24F0002: no historical submissions parsed from source. | Contract Management Section.docx#Verizon  (via EMDC) (call order): no historical submissions parsed from source. | Contract Management Section.docx#T-Mobile (Legacy Contract) (no call order @ this time): no historical submissions parsed from source. | Contract Management Section.docx#47QFCA22F0026: no historical submissions parsed from source. | Contract Management Section.docx#47QFCA22F0018: no historical submissions parsed from source. | Contract Management Section.docx#Oracle 2026: no historical submissions parsed from source. | Contract Management Section.docx#68HERD23F0049: no historical submissions parsed from source. | Contract Management Section.docx#68HERD24F0028: no historical submissions parsed from source. | Contract Management Section.docx#HHSN316201200065W: no historical submissions parsed from source. | Contract Management Section.docx#CO/CS:  Kaela Back: no historical submissions parsed from source. | Contract Management Section.docx#FITARA Approval Received: no historical submissions parsed from source. | Contract Management Section.docx#Solicitation Closes: no historical submissions parsed from source. | Contract Management Section.docx#Contract End Date: no historical submissions parsed from source. | Contract Management Section.docx#6/16/2026: no historical submissions parsed from source. | Contract Management Section.docx#MD - T-Mobile: no historical submissions parsed from source. | Contract Management Section.docx#3/16/2026: no historical submissions parsed from source. | Contract Management Section.docx#SRO submitted 6/17/2026: no assignee names found, existing assignments will be preserved. | Contract Management Section.docx#SRO submitted 6/17/2026: no historical submissions parsed from source. | Contract Management Section.docx#CO/CS: Brad Werwick/Kaela Back: no historical submissions parsed from source. | Contract Management Section.docx#11/16/25: no historical submissions parsed from source. | Contract Management Section.docx#Status: On Track: no historical submissions parsed from source. | Contract Management Section.docx#12/01/25: no historical submissions parsed from source. | Contract Management Section.docx#1/15/25: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782236911100, 1782236912423, 1782236911100, 1782236912431);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqxvkt40019kj72hwtn7zhh', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 1, 'COMPLETED', 15, 15, 13, 13, 276, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782236972056, 1782236973413, 1782236972056, 1782236973421);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqxvwjd001skj72j984fxbe', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 15, 15, 13, 13, 229, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782236987258, 1782236990117, 1782236987258, 1782236990125);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqybe3g00014skfgjrhmds8', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 1, 'COMPLETED', 59, 59, 59, 59, 920, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782237709852, 1782237712121, 1782237709852, 1782237712123);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqyf4hs0001w1hwhh6gk7ke', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 1, 'COMPLETED', 41, 41, 41, 41, 917, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782237884032, 1782237885954, 1782237884032, 1782237885956);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqqyt8iy0001stjkaat9pe4r', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 41, 461, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782238542442, 1782238553390, 1782238542442, 1782238553392);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr0o8b3000dq4elsprxxkh4', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 1, 'COMPLETED', 41, 41, 41, 41, 917, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782241668112, 1782241670135, 1782241668112, 1782241670137);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr0r0ke001mq4ele94z1q3m', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 41, 14, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782241798047, 1782241802531, 1782241798047, 1782241802537);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr0xix0004sq4elx3u0kq1v', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 41, 2, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782242101765, 1782242104513, 1782242101765, 1782242104520);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr1ah0k000114b0f686v4oc', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 0, 0, 'Contract Management Section (2).docx#EIS: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "cmoudozbe000090udqjfuddj7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#eBusiness: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-8e811cb28d5f5d3761ca5634",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#ESRI: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-e400ff653596ab4df65250ad",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#Mobile - EMDC - AT&T: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-b539f4fd85c22b1a2d0f63ba",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#Mobile - EMDC - Verizon: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-1175226adce593ff68fdde37",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#Mobile - EMDC - T-Mobile: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-d029e826a7d7aa31c028b829",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract): 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-a809fd21f697d457ab18ec72",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#Adobe ELA: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett-hayes",
      projectId: "import-contract-832e8c8ddb89f3f257fe9c8e",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Adobe ELA: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-832e8c8ddb89f3f257fe9c8e",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#EIS: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "cmoudozbe000090udqjfuddj7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#eBusiness: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-8e811cb28d5f5d3761ca5634",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#ESRI: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-e400ff653596ab4df65250ad",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Mobile - EMDC - AT&T: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-b539f4fd85c22b1a2d0f63ba",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Mobile - EMDC - Verizon: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-1175226adce593ff68fdde37",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Mobile - EMDC - T-Mobile: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-d029e826a7d7aa31c028b829",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract): 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-a809fd21f697d457ab18ec72",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#ESSET: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-michelle-cuilla",
      projectId: "import-contract-057dbdf775d573de25e7b743",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#MAINES: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-3a6aa924799c90ebc86046d3",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#HESC II: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn-lamb",
      projectId: "hesc-ii",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#ITSM/STAR Support: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-3cca6c65f4f89588245aa152",
      componentId: null,
      assignedBy: "demo-admin"
    },
    {
      userId: "import-adam",
      projectId: "import-contract-3cca6c65f4f89588245aa152",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-5f48f8cdadd6d7029a70c638",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#MPS: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn",
      projectId: "ebusiness",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#GAVETS 2: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-8bdd5dee44f90d09fd873e19",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#ITI III: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-michelle-cuilla",
      projectId: "iti-iii",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#DicksonOne: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-eae8e00c70a495083e0607af",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#TrueTandem: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-ca130e3ffe78ee6a16735530",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#IMCS – V: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-43ff00ad21c61d3a413f4cf1",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Abaco Blackfish: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-5c4031542012d126e56612ca",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Agile Decision Sciences: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-be12f0eecafb0baa6f69f8dd",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Daycom: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-050f0bd7f3153f89a03aad6f",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#IMCS-VI: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-65355f1c5465ef3091ebbb1b",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#2024 Oracle: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-baf0be6e5b1e6094b8e3775d",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#2024 Printer Refresh and Accessories: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-andrew",
      projectId: "import-contract-d30fe6889e2da89ade70e94c",
      componentId: null,
      assignedBy: "demo-admin"
    },
    {
      userId: "import-dawn",
      projectId: "import-contract-d30fe6889e2da89ade70e94c",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#2025 ORACLE: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-baf0be6e5b1e6094b8e3775d",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn",
      projectId: "import-contract-f0484471e8858bfc2db838ff",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Legacy Microsoft ELA: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim",
      projectId: "import-contract-614f28f4029854f21450b5c7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Infotech 2024: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-f3407cda0843798fd3d706e6",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Records Management – DC: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim-farmer",
      projectId: "import-contract-d3b1aa0179954f23527943d1",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh: 
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim",
      projectId: "import-contract-c36e2aadda827ded8c159f09",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782242705828, 1782242707757, 1782242705828, 1782242707761);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr1eqi9007aq4el74crvu1g', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 1, 2, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782242904753, 1782242907156, 1782242904753, 1782242907161);
INSERT INTO import_jobs (id, initiatedById, archiveName, archiveHash, dryRun, status, filesProcessed, projectsUpserted, usersUpserted, assignmentsCreated, submissionsCreated, warnings, errorMessage, startedAt, completedAt, createdAt, updatedAt) VALUES ('cmqr1h4ur000111a3r8r9ty9v', 'demo-admin', 'import-sources.zip', 'dd02dc7879beb56d5b8dd3797e6a2bb54281eea5', 0, 'COMPLETED', 41, 41, 41, 0, 2, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source. | Data Processing Activity.docx: no assignee names found, existing assignments will be preserved. | Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', NULL, 1782243016659, 1782243020377, 1782243016659, 1782243020386);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0004kj723oqxz8ot', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0005kj724qqr6itx', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 3, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0006kj72tahjaoue', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0007kj720osc163i', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0008kj72xgrlxuy4', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm0009kj72y0qmo4pz', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000akj72nk0mtdhy', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Orders Payload for IPL Basic and IPL Core', 'import-contract-2ff57a35df384ce743129385', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000bkj72cg3vl3y6', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000ckj729zvetnoy', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000dkj72docwmdor', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000ekj729pey3eqe', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasm000fkj72n3tuecit', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000gkj72w1z9mwqb', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000hkj72p7tn7twv', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#68HERD22F0007', 'Current and Active Contracts/Purchase Order Outlook', '68HERD22F0007', 'import-contract-9e3ab24252e49de8a02232e9', 'DRY_RUN', 'Dry run: changes were not written to the database.', 4, 4, 0, 'Contract Management Section.docx#68HERD22F0007: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000ikj72v0cqx2pe', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#68HERD24F0002', 'Current and Active Contracts/Purchase Order Outlook', '68HERD24F0002', 'import-contract-8d8d61c30777b3082944f826', 'DRY_RUN', 'Dry run: changes were not written to the database.', 5, 5, 0, 'Contract Management Section.docx#68HERD24F0002: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000jkj72e6pw4jnh', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Verizon  (via EMDC) (call order)', 'Current and Active Contracts/Purchase Order Outlook', 'Verizon  (via EMDC) (call order)', 'import-contract-82b68f959d408618650b2cc0', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Verizon  (via EMDC) (call order): no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000kkj72ny5b9pek', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#T-Mobile (Legacy Contract) (no call order @ this time)', 'Legacy Contracts', 'T-Mobile (Legacy Contract) (no call order @ this time)', 'import-contract-1b6495f99161425ef2228b62', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#T-Mobile (Legacy Contract) (no call order @ this time): no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000lkj722ls6l6ll', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#47QFCA22F0026', 'Current and Active Contracts/Purchase Order Outlook', '47QFCA22F0026', 'import-contract-6566e8307e372bc2a501bacd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 4, 4, 0, 'Contract Management Section.docx#47QFCA22F0026: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000mkj720cxup512', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#47QFCA22F0018', 'Current and Active Contracts/Purchase Order Outlook', '47QFCA22F0018', 'import-contract-90b702ce8834a9ddcd9e33cd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 4, 4, 0, 'Contract Management Section.docx#47QFCA22F0018: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000nkj72m6ospc1k', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Oracle 2026', 'Current and Active Contracts/Purchase Order Outlook', 'Oracle 2026', 'import-contract-4eba4acf02b3dea7a88499e1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Oracle 2026: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000okj72fq4yn8ng', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#68HERD23F0049', 'Current and Active Contracts/Purchase Order Outlook', '68HERD23F0049', 'import-contract-a6c615661aa3386c104c4d4b', 'DRY_RUN', 'Dry run: changes were not written to the database.', 4, 4, 0, 'Contract Management Section.docx#68HERD23F0049: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000pkj721req2mmm', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#68HERD24F0028', 'Current and Active Contracts/Purchase Order Outlook', '68HERD24F0028', 'import-contract-4514f1e0bd2cddca99afe22b', 'DRY_RUN', 'Dry run: changes were not written to the database.', 5, 5, 0, 'Contract Management Section.docx#68HERD24F0028: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000qkj72m5ymg3zc', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#HHSN316201200065W', 'Current and Active Contracts/Purchase Order Outlook', 'HHSN316201200065W', 'import-contract-61a066840808f0627c21fd9a', 'DRY_RUN', 'Dry run: changes were not written to the database.', 6, 6, 0, 'Contract Management Section.docx#HHSN316201200065W: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000rkj72vzzac8b6', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#CO/CS:  Kaela Back', 'Current and Active Contracts/Purchase Order Outlook', 'CO/CS:  Kaela Back', 'import-contract-21b80adff556c56ebddbdacb', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#CO/CS:  Kaela Back: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000skj72k91fr638', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#FITARA Approval Received', 'Current and Active Contracts/Purchase Order Outlook', 'FITARA Approval Received', 'import-contract-36298769d8ac8797ea8410fc', 'DRY_RUN', 'Dry run: changes were not written to the database.', 6, 6, 0, 'Contract Management Section.docx#FITARA Approval Received: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000tkj72a40cc8xu', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Solicitation Closes', 'Current and Active Contracts/Purchase Order Outlook', 'Solicitation Closes', 'import-contract-bc57bd4bc0f77ce41b3d309d', 'DRY_RUN', 'Dry run: changes were not written to the database.', 8, 8, 0, 'Contract Management Section.docx#Solicitation Closes: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000ukj72xdjo7myz', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Contract End Date', 'Current and Active Contracts/Purchase Order Outlook', 'Contract End Date', 'import-contract-d4eea3ba6a00f91cb847885a', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Contract End Date: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000vkj72h4afz7aw', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#6/16/2026', 'Current and Active Contracts/Purchase Order Outlook', '6/16/2026', 'import-contract-fedb58902dbd0e0ea98458a1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 9, 9, 0, 'Contract Management Section.docx#6/16/2026: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000wkj729l6cfqut', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#MD - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'MD - T-Mobile', 'import-contract-ea5fb93a9d04c07f06fb6904', 'DRY_RUN', 'Dry run: changes were not written to the database.', 7, 7, 0, 'Contract Management Section.docx#MD - T-Mobile: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000xkj72vnzkq3xc', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#3/16/2026', 'Current and Active Contracts/Purchase Order Outlook', '3/16/2026', 'import-contract-fc817d1bf666ff7357cb0b01', 'DRY_RUN', 'Dry run: changes were not written to the database.', 9, 9, 0, 'Contract Management Section.docx#3/16/2026: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000ykj72bx5ubndn', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#SRO submitted 6/17/2026', 'Current and Active Contracts/Purchase Order Outlook', 'SRO submitted 6/17/2026', 'import-contract-6371e6030a7cc7b200280d4f', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 0, 'Contract Management Section.docx#SRO submitted 6/17/2026: no assignee names found, existing assignments will be preserved. | Contract Management Section.docx#SRO submitted 6/17/2026: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn000zkj72kavo9e05', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#CO/CS: Brad Werwick/Kaela Back', 'Current and Active Contracts/Purchase Order Outlook', 'CO/CS: Brad Werwick/Kaela Back', 'import-contract-2b19d1b1443235f197943467', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#CO/CS: Brad Werwick/Kaela Back: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0010kj72ysruria4', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#11/16/25', 'Current and Active Contracts/Purchase Order Outlook', '11/16/25', 'import-contract-fa013bb74519a16ef63ffdb4', 'DRY_RUN', 'Dry run: changes were not written to the database.', 6, 6, 0, 'Contract Management Section.docx#11/16/25: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0011kj72eacdoesn', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#Status: On Track', 'Current and Active Contracts/Purchase Order Outlook', 'Status: On Track', 'import-contract-52a55f038e767f44ecdb0b82', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Status: On Track: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0012kj72y518dozf', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#12/01/25', 'Current and Active Contracts/Purchase Order Outlook', '12/01/25', 'import-contract-1b7568974458daa665b34a67', 'DRY_RUN', 'Dry run: changes were not written to the database.', 7, 7, 0, 'Contract Management Section.docx#12/01/25: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0013kj720tzrdf15', 'cmqqxu9rv0003kj72i11l9qv7', 'Contract Management Section.docx#1/15/25', 'Current and Active Contracts/Purchase Order Outlook', '1/15/25', 'import-contract-13d913d37a5ee7ee82796a50', 'DRY_RUN', 'Dry run: changes were not written to the database.', 6, 6, 0, 'Contract Management Section.docx#1/15/25: no historical submissions parsed from source.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0014kj72xp2jzma6', 'cmqqxu9rv0003kj72i11l9qv7', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxuasn0015kj72qvii20tl', 'cmqqxu9rv0003kj72i11l9qv7', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782236912423, 1782236912423);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001akj72knsvbkbo', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001bkj7216js35in', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 3, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001ckj72xf8g1hbk', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001dkj72j4hgnged', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001ekj72q4gmv50e', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001fkj72nzyn1li3', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001gkj729xljrzo1', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Orders Payload for IPL Basic and IPL Core', 'import-contract-2ff57a35df384ce743129385', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001hkj729h3a0a0d', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001ikj72po3hzs95', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001jkj72k22pk615', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001kkj725df4skk9', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001lkj728wbl9abo', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001mkj72n9j99hoy', 'cmqqxvkt40019kj72hwtn7zhh', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001nkj72hggv5221', 'cmqqxvkt40019kj72hwtn7zhh', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvlut001okj72ttb85s31', 'cmqqxvkt40019kj72hwtn7zhh', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782236973413, 1782236973413);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00ewkj7266vrz9w6', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 14, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00exkj72v3ls6wg1', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'ebusiness', 'IMPORTED', NULL, 1, 1, 3, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00eykj7238ov3t1o', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00ezkj72cliunvhp', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f0kj72dnzlj93b', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f1kj72syr34enk', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f2kj729wxift8z', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Orders Payload for IPL Basic and IPL Core', 'import-contract-2ff57a35df384ce743129385', 'IMPORTED', NULL, 1, 1, 5, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f3kj726504ixgx', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 8, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f4kj72g4z7vht7', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 23, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f5kj72o2soczer', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 24, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f6kj72jbof07dm', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 12, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f7kj7278jkj8fa', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 25, NULL, 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f8kj725ta4a8qh', 'cmqqxvwjd001skj72j984fxbe', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00f9kj7217r6k0zm', 'cmqqxvwjd001skj72j984fxbe', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqxvyqx00fakj72vpvw4b77', 'cmqqxvwjd001skj72j984fxbe', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782236990121, 1782236990121);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900024skf4lb74bdp', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900034skfuzpiezis', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 3, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900044skfhb42h7ga', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900054skfake0xhot', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900064skf1anxgao7', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900074skf7h0kzz7w', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900084skfquw85xsr', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Orders Payload for IPL Basic and IPL Core', 'import-contract-2ff57a35df384ce743129385', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu900094skfhh33r58m', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000a4skfmdx2hv9k', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000b4skftphhi4oa', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000c4skfowo20xzp', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000d4skf2o1gyqh4', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000e4skfw7esg6rn', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000f4skfz86lywdd', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#FY26 Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Adobe ELA', 'import-contract-f7293179902a824d9913bbc9', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000g4skflmlbx4ia', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000h4skf29kebxeg', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 3, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000i4skf7qrig3za', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000j4skfxsmi3021', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000k4skfa0p6yf3q', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000l4skfc5ez7qg6', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Future Enhancements - Orders Payload for IPL Basic and IPL Core', 'import-contract-8879bc71a4e99b8cb6e7b7dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000m4skfmn0em18z', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Orders Payload for IPL Basic and IPL Core', 'Current and Active Contracts/Purchase Order Outlook', 'Orders Payload for IPL Basic and IPL Core', 'import-contract-2ff57a35df384ce743129385', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000n4skf43n65qf3', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfu9000o4skfb263qcvj', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000p4skf69fo8dt8', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000q4skfhem92l9y', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000r4skf5c0ozoqv', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000s4skft9aoeprq', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 11, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000t4skf4awsch4e', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000u4skf1ifxudjf', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'import-contract-774f93d7fc70dc6f4f8d057c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 16, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000v4skftgvjml9f', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#MOD 27 -  exercised Option Year 4', 'Current and Active Contracts/Purchase Order Outlook', 'MOD 27 -  exercised Option Year 4', 'import-contract-28da082849e196ec65929c50', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000w4skfdiyuohwy', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Oracle FY26', 'Current and Active Contracts/Purchase Order Outlook', 'Oracle FY26', 'import-contract-38e48d96cebde8e6e1833d2f', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 10, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000x4skfu4vlljs7', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 17, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000y4skfh9co9khd', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua000z4skff3md9tz0', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#OA is looking into purchasing Employee Experience licenses for all EPA employees', 'Current and Active Contracts/Purchase Order Outlook', 'OA is looking into purchasing Employee Experience licenses for all EPA employees', 'import-contract-fe02e49a2118e677ef86c65d', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 26, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00104skffzils1zf', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'import-contract-75dc00eb25cc5f30a6d6bece', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 64, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00114skft23r7a5w', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00124skf7ar0j1ow', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'import-contract-cdf0c582cc23f947e45f2678', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00134skfta5c9ulr', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 2, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00144skfzpxyolr9', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00154skfddng0wlx', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00164skfqw290a8w', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 13, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00174skf70z4sjdo', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 10, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00184skfmf0p4cnj', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 51, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua00194skfeldw8brt', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#IMCS-VI', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 23, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001a4skf7fj7p4ly', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Once questions are confirmed/formalized, Adam will send to BPA COR', 'Current and Active Contracts/Purchase Order Outlook', 'Once questions are confirmed/formalized, Adam will send to BPA COR', 'import-contract-327a6ee23a54326fcf3cb0ac', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 37, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001b4skfzsdekrd3', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#2024 Oracle', 'Current and Active Contracts/Purchase Order Outlook', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001c4skf60hkcvwi', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#CO/CS: Christopher Davis', 'Current and Active Contracts/Purchase Order Outlook', 'CO/CS: Christopher Davis', 'import-contract-5517e9190ebb31488f35276e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 16, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001d4skfddjnzks9', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Current and Active Contracts/Purchase Order Outlook', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 11, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001e4skfg67w8gtd', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#2025 ORACLE', 'Current and Active Contracts/Purchase Order Outlook', '2025 ORACLE', 'import-contract-2675b2eca21db022bc3c6ab5', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001f4skfs8ws2b60', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#CO/CS: Christopher Davis', 'Current and Active Contracts/Purchase Order Outlook', 'CO/CS: Christopher Davis', 'import-contract-5517e9190ebb31488f35276e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 38, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001g4skfoxgt52xl', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Current and Active Contracts/Purchase Order Outlook', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001h4skfzj3svyie', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001i4skfsrcz8gwa', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#EMDC (Enterprise Mobile Device Coverage)', 'Current and Active Contracts/Purchase Order Outlook', 'EMDC (Enterprise Mobile Device Coverage)', 'import-contract-e05c6ee077f466d15fb69e8a', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 27, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001j4skfu17rarj9', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Infotech 2024', 'Current and Active Contracts/Purchase Order Outlook', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 9, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001k4skfdptvd5wh', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#PC (Laptops) Refresh', 'Current and Active Contracts/Purchase Order Outlook', 'PC (Laptops) Refresh', 'import-contract-3c3d26393918e0b0cc1db6d4', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 21, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001l4skfemykqnf1', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Records Management – DC', 'Current and Active Contracts/Purchase Order Outlook', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001m4skfdbawdusz', 'cmqqybe3g00014skfgjrhmds8', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Current and Active Contracts/Purchase Order Outlook', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001n4skfo6c3bs5y', 'cmqqybe3g00014skfgjrhmds8', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqybfua001o4skf38u9save', 'cmqqybe3g00014skfgjrhmds8', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782237712113, 1782237712113);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0002w1hwpldyegl8', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0003w1hw6tzmglwa', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0004w1hwvl0bcsd9', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0005w1hwsvm6tn42', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0006w1hwe472pzjd', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0007w1hwj4qzymjf', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0008w1hw8ma4lwye', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0009w1hwr4rikq4s', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000aw1hwakvoy1ro', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#FY26 Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Adobe ELA', 'import-contract-f7293179902a824d9913bbc9', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000bw1hwevs51paa', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000cw1hwx3409zhw', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000dw1hw826vl3er', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000ew1hw0ax0zm9o', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000fw1hwka1p68jh', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000gw1hweo9lvezg', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000hw1hw51ncwd3d', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000iw1hwhk0gj8lu', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 11, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000jw1hwx2zhqak3', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000kw1hwk3dyt870', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'import-contract-774f93d7fc70dc6f4f8d057c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 26, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000lw1hw720c0cr0', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 17, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000mw1hwnmybylmu', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 38, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000nw1hw8ityhhn5', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'import-contract-75dc00eb25cc5f30a6d6bece', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 64, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000ow1hw51y8es6y', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000pw1hwj9sinuz5', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'import-contract-cdf0c582cc23f947e45f2678', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000qw1hwkcur6h2a', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 2, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000rw1hws7padpkk', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000sw1hw5hsawr6e', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000tw1hwwl8v5u5a', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 13, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000uw1hwg0ye2auc', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 10, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000vw1hwzr2wi2om', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 51, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000ww1hw8ih0ct3d', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#IMCS-VI', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 60, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000xw1hwlqgfxnc3', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#2024 Oracle', 'Current and Active Contracts/Purchase Order Outlook', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 16, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000yw1hw6yir5zfm', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Current and Active Contracts/Purchase Order Outlook', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 11, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv000zw1hw58x5f6mv', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#2025 ORACLE', 'Current and Active Contracts/Purchase Order Outlook', '2025 ORACLE', 'import-contract-2675b2eca21db022bc3c6ab5', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 38, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0010w1hwrjrqwair', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Current and Active Contracts/Purchase Order Outlook', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yv0011w1hwwvwcd9zi', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yw0012w1hwy9ficwt5', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Infotech 2024', 'Current and Active Contracts/Purchase Order Outlook', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 30, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yw0013w1hwd0msqs46', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Records Management – DC', 'Current and Active Contracts/Purchase Order Outlook', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yw0014w1hwn6ybp7rp', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Current and Active Contracts/Purchase Order Outlook', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yw0015w1hw3s80nvlu', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqyf5yw0016w1hw5z59eo7s', 'cmqqyf4hs0001w1hwhh6gk7ke', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782237885943, 1782237885943);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qtstjkaqshfqzm', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qustjkp1oxsdc2', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'ebusiness', 'IMPORTED', NULL, 1, 1, 10, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qvstjk6yl2ustw', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qwstjkjje7ebzp', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qxstjk7kvj2hsc', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qystjkijkfbbyw', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyk00qzstjkqqqiq5fg', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r0stjkjjs61be7', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r1stjkkfanzce8', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 12, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r2stjkgfxbeciv', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r3stjkqs6kxx2m', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'ebusiness', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r4stjksh3n2o1o', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r5stjkq34f4o7i', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r6stjk2ns7bgds', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r7stjkufqvsfwx', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r8stjkqbncze7u', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00r9stjkkrpvy3dj', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'IMPORTED', NULL, 1, 1, 11, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rastjkzci2g6jf', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rbstjksi5u0ctf', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'hesc-ii', 'IMPORTED', NULL, 1, 1, 26, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rcstjk8mudoraj', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'IMPORTED', NULL, 2, 2, 17, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rdstjke5wjcg3j', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'IMPORTED', NULL, 1, 1, 38, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00restjkyvk2by6k', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'ebusiness', 'IMPORTED', NULL, 1, 1, 63, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rfstjkc8vg977z', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'IMPORTED', NULL, 1, 1, 12, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rgstjko84djlm8', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'iti-iii', 'IMPORTED', NULL, 1, 1, 6, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rhstjkkcjvvi39', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'IMPORTED', NULL, 1, 1, 2, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00ristjk70tjc00v', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rjstjkh2oyxfj5', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rkstjkzxqatfy0', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'IMPORTED', NULL, 1, 1, 13, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rlstjk7f4p50ol', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'IMPORTED', NULL, 1, 1, 10, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rmstjktzt0bkvu', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'IMPORTED', NULL, 1, 1, 40, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgyl00rnstjkais92dvb', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#IMCS-VI', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'IMPORTED', NULL, 1, 1, 59, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rostjk6711fg92', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#2024 Oracle', 'Current and Active Contracts/Purchase Order Outlook', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 16, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rpstjkwo6jlozc', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Current and Active Contracts/Purchase Order Outlook', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'IMPORTED', NULL, 2, 2, 11, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rqstjkbdl01drl', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#2025 ORACLE', 'Current and Active Contracts/Purchase Order Outlook', '2025 ORACLE', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 26, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rrstjkmi83r4bz', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Current and Active Contracts/Purchase Order Outlook', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'IMPORTED', NULL, 1, 1, 12, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rsstjkxez1o48m', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'IMPORTED', NULL, 1, 1, 33, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rtstjkq0d0io82', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Infotech 2024', 'Current and Active Contracts/Purchase Order Outlook', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'IMPORTED', NULL, 1, 1, 30, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rustjktkrusxf2', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Records Management – DC', 'Current and Active Contracts/Purchase Order Outlook', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'IMPORTED', NULL, 1, 1, 5, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rvstjkg3ykn5rp', 'cmqqyt8iy0001stjkaat9pe4r', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Current and Active Contracts/Purchase Order Outlook', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'IMPORTED', NULL, 1, 1, 6, NULL, 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rwstjk67c3d2k7', 'cmqqyt8iy0001stjkaat9pe4r', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqqytgym00rxstjkyztq3gj7', 'cmqqyt8iy0001stjkaat9pe4r', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782238553372, 1782238553372);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v0000eq4el455iw4mr', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000fq4el3o3lki64', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000gq4elq0qbvjfm', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000hq4elbembmnde', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000iq4eldzlbfcoa', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000jq4elmz1gxupe', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000kq4elk4rv5hvs', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000lq4elmo5xwlu5', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000mq4elw8zpowp0', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000nq4el9ielc364', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#EIS', 'New Awards and Recompetes', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 14, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000oq4eloy74ign0', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#eBusiness', 'New Awards and Recompetes', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000pq4el6tkk9ier', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#ESRI', 'New Awards and Recompetes', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 8, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000qq4els9wpy36c', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'New Awards and Recompetes', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000rq4el9p4aoxll', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'New Awards and Recompetes', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000sq4ell717gt0o', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'New Awards and Recompetes', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 20, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000tq4elshuctvu1', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 39, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000uq4elpcs4jw3l', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#ESSET', 'New Awards and Recompetes', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 11, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000vq4elvoi3q5fr', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#MAINES', 'New Awards and Recompetes', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000wq4el2ogz6lwp', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#HESC II', 'New Awards and Recompetes', 'HESC II', 'import-contract-774f93d7fc70dc6f4f8d057c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 26, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000xq4elvxcdc5kj', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#ITSM/STAR Support', 'New Awards and Recompetes', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 17, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000yq4el4facjcav', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'New Awards and Recompetes', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 38, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1000zq4el1l530xzq', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#MPS', 'New Awards and Recompetes', 'MPS', 'import-contract-75dc00eb25cc5f30a6d6bece', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 64, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10010q4elvcdsxivu', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#GAVETS 2', 'New Awards and Recompetes', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10011q4elnriz9liq', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#ITI III', 'New Awards and Recompetes', 'ITI III', 'import-contract-cdf0c582cc23f947e45f2678', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10012q4elsktx5id5', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#DicksonOne', 'New Awards and Recompetes', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 2, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10013q4el9ii9mu8b', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#TrueTandem', 'New Awards and Recompetes', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10014q4el9k36ao8f', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#IMCS – V', 'New Awards and Recompetes', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 1, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10015q4el14khfinl', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Abaco Blackfish', 'New Awards and Recompetes', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 13, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10016q4elhkuugq4u', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Agile Decision Sciences', 'New Awards and Recompetes', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 10, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10017q4elldsijrtn', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Daycom', 'New Awards and Recompetes', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 51, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10018q4elwxlnskd4', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 60, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v10019q4elygcgt9o8', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 16, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001aq4elj9b2wi1p', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'DRY_RUN', 'Dry run: changes were not written to the database.', 2, 2, 11, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001bq4elcsluwyqd', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-2675b2eca21db022bc3c6ab5', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 38, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001cq4el40a9zdcm', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 12, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001dq4elyfm9hope', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 33, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001eq4elxgc4ulfa', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 30, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001fq4el961f9gek', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Records Management – DC', 'New Awards and Recompetes', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 5, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001gq4elh4j9f87k', 'cmqr0o8b3000dq4elsprxxkh4', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'New Awards and Recompetes', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'DRY_RUN', 'Dry run: changes were not written to the database.', 1, 1, 6, NULL, 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001hq4elplnr2vnv', 'cmqr0o8b3000dq4elsprxxkh4', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 75, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0o9v1001iq4elei6l0tg4', 'cmqr0o8b3000dq4elsprxxkh4', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'DRY_RUN', 'Dry run: changes were not written to the database.', 0, 0, 36, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782241670125, 1782241670125);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003kq4elihzbrmtj', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003lq4elow4ztqkl', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 12, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003mq4eld2nsi0c6', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003nq4elwrlaemhl', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003oq4el7anjf0z6', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003pq4elu6u6htw4', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003qq4elcfkdz6ej', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003rq4el66orig8o', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003sq4elrc2dxkhv', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003tq4el9uo4bafe', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#EIS', 'New Awards and Recompetes', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003uq4elrw5si8pe', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#eBusiness', 'New Awards and Recompetes', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003vq4elxitdy90h', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#ESRI', 'New Awards and Recompetes', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003wq4ele95qgbd6', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'New Awards and Recompetes', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003xq4el546au7rn', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'New Awards and Recompetes', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003yq4elnp1u5b2a', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'New Awards and Recompetes', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s003zq4el89sxfwfm', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0040q4el4rm86918', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#ESSET', 'New Awards and Recompetes', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0041q4elbrcocyxo', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#MAINES', 'New Awards and Recompetes', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0042q4elr9xmjyyb', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#HESC II', 'New Awards and Recompetes', 'HESC II', 'hesc-ii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0043q4el7zll9odk', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#ITSM/STAR Support', 'New Awards and Recompetes', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0044q4elkmoajvw0', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'New Awards and Recompetes', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0045q4elfu3sd3le', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#MPS', 'New Awards and Recompetes', 'MPS', 'ebusiness', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0046q4el7st9q087', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#GAVETS 2', 'New Awards and Recompetes', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0047q4el708u5crc', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#ITI III', 'New Awards and Recompetes', 'ITI III', 'iti-iii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0048q4elfyd5w6d8', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#DicksonOne', 'New Awards and Recompetes', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s0049q4el74ardqjt', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#TrueTandem', 'New Awards and Recompetes', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004aq4el1hxx95i0', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#IMCS – V', 'New Awards and Recompetes', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004bq4elojum0w6d', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Abaco Blackfish', 'New Awards and Recompetes', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004cq4elpm3k5w3x', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Agile Decision Sciences', 'New Awards and Recompetes', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004dq4el6j4s5dgy', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Daycom', 'New Awards and Recompetes', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004eq4elwep4z4ku', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004fq4elf0c19crz', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004gq4elp4a08w15', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004hq4elrxkth0nr', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004iq4eluhy2nrns', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004jq4elix4opxxy', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004kq4el9m883ad1', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004lq4el5fuwu024', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Records Management – DC', 'New Awards and Recompetes', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004mq4elyi11wu9m', 'cmqr0r0ke001mq4ele94z1q3m', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'New Awards and Recompetes', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40s004nq4el4iwf12ss', 'cmqr0r0ke001mq4ele94z1q3m', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0r40t004oq4el1ng0mo8t', 'cmqr0r0ke001mq4ele94z1q3m', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782241802524, 1782241802524);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0062q4elnnuf8soo', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0063q4eldkqcpwl9', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0064q4el4ksx3tsr', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0065q4el40a9gqqm', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0066q4elid7q6bks', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0067q4elhk3y4rzg', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0068q4el2sa7uynm', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c0069q4elxa9k7skm', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006aq4elhuv0peeh', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006bq4eljjd6nb3r', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006cq4elzedjvxpv', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006dq4elzcngbhp7', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006eq4ela7j11man', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006fq4eleyjmwcot', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006gq4el6e7jdbyy', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1c006hq4elg0ospyjs', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006iq4elrfndayyi', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006jq4elt9ddtdoa', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006kq4elddjsjb5b', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'hesc-ii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006lq4eli4707c9g', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006mq4el5guwyrzs', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006nq4elpnrz2ngc', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'ebusiness', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006oq4eltz8ux7f3', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006pq4elodu3v7yw', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'iti-iii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006qq4elxzkrv6ta', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006rq4elm66f4t4d', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006sq4el2762jjcb', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006tq4elqxkarear', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006uq4el2zncx8uj', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006vq4elyg7ws0vl', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006wq4el09dm87sf', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006xq4el6hrryw71', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006yq4el4ca9acta', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d006zq4el333ju4s6', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0070q4elxp14g73y', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0071q4elyt5y802w', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0072q4elpb7vhlhg', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0073q4ellnb0btzb', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Records Management – DC', 'Legacy Contracts', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0074q4eluh1s4a4v', 'cmqr0xix0004sq4elx3u0kq1v', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Legacy Contracts', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0075q4elxb8v3p5h', 'cmqr0xix0004sq4elx3u0kq1v', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr0xl1d0076q4eltkbriad4', 'cmqr0xix0004sq4elx3u0kq1v', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782242104513, 1782242104513);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000214b0ld17sbsr', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "cmoudozbe000090udqjfuddj7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000314b0th4h4lxy', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-8e811cb28d5f5d3761ca5634",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000414b0wi542kjo', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-e400ff653596ab4df65250ad",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000514b0o131l4x9', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-b539f4fd85c22b1a2d0f63ba",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000614b0xg17zc72', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-1175226adce593ff68fdde37",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aihz000714b0n0s7pv5b', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-d029e826a7d7aa31c028b829",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000814b0hbvzhitc', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-a809fd21f697d457ab18ec72",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000914b08i2iz5zv', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett-hayes",
      projectId: "import-contract-832e8c8ddb89f3f257fe9c8e",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000a14b0hi5810ra', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-832e8c8ddb89f3f257fe9c8e",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000b14b06oao1egk', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'import-contract-da2c664b1f5bc9e92e53c7ec', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "cmoudozbe000090udqjfuddj7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000c14b00190rrof', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-8e811cb28d5f5d3761ca5634",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000d14b0c85iqvdu', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-e400ff653596ab4df65250ad",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000e14b0f3oq35tx', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-b539f4fd85c22b1a2d0f63ba",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000f14b0dh7dikdo', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-1175226adce593ff68fdde37",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000g14b0jlp94wki', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-d029e826a7d7aa31c028b829",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000h14b0fsc5qd8s', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-jake",
      projectId: "import-contract-a809fd21f697d457ab18ec72",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000i14b05fiuc2ea', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-michelle-cuilla",
      projectId: "import-contract-057dbdf775d573de25e7b743",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000j14b0q4acqvhe', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-3a6aa924799c90ebc86046d3",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000k14b0hk3msrz2', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'import-contract-774f93d7fc70dc6f4f8d057c', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn-lamb",
      projectId: "hesc-ii",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000l14b0pp0azsh7', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-3cca6c65f4f89588245aa152",
      componentId: null,
      assignedBy: "demo-admin"
    },
    {
      userId: "import-adam",
      projectId: "import-contract-3cca6c65f4f89588245aa152",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000m14b0ieqi4e2p', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-adam",
      projectId: "import-contract-5f48f8cdadd6d7029a70c638",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000n14b09retwvtr', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'import-contract-75dc00eb25cc5f30a6d6bece', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn",
      projectId: "ebusiness",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000o14b0xpz0dhmm', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-8bdd5dee44f90d09fd873e19",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000p14b04hba2y5x', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'import-contract-cdf0c582cc23f947e45f2678', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-michelle-cuilla",
      projectId: "iti-iii",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000q14b0g6775nem', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-eae8e00c70a495083e0607af",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000r14b04zbxpqbr', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-ca130e3ffe78ee6a16735530",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000s14b0rmtzifwe', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-43ff00ad21c61d3a413f4cf1",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000t14b0stxh0xvk', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-5c4031542012d126e56612ca",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000u14b0sd96ee2w', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-be12f0eecafb0baa6f69f8dd",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000v14b08akyajpn', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-050f0bd7f3153f89a03aad6f",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000w14b0nkjm8o6p', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-shela",
      projectId: "import-contract-65355f1c5465ef3091ebbb1b",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000x14b0suhibrkt', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-baf0be6e5b1e6094b8e3775d",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000y14b07rjqc5ue', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-andrew",
      projectId: "import-contract-d30fe6889e2da89ade70e94c",
      componentId: null,
      assignedBy: "demo-admin"
    },
    {
      userId: "import-dawn",
      projectId: "import-contract-d30fe6889e2da89ade70e94c",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0000z14b0sszsj6ef', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-2675b2eca21db022bc3c6ab5', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-sergey",
      projectId: "import-contract-baf0be6e5b1e6094b8e3775d",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001014b0flo5if88', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-dawn",
      projectId: "import-contract-f0484471e8858bfc2db838ff",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001114b0uxlphuol', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim",
      projectId: "import-contract-614f28f4029854f21450b5c7",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001214b0i7vfo1c2', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-garrett",
      projectId: "import-contract-f3407cda0843798fd3d706e6",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001314b0js3kozhz', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Records Management – DC', 'Legacy Contracts', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim-farmer",
      projectId: "import-contract-d3b1aa0179954f23527943d1",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001414b05twuu7wi', 'cmqr1ah0k000114b0f686v4oc', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Legacy Contracts', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'FAILED', '
Invalid `prisma.projectAssignment.createMany()` invocation:

{
  data: [
    {
      userId: "import-kim",
      projectId: "import-contract-c36e2aadda827ded8c159f09",
      componentId: null,
      assignedBy: "demo-admin"
    }
  ],
  skipDuplicates: true
  ~~~~~~~~~~~~~~
}

Unknown argument `skipDuplicates`. Available options are marked with ?.', 0, 0, 0, NULL, 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001514b0yzfqdia2', 'cmqr1ah0k000114b0f686v4oc', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1aii0001614b0qrsflihf', 'cmqr1ah0k000114b0f686v4oc', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782242707751, 1782242707751);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007gq4ela6jpi7qq', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007hq4elmqgaijij', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007iq4elhrs97rst', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007jq4eli4dcjv0s', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007kq4el4ltnejkj', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007lq4elxplreuo4', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007mq4elw2gvhai1', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007nq4eld3mlnop9', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007oq4elutpnfpcd', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007pq4elfblreyiw', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007qq4el5q343xab', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007rq4eltppx1jhs', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007sq4elqxgfxa54', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007tq4elpsc6tii0', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007uq4elodh34rzp', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007vq4elb5f11lgd', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007wq4el21ddtu5l', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007xq4elulpqixg7', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007yq4el3jrblx48', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'hesc-ii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy007zq4elfxm6ghj9', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0080q4elh0de0txb', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0081q4el2xmh3ilf', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'ebusiness', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0082q4eltgec1ayg', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0083q4el0cyhzan7', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'iti-iii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0084q4elal0sty9f', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0085q4el8mtinmnj', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0086q4el9oa29jeb', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0087q4eloixzn1pp', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0088q4ely22yswgd', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy0089q4elphhxdelw', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008aq4elo7hg423t', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008bq4elpu6vbdqt', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008cq4elmpcynfp6', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008dq4el3y6ccg53', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008eq4elmvn06ih7', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008fq4elj5hq5ofe', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008gq4el0mr87rr8', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008hq4elg8vufzq5', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Records Management – DC', 'Legacy Contracts', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008iq4elogej81dr', 'cmqr1eqi9007aq4el74crvu1g', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Legacy Contracts', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008jq4elvwgn04pa', 'cmqr1eqi9007aq4el74crvu1g', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1escy008kq4ele3dzmkgk', 'cmqr1eqi9007aq4el74crvu1g', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782242907154, 1782242907154);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000611a3s1kfzin3', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000711a3gnzpzw0a', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000811a36ff9x822', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000911a30nmeg9ld', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000a11a3u7rol0qg', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000b11a3urjzlhqy', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000c11a35u1u7u5z', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section (2).docx#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000d11a3jww853ox', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, 'Contract Management Section.docx#Adobe ELA: no historical submissions parsed from source.', 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000e11a3qe1gj5hy', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Adobe ELA', 'Current and Active Contracts/Purchase Order Outlook', 'Adobe ELA', 'import-contract-832e8c8ddb89f3f257fe9c8e', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000f11a36f6r7vpo', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#EIS', 'Current and Active Contracts/Purchase Order Outlook', 'EIS', 'cmoudozbe000090udqjfuddj7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000g11a34sg68kz9', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#eBusiness', 'Current and Active Contracts/Purchase Order Outlook', 'eBusiness', 'import-contract-8e811cb28d5f5d3761ca5634', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000h11a3mg22uoeb', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#ESRI', 'Current and Active Contracts/Purchase Order Outlook', 'ESRI', 'import-contract-e400ff653596ab4df65250ad', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000i11a3osdg6vel', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Mobile - EMDC - AT&T', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - AT&T', 'import-contract-b539f4fd85c22b1a2d0f63ba', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000j11a3nnblwkl5', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Mobile - EMDC - Verizon', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - Verizon', 'import-contract-1175226adce593ff68fdde37', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000k11a3kjc3eiem', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Mobile - EMDC - T-Mobile', 'Current and Active Contracts/Purchase Order Outlook', 'Mobile - EMDC - T-Mobile', 'import-contract-d029e826a7d7aa31c028b829', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000l11a37n6grh2z', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Mobile - T-Mobile (Legacy Contract)', 'Legacy Contracts', 'Mobile - T-Mobile (Legacy Contract)', 'import-contract-a809fd21f697d457ab18ec72', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000m11a3szi0tu8h', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#ESSET', 'Current and Active Contracts/Purchase Order Outlook', 'ESSET', 'import-contract-057dbdf775d573de25e7b743', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000n11a36v02ucxl', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#MAINES', 'Current and Active Contracts/Purchase Order Outlook', 'MAINES', 'import-contract-3a6aa924799c90ebc86046d3', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000o11a3v3fjg835', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#HESC II', 'Current and Active Contracts/Purchase Order Outlook', 'HESC II', 'hesc-ii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000p11a314aqyjjl', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#ITSM/STAR Support', 'Current and Active Contracts/Purchase Order Outlook', 'ITSM/STAR Support', 'import-contract-3cca6c65f4f89588245aa152', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000q11a31j6rh3yo', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Qualtrics (via Carahsoft) BPA', 'Current and Active Contracts/Purchase Order Outlook', 'Qualtrics (via Carahsoft) BPA', 'import-contract-5f48f8cdadd6d7029a70c638', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000r11a3fdr7uty1', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#MPS', 'Current and Active Contracts/Purchase Order Outlook', 'MPS', 'ebusiness', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000s11a3lysi3jjd', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#GAVETS 2', 'Current and Active Contracts/Purchase Order Outlook', 'GAVETS 2', 'import-contract-8bdd5dee44f90d09fd873e19', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000t11a3m9ce7bfn', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#ITI III', 'Current and Active Contracts/Purchase Order Outlook', 'ITI III', 'iti-iii', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000u11a32bj3bddr', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#DicksonOne', 'Current and Active Contracts/Purchase Order Outlook', 'DicksonOne', 'import-contract-eae8e00c70a495083e0607af', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000v11a3fb0zsitx', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#TrueTandem', 'Current and Active Contracts/Purchase Order Outlook', 'TrueTandem', 'import-contract-ca130e3ffe78ee6a16735530', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000w11a3uh0wyfom', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#IMCS – V', 'Current and Active Contracts/Purchase Order Outlook', 'IMCS – V', 'import-contract-43ff00ad21c61d3a413f4cf1', 'IMPORTED', NULL, 1, 1, 1, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000x11a308mz5zqj', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Abaco Blackfish', 'Current and Active Contracts/Purchase Order Outlook', 'Abaco Blackfish', 'import-contract-5c4031542012d126e56612ca', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000y11a3sthnh8nz', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Agile Decision Sciences', 'Current and Active Contracts/Purchase Order Outlook', 'Agile Decision Sciences', 'import-contract-be12f0eecafb0baa6f69f8dd', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0000z11a36h0w49tm', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Daycom', 'Current and Active Contracts/Purchase Order Outlook', 'Daycom', 'import-contract-050f0bd7f3153f89a03aad6f', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001011a32qtgkl2k', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#IMCS-VI', 'New Awards and Recompetes', 'IMCS-VI', 'import-contract-65355f1c5465ef3091ebbb1b', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001111a3d56gsuqt', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#2024 Oracle', 'Legacy Contracts', '2024 Oracle', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001211a3xhif7uvw', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#2024 Printer Refresh and Accessories', 'Legacy Contracts', '2024 Printer Refresh and Accessories', 'import-contract-d30fe6889e2da89ade70e94c', 'IMPORTED', NULL, 2, 2, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001311a37c9stcdy', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#2025 ORACLE', 'Legacy Contracts', '2025 ORACLE', 'import-contract-baf0be6e5b1e6094b8e3775d', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001411a3xjfzmicq', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#2025 Printer Refresh 2nd Order CY24', 'Legacy Contracts', '2025 Printer Refresh 2nd Order CY24', 'import-contract-f0484471e8858bfc2db838ff', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001511a3qqvqiw1n', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Legacy Microsoft ELA', 'Legacy Contracts', 'Legacy Microsoft ELA', 'import-contract-614f28f4029854f21450b5c7', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001611a32qck0a41', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Infotech 2024', 'Legacy Contracts', 'Infotech 2024', 'import-contract-f3407cda0843798fd3d706e6', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001711a3r5k15md1', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Records Management – DC', 'Legacy Contracts', 'Records Management – DC', 'import-contract-d3b1aa0179954f23527943d1', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001811a3s9kmniwh', 'cmqr1h4ur000111a3r8r9ty9v', 'Contract Management Section.docx#details#Jan. 2026 PC (Laptops) Refresh', 'Legacy Contracts', 'Jan. 2026 PC (Laptops) Refresh', 'import-contract-c36e2aadda827ded8c159f09', 'IMPORTED', NULL, 1, 1, 0, NULL, 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001911a307qwkn7b', 'cmqr1h4ur000111a3r8r9ty9v', 'Data Processing Activity.docx', 'Current and Active Contracts/Purchase Order Outlook', 'FY26 Out of Cycle Requests (OCR)', 'import-section-9a1440b0a0d6424294cec1dd', 'IMPORTED', NULL, 0, 0, 0, 'Data Processing Activity.docx: no assignee names found, existing assignments will be preserved.', 1782243020376, 1782243020376);
INSERT INTO import_job_file_results (id, jobId, sourcePath, category, title, projectId, status, message, usersUpserted, assignmentsCreated, submissionsCreated, warnings, createdAt, updatedAt) VALUES ('cmqr1h7q0001a11a3dlu38phj', 'cmqr1h4ur000111a3r8r9ty9v', 'Service and Project Management Section.docx', 'Current and Active Contracts/Purchase Order Outlook', 'Quarterly Service Review/STAR Format (Terri)', 'import-section-dfbf956b1535007eccc45230', 'IMPORTED', NULL, 0, 0, 0, 'Service and Project Management Section.docx: no assignee names found, existing assignments will be preserved.', 1782243020376, 1782243020376);
COMMIT;
PRAGMA foreign_keys = ON;
