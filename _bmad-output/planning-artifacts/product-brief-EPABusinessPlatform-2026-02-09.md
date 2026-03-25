---
stepsCompleted: [1, 2, 3, 4, 5]
inputDocuments: ['c:/Users/Buyer/Documents/CascadeProjects/EPABusinessPlatform/_bmad-output/analysis/brainstorming-session-2026-02-09.md']
date: 2026-02-09
author: Jake
---

# Product Brief: EPABusinessPlatform

## Executive Summary

The Weekly Activity Report (WAR) system is a manual, time-intensive process consuming 30 hours per week across ITSB leadership. Currently, 19 team members submit updates via an unwieldy shared OneNote document that requires manual copy-paste, formatting, and chasing. The aggregation process involves repeated manual intervention from Jake (data collector) and Will (program overseer) before reaching senior management.

**The Solution:** A Next.js web application with Teams-native data collection, AI-powered terse conversion, and seamless OneNote integration via Microsoft Graph API. The system automates reminders, converts verbose updates into executive-ready formats, and maintains backward compatibility with existing OneNote workflows for senior management.

**Key Value:** Reduce 30 hours/week of manual work to near-zero, while improving update quality and timeliness through AI assistance and structured data capture.

---

## Core Vision

### Problem Statement

ITSB's Weekly Activity Report process is broken across three dimensions:

1. **Contributor Experience:** Team members must manually copy-paste from previous weeks, navigate an increasingly unwieldy OneNote document, and remember to submit updates without reliable automated reminders.

2. **Aggregator Experience (Jake):** Spending ~15 hours/week manually formatting submissions, chasing non-respondents via calls/texts, and cleaning up inconsistent formatting from 19 different contributors.

3. **Program Overseer Experience (Will):** Receiving inconsistently formatted updates that require additional refinement before being suitable for senior management consumption, with no easy way to review historical trends or filter by date range.

### Problem Impact

- **30 hours/week** of leadership time consumed by manual WAR administration
- **Inconsistent formatting** degrades readability for senior management
- **Manual chasing** creates friction between submitters and aggregators
- **No historical visibility** makes trend analysis impossible
- **Broken SharePoint automation** left a gap with no working alternative
- **Verbose submissions** bury key information in noise

### Why Existing Solutions Fall Short

| Current Approach | Failure Mode |
|------------------|--------------|
| Shared OneNote | Becomes unwieldy; no structure enforcement |
| Outlook recurring appointments | Passive reminder, no submission mechanism |
| SharePoint email automation | Stopped working; unreliable |
| Manual chasing | Time-intensive, creates interpersonal friction |
| Direct Teams messages | No structure, scattered data |

No commercial WAR tool has been evaluated - the team has been "making do" with Microsoft tools used in ways they weren't designed for.

### Proposed Solution

**The Intelligent WAR Platform** - A Next.js web application with three key innovations:

1. **Frictionless Capture:** Teams-native submission via `/war` slash commands and adaptive cards, with AI assistance converting verbose text into terse updates. Auto-populated templates eliminate copy-paste.

2. **Intelligent Processing:** AI-powered terse conversion transforms raw submissions into executive-ready bullet points. Markdown table support preserves rich formatting. Raw text archived for detail access.

3. **Seamless Integration:** Will reviews and edits via web interface with date-range filtering. Microsoft Graph API automatically prepends formatted updates to the existing OneNote for senior management - no workflow change for executives.

### Key Differentiators

| Differentiator | Competitive Advantage |
|----------------|----------------------|
| **AI Terse Conversion** | Automatically transforms verbose updates into executive-ready format - no manual editing required |
| **Teams-Native Capture** | Meets contributors where they already work - no context switching |
| **OneNote Backward Compatibility** | Senior management sees zero change; Graph API handles integration seamlessly |
| **Markdown Table Support** | Preserves rich data formatting that plain text loses |
| **Raw Text Archive** | Detail available when needed without cluttering executive view |
| **Date-Range Filtering** | Will can quickly review and edit 2-week ranges with custom search |

---

## Target Users

### Primary Users

#### 1. The Contributors (19 Team Members)
**Representative:** Gabby Orzel, Information Management Specialist  
**Sections:** Contracts Management (10) + Service & Project Management (9)

**Context:** Federal employees who must submit weekly status updates but struggle with the current OneNote process. They work across various ITSB projects and need to remember accomplishments, blockers, and plans every two weeks.

**Current Pain:**
- Must copy-paste from previous week's entry
- Navigate an increasingly unwieldy OneNote document
- Manually format dates and topics
- Remember to submit without reliable automated reminders

**Goals:**
- Submit updates in under 2 minutes
- Stay in Teams workflow (no context switching)
- Avoid "blank page" anxiety with AI assistance

