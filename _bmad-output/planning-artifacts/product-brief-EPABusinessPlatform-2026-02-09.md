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

3. **Seamless Integration:** Will reviews and edits via web interface with date-range filtering. Microsoft Graph API automatically prepends formatted updates to the existing OneNote for senior management - no workflow change for executives.Merg
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
