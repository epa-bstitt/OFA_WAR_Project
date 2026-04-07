# FY25 WCF Budget Updates: Data Capture & Implementation Briefing

**Document Date**: February 26, 2026  
**Prepared For**: EPA Business Platform Development  
**Source Document**: `docs/Data Processing Activity/FY25 WCF Budget Updates.docx`

---

## Executive Summary

The FY25 WCF Budget Updates document contains 400 paragraphs of structured budget reporting spanning January 2024 through November 2024. Analysis reveals a mature reporting process with standardized variance explanations and a clear two-section structure (Past Updates archived, Current Updates active). This briefing recommends a structured digital capture system within the EPA Business Platform to replace manual Word document tracking.

---

## Current State Analysis

### Document Structure
- **Total Entries**: ~40 weekly updates spanning 10 months
- **Update Pattern**: `Update [MM/DD]. [Narrative description]`
- **Financial Reporting**: 15+ services tracked with quarterly profit/loss metrics
- **Section Organization**:
  - Past Updates (Lines 4-337): Historical archive
  - Current Updates (Lines 338-400): Active reporting period

### Variance Explanation Trends

| Trend Category | Frequency | Key Pattern |
|---------------|-----------|-------------|
| External Program Impacts | High | DRP (Deferred Resignation Program) cited across multiple services |
| Timing/Schedule Variances | High | "Late funding received" preventing obligation |
| Expense-Budget Comparisons | Medium | Standardized "within 4% P/L tolerance" language |
| Headcount-Based Impacts | Medium | Workforce reduction effects on revenue |

### Standardized Explanation Formula
Current responses follow a 4-part structure:
1. **Actual vs. Budget Comparison** ("Expenses were lower than budgeted")
2. **Causal Attribution** ("which resulted in..." / "caused by...")
3. **Impact Quantification** (dollar amount / percentage)
4. **Tolerance Assessment** ("within the 4% P/L")

---

## Recommended Data Capture Strategy

### 1. Firestore Collections

```typescript
// Weekly Update Record
interface WeeklyUpdate {
  id: string;
  weekEnding: Timestamp;
  fiscalYear: number;           // 2025
  quarter: number;              // 1-4
  narrativeUpdate: string;      // "Update 11/7. Provided OCFO with..."
  status: 'draft' | 'submitted' | 'archived';
  submittedBy: string;
  submittedAt: Timestamp;
  attachments: Attachment[];
}

// Service Performance (per-update, per-service)
interface ServicePerformance {
  id: string;
  weeklyUpdateId: string;
  serviceCode: string;          // "BA", "CD", "CT", "DA", "DS"
  serviceName: string;
  profitLoss: number;
  profitLossPercent: number;
  explanationCategory:          // Standardized for reporting
    | 'expense_variance'
    | 'revenue_timing'
    | 'external_program'
    | 'headcount_impact'
    | 'within_tolerance'
    | 'other';
  explanationText: string;
}

// Variance Explanation Templates (reference data)
interface VarianceTemplate {
  category: string;
  templateText: string;         // "Expenses were {comparison} than budgeted..."
  triggers: string[];           // Keywords that auto-suggest this template
}
```

### 2. Pre-Populated Variance Categories

Based on trend analysis, the system should offer these standardized explanation templates:

| Category | Template | Usage Context |
|----------|----------|---------------|
| **Expense Underspend** | "Expenses were lower than budgeted which resulted in a {outcome}. The service remains within the 4% P/L." | Actual < Budgeted |
| **Revenue Timing** | "Single payer funding was received late in the year which prevented us from obligating and spending funds as budgeted." | Late funding receipt |
| **External Program** | "The {Program Name} caused a decrease in revenue for {affected services}. {Impact description}." | DRP, workforce reductions |
| **Within Tolerance** | "Actual expenses are in line with budgeted expenses. However, {exceptional factor}." | Acceptable variance |
| **Headcount Impact** | "Actual expenses are in line with budgeted expenses. However, {Program} caused a decrease in revenue for headcount and usage-based services." | Workforce changes |

### 3. Key Metrics to Capture

**Per Update**:
- Week ending date
- Narrative summary (free text, 10-2000 chars)
- Submission timestamp
- Submitter identity
- OCFO report period reference

**Per Service** (4-5 services per update):
- Service code (2-char identifier)
- FY25 cumulative profit/loss
- Profit/loss as % of revenue
- Explanation category (dropdown)
- Explanation narrative (free text, min 5 chars)

---

## Implementation Plan

### Phase 1: Data Model & Migration (Week 1-2)

**Tasks**:
1. Create Firestore collections (`weeklyUpdates`, `servicePerformance`, `varianceTemplates`)
2. Define TypeScript interfaces in `types/budget-update.ts`
3. Extract historical data from Word document using Python parsing script
4. Bulk import 40 historical updates with `status: 'archived'`
5. Create variance template seed data