**Success Vision:** "I just type `/war` in Teams, the AI helps me polish my update, and I'm done in 60 seconds."

---

#### 2. The Aggregator (Jake)
**Role:** IT Specialist, Service and Project Management Section

**Context:** The "data collector" responsible for wrangling 19 people's updates every two weeks. Currently spends ~15 hours/week on manual WAR administration.

**Current Pain:**
- Chasing non-respondents via calls and texts ("herding cats")
- Manually formatting inconsistent submissions
- Cleaning up verbose text into terse format
- No visibility into who's submitted vs. outstanding

**Goals:**
- Zero manual chasing - automated reminders handle it
- Consistent formatting without manual cleanup
- Quick visibility into submission status
- AI handles the "verbose → terse" conversion

**Success Vision:** "I open the dashboard, see 100% submission rate, and the executive briefing is already formatted and ready for Will."

---

#### 3. The Program Overseer (Will)
**Role:** Program Manager reviewing ITSB portfolio

**Context:** Receives aggregated updates from Jake, performs final refinement before sending to senior management. Needs to quickly assess project health across 19 team members.

**Current Pain:**
- Inconsistent formatting requires additional editing
- No easy way to view historical trends or patterns
- Cannot quickly filter by date range (e.g., "last 2 weeks")
- No mechanism to identify stalled projects vs. progressing ones

**Goals:**
- Review and edit with date-range filtering (2-week views)
- AI "bullshit detector" flags stalled projects automatically
- Raw detail available when needed, but terse view by default
- One-click approval to senior management

**Success Vision:** "The AI already highlighted 3 projects that need attention. I review, make minor edits, and send to leadership - all in 10 minutes."

---

### Secondary Users

#### 4. Senior Management
**Role:** Executive leadership consuming the final WAR output

**Context:** End consumers who view the portfolio status via OneNote. The system must maintain backward compatibility with their existing workflow.

**Needs:**
- Continue viewing updates in familiar OneNote format
- Bulleted, terse summaries (no change to current experience)
- No learning curve or workflow disruption

**Success Vision:** "I open OneNote on Monday morning and see the same format I've always seen - but the content is cleaner and more consistent."

---

### User Journey

#### Contributor Journey: Gabby Orzel

| Stage | Current State | Future State with WAR Platform |
|-------|---------------|--------------------------------|
| **Reminder** | Outlook appointment (easy to ignore) | Teams bot DM: "Your WAR update is due Tuesday" |
| **Capture** | Open unwieldy OneNote, copy-paste, format | Type `/war update` in Teams, AI suggests text |
| **Composition** | Blank page anxiety, verbose rambling | Structured form with last week's context pre-filled |
| **Submission** | Paste into OneNote, manually format | Submit via adaptive card, AI converts to terse format |
| **Confirmation** | No confirmation of receipt | Instant "Update received" Teams notification |

**Aha! Moment:** "I submitted my update without leaving Teams, and the AI made it sound professional!"

---

#### Aggregator Journey: Jake

| Stage | Current State | Future State with WAR Platform |
|-------|---------------|--------------------------------|
| **Monitoring** | Manual tracking spreadsheet | Dashboard shows 18/19 submitted, 1 outstanding |
| **Chasing** | Calls and texts to non-respondents | Automated Teams @mentions for missing updates |
| **Review** | Open OneNote, scroll through chaos | Filtered view: "This week's submissions only" |
| **Formatting** | Manual cleanup of 19 different formats | AI already converted to terse, consistent format |
| **Handoff** | Copy-paste to Will | Will accesses same dashboard with edit permissions |

**Aha! Moment:** "I went from 15 hours of manual work to reviewing an AI-generated briefing in 15 minutes!"

---

#### Program Overseer Journey: Will

| Stage | Current State | Future State with WAR Platform |
|-------|---------------|--------------------------------|
| **Receive** | Inconsistent emails/formats from Jake | Dashboard with standardized, terse updates |
| **Analyze** | Manual scanning for blockers/risk | AI flags: "3 projects blocked, 2 at risk" |
| **Deep Dive** | Scroll through verbose history | Click any project → trend graph + raw archive |
| **Edit** | Manual reformatting in OneNote | Web interface with 2-week date range filter |
| **Distribute** | Copy to OneNote for leadership | Graph API auto-prepend to senior mgmt OneNote |

**Aha! Moment:** "The AI spotted a project stalling 3 weeks before I would have noticed!"

---

**Key User Insights:**

- **Contributors** want frictionless capture with AI assistance, not another system to learn
- **Jake** wants automation to replace his "herding cats" responsibility
- **Will** wants intelligence to surface what matters and hide what doesn't
- **Senior Management** wants zero change to their current OneNote workflow

---

## Success Metrics

### User Success Metrics

#### Contributors (19 Team Members)
| Metric | Baseline | Target (3mo) | Target (12mo) | Measurement Method |
|--------|----------|--------------|---------------|-------------------|
| Average submission time | 10-15 minutes | < 3 minutes | < 2 minutes | In-app timing + user feedback |
| On-time submission rate | ~85% (with chasing) | 95% | 98% | System tracking vs. deadline |
| User satisfaction (NPS) | N/A (no current tool) | > 50 | > 70 | Bi-annual survey |
| AI assistance usage | 0% | > 60% | > 80% | Feature analytics |

**Success Signal:** Contributors submit updates without being chased, and actually use the AI polish feature because it saves them time.

---

#### Aggregator (Jake)
| Metric | Baseline | Target (3mo) | Target (12mo) | Measurement Method |
|--------|----------|--------------|---------------|-------------------|
| Weekly WAR admin time | ~15 hours | < 5 hours | < 1 hour | Time-tracking/self-report |
| Manual chasing incidents | 10-15 per cycle | < 3 | 0 | System tracking (automated vs manual) |
| Formatting cleanup time | ~8 hours | < 1 hour | 0 (AI handles) | Task tracking |
| Dashboard check frequency | N/A | Daily | Daily | Analytics |

**Success Signal:** Jake opens the dashboard, sees status at a glance, and spends time reviewing insights rather than chasing people.

---

#### Program Overseer (Will)
| Metric | Baseline | Target (3mo) | Target (12mo) | Measurement Method |
|--------|----------|--------------|---------------|-------------------|
| Review & editing time | ~10 hours | < 2 hours | < 30 min | Self-report + system logs |
| Time to identify stalled projects | Reactive (weeks) | < 3 days | Real-time | AI flag timing vs. manual detection |
| Executive briefing prep time | ~4 hours | < 30 min | < 15 min | Workflow timing |
| OneNote integration reliability | 0% (manual) | 95% | 99% | API success rate tracking |

**Success Signal:** Will relies on AI flags to proactively manage projects rather than discovering issues late.

---

### Business Objectives

**3-Month Goals (MVP Success):**
- Deploy functional WAR platform to ITSB with zero downtime
- Achieve 100% contributor adoption (all 19 team members actively using)
- Reduce total WAR administration time from 30 hrs/week to < 10 hrs/week
- Maintain 100% backward compatibility with senior management OneNote workflow

**12-Month Goals (Full Value Realization):**
- Reduce total WAR administration time to < 2 hrs/week (95% time savings)
- Achieve 98% on-time submission rate without manual chasing
- Enable proactive project health management through AI insights
- Establish platform as template for other EPA sections' status reporting

**Strategic Value:**
- **Time Reallocation:** 28 hours/week of leadership time returned to high-value work
- **Quality Improvement:** Consistent, professional formatting across all updates
- **Risk Reduction:** Early identification of stalled projects before they become critical
- **Compliance:** Maintain existing senior management workflow (zero disruption)

---

### Key Performance Indicators (KPIs)

#### System Health & Adoption
| KPI | Target | Measurement |
|-----|--------|-------------|
| Active Users (bi-weekly) | 19/19 (100%) | Unique submitters per cycle |
| Teams Bot Engagement Rate | > 90% | Users who interact with bot vs. web only |
| System Uptime | > 99.5% | Cloud.gov monitoring |
| Average API Response Time | < 500ms | Graph API + app performance |

#### AI Feature Effectiveness
| KPI | Target | Measurement |
|-----|--------|-------------|
| AI Terse Conversion Usage | > 70% of submissions | Opt-in rate |
| AI Conversion Satisfaction | > 80% positive | Post-conversion feedback |
| "Bullshit Detector" Accuracy | > 85% true positive | Will validation of flags |
| False Positive Rate | < 10% | Incorrect stall predictions |

#### Operational Efficiency
| KPI | Baseline | Target | Calculation |
|-----|----------|--------|-------------|
| End-to-End Cycle Time | ~30 hrs/week | < 2 hrs/week | From reminder to OneNote delivery |
| Manual Intervention Rate | 100% | < 5% | Human touches required per cycle |
| Cost per Update | ~$90 (labor) | <$5 (automated) | (Time × Rate) / 19 updates |

#### User Experience
| KPI | Target | Measurement |
|-----|--------|-------------|
| Task Success Rate | > 95% | Users completing submission without error |
| Support Tickets | < 2/month | IT help requests |
| Feature Discovery | > 80% know about AI assist | Quarterly survey |

---

### Success Measurement Framework

**Monthly Reviews:**
- Dashboard metrics review (submission rates, AI usage, time savings)
- User feedback collection (quick pulse surveys)
- System performance monitoring (uptime, API health)