**Files to Create**:
- `src/types/budget-update.ts`
- `src/lib/schema.ts` (add COLLECTIONS constants)
- `scripts/migrate-budget-updates.ts`

### Phase 2: API Layer (Week 2-3)

**Tasks**:
1. Create `POST /api/budget-updates` endpoint with Zod validation
2. Implement batch write for atomic update + service records
3. Create `GET /api/budget-updates` with filtering (date range, quarter, service)
4. Add `GET /api/budget-updates/:id` for detail view
5. Create `GET /api/variance-templates` for dropdown population

**Validation Schema**:
```typescript
const createUpdateSchema = z.object({
  weekEnding: z.string().datetime(),
  narrativeUpdate: z.string().min(10).max(2000),
  services: z.array(z.object({
    serviceCode: z.string().length(2),
    serviceName: z.string().min(1),
    profitLoss: z.number(),
    profitLossPercent: z.number().min(-100).max(100),
    explanationCategory: z.enum([...]),
    explanationText: z.string().min(5)
  })).min(1)
});
```

### Phase 3: User Interface (Week 3-4)

**Components to Build**:

| Component | Path | Purpose |
|-----------|------|---------|
| WeeklyUpdateForm | `components/budget/WeeklyUpdateForm.tsx` | Data entry with service rows |
| ServicePerformanceRow | `components/budget/ServicePerformanceRow.tsx` | Individual service inputs |
| VarianceExplanationInput | `components/budget/VarianceExplanationInput.tsx` | Template selector + custom text |
| BudgetUpdateList | `components/budget/BudgetUpdateList.tsx` | Filterable history view |
| BudgetUpdateDetail | `components/budget/BudgetUpdateDetail.tsx` | Read-only view with export |

**UI Features**:
- Date picker for "Week Ending"
- Text area for narrative with placeholder: `Update MM/DD. [Description]`
- Dynamic service rows (default: BA, CD, CT, DA)
- Explanation category dropdown with template preview
- Auto-calculation of profit/loss percentage
- Attachments upload (Excel files to Firebase Storage)

### Phase 4: Reporting & Export (Week 4-5)

**Features**:
1. **Dashboard View**: Quarterly trend charts (profit/loss by service over time)
2. **OCFO Report Export**: Generate 4th Quarter Management Report format
3. **WCF Board Slides**: Auto-generate presentation summary
4. **Variance Alerts**: Flag services exceeding ±4% P/L threshold

**Export Formats**:
- Excel (preserves formulas for OCFO submission)
- PDF (for distribution)
- JSON (for system integration)

### Phase 5: Integration & Validation (Week 5-6)

**Tasks**:
1. User acceptance testing with FMB Accountants
2. Validation against historical data (reconcile with Word document)
3. Email notification setup (stakeholders on submission)
4. Role-based access (OITO Director view vs. FMB Accountant entry)
5. Documentation and training materials

---

## Technical Specifications

### Dependencies Required
```json
{
  "react-hook-form": "^7.x",
  "@hookform/resolvers": "^3.x",
  "zod": "^3.x",
  "@tanstack/react-query": "^5.x",
  "recharts": "^2.x"
}
```

### Firestore Security Rules
```javascript
match /weeklyUpdates/{updateId} {
  allow read: if request.auth != null;
  allow create: if request.auth.token.role == 'fmb_accountant';
  allow update: if request.auth.token.role == 'fmb_accountant' 
                && resource.data.status == 'draft';
}
```

### Performance Considerations
- Index on `weekEnding` (desc) for chronological queries
- Index on `serviceCode` + `fiscalYear` for service trend analysis
- Composite index on `status` + `submittedAt` for dashboard queries

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Data Entry Time | < 10 min/update | Time from form open to submission |
| Explanation Consistency | 90% standardized | % using predefined categories |
| Historical Coverage | 100% | All 40 historical updates migrated |
| User Adoption | 80% active use | % of FMB Accountants submitting weekly |
| Export Success | 100% | OCFO reports generated without error |

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| User resistance to new system | Phase-in with parallel Word doc for 4 weeks |
| Data migration errors | Validate all financial figures against source |
| Network connectivity issues | Implement offline draft saving |
| Access control concerns | Role-based permissions with audit logging |

---

## Next Steps

1. **Immediate**: Review and approve data model design
2. **Week 1**: Begin Firestore schema implementation
3. **Week 1-2**: Execute historical data migration
4. **Week 2**: API endpoint development
5. **Week 3**: UI component development
6. **Week 5**: User acceptance testing

**Decision Required**: Should the system enforce the standardized explanation templates as mandatory, or remain optional suggestions to preserve narrative flexibility?

---

*End of Briefing*