**Quarterly Business Reviews:**
- Business objective progress (time savings actualized)
- ROI calculation (hours saved × labor rate)
- Strategic goal alignment (platform expansion opportunities)

**Annual Assessment:**
- Full NPS survey across all user types
- Comparative analysis (before/after implementation)
- Roadmap planning for Phase 2/3 features

---

**Critical Success Factors:**

1. **Adoption is Everything:** If contributors don't use it, nothing else matters
2. **AI Must Deliver:** The "terse conversion" is the killer feature - it must work flawlessly
3. **Invisible Integration:** OneNote integration must be 100% reliable - senior management cannot notice any disruption
4. **Time Savings Reality Check:** If Jake is still spending 5+ hours/week after 6 months, we've failed

---

## MVP Scope

### Core Features

#### 1. Platform Foundation
- **Cloud.gov Deployment:** Next.js web application hosted on Cloud.gov with SSO integration
- **PostgreSQL Database:** PG Vector enabled for text embeddings (RAG capabilities) + markdown storage
- **User Management:** Bulk import of users and email addresses for notifications and Teams Bot alerts

#### 2. AI-Powered Submission System
- **Teams Intelligent Bot:** `/war` slash command with adaptive cards for submission
- **AI Terse Converter:** Transforms verbose submissions into executive-ready format
- **Full Text Archive:** Raw submissions preserved for detail access
- **Pre-Submission Review:** Submitters review AI terse format and make edits before sending
- **Customizable Prompts:** Jake can modify AI prompts controlling terse formatting

#### 3. Review Workflows
- **Will's Review Process:** Executive briefing view with date-range filtering and approval
- **Jake's Review Process:** Aggregator dashboard with submission tracking and editing capabilities
- **Terse Accuracy Edit:** Jake can edit AI terse conversions for accuracy before finalization

#### 4. Notification System
- **Nag Email Schedule:** Automated reminders at 2 days, 1 day, 1 hour, 5 minutes, and overdue
- **Multi-Channel Alerts:** Email + Teams Bot notifications

#### 5. Integration & Output
- **OneNote Graph API:** Automatic prepending of formatted updates to senior management OneNote
- **Historical Import:** Import and analyze entire existing OneNote, break apart by week, provide project recommendations

#### 6. Admin & Monitoring
- **Admin Dashboard:** Usage metrics and noncompliance tracking
- **User Journeys:** Complete workflows for Contributors, Jake, and Will

---

### Out of Scope for MVP

| Feature | Rationale | Target Release |
|---------|-----------|----------------|
| AI "Bullshit Detector" | Requires training data and validation | Phase 2 |
| Auto-recommendations for stalled projects | Needs historical pattern analysis | Phase 2 |
| Resource load balancing | Complex resource modeling | Phase 3 |
| Voice-to-text submission | Mobile-first enhancement | Phase 3 |
| Sentiment analysis | Advanced AI feature | Phase 2 |
| Natural language queries ("Ask WAR") | RAG-based search enhancement | Phase 2 |
| Project dependency network graphs | Advanced visualization | Phase 3 |
| Mobile app | Web responsive sufficient for MVP | Phase 3 |

---

### MVP Success Criteria

**Technical Success:**
- 100% uptime for Cloud.gov deployment
- < 500ms API response times
- 100% successful OneNote Graph API integrations

**User Adoption Success:**
- 100% contributor adoption (19/19 team members)
- > 90% submissions via Teams Bot (not web-only)
- < 2 minutes average submission time

**Operational Success:**
- 90% reduction in Jake's manual chasing (from 15 to < 2 incidents per cycle)
- 75% reduction in total WAR admin time (from 30 hrs to < 8 hrs/week)
- > 80% AI terse conversion usage rate

**Quality Success:**
- > 95% on-time submission rate (no manual chasing required)
- < 5% manual intervention rate for formatting
- Zero disruption to senior management OneNote workflow

---

### Future Vision

**Phase 2 (Months 4-8): Intelligence Layer**
- AI "Bullshit Detector" with stall detection accuracy > 85%
- Smart briefing generator with auto-insights
- Sentiment analysis for team morale tracking
- "Ask WAR" natural language querying
- Predictive project health indicators

**Phase 3 (Months 9-12): Advanced Analytics**
- Resource load balancing and capacity planning
- Project dependency network visualization
- Cross-team impact analysis
- Historical trend prediction
- Voice-to-text mobile submission

**2-3 Year Vision:**
- Multi-section EPA deployment (expand beyond ITSB)
- Predictive resource allocation recommendations
- Automated project risk assessment
- Integration with EPA project management ecosystem
- Platform-as-a-Service for federal status reporting
