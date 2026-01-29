# Book Execution Framework: GA4/GTM Implementation

**Project Type**: Personal R&D - Analytics workflow demonstration

**Objective**: Build end-to-end measurement pipeline (GA4 → BigQuery → R → Tableau) using a simple web application as the test environment.

---

## 🛠️ Skills Demonstrated

### Analytics Implementation

- **GA4 Event Taxonomy**: Designed 4 custom events (`frame_start`, `opt_in_click`, `form_error`, `frame_save`) with custom parameters
- **GTM Configuration**: Set up event triggers and tested via DebugView
- **Funnel Analysis**: Diagnosed user drop-off points through conversion funnel tracking

### Data Analysis

- **BigQuery SQL**: Built data pipeline (quality checks → clean views → KPI queries)
- **R (Tidyverse)**: Conducted exploratory analysis and generated visualizations
- **Tableau Public**: Created interactive dashboard for metric visualization

### Paid Media Testing

- **Meta Ads Campaign**: Executed 7-day test ($59 budget) to validate demand
- **Cross-Platform Tracking**: Implemented Meta Pixel + GA4 integration
- **Performance Analysis**: Analyzed campaign results and identified optimization opportunities

---

## 📊 Key Findings

Ran a Meta Ads test to validate concept viability:

**Acquisition Phase (Success)**:

- CTR: 1.97% (vs. 0.9% benchmark)
- CPC: $0.254 (vs. $1.72 benchmark)
- Landing Page Views: 189

**Activation Phase (Learning)**:

- Conversion Rate: 0% (mobile UX friction identified)
- Root Cause: Text input on mobile created abandonment
- Solution: Redesigned with radio buttons and mobile-first UX

**Takeaway**: GA4 funnel analysis revealed that traffic acquisition succeeded but user activation failed due to interface friction, not audience mismatch. This informed UX redesign recommendations.

---

## 📂 Technical Assets

- **Frontend Demo**: [View Local Demo](./index.html)
- **Tableau Dashboard**: [View Dashboard](https://public.tableau.com/views/BookExecutionFrameworkMacroFunnelDashboard/)
- **Meta Ads Analysis**: [Full Report](./docs/meta-ads-test-analysis.md)
- **SQL Queries**: [View Code](./sql/)
- **R Analysis**: [View RMarkdown](./analysis/01_eda_and_kpis.Rmd)
- **GA4 Screenshots**: [Event Evidence](./assets/ga4/)

---

## 🎯 Project Context

This is a **technical portfolio project** demonstrating analytics implementation capabilities. For business impact case studies with client results, see:

- [Automotive DV360 Optimization](../case-studies/automotive-dv360/) ($2.5M managed, 2,044% CTR growth)
- [Skincare Lead Optimization](../case-studies/skincare-analytics/) (SQL-driven insights)

---

**Tech Stack**: GA4, GTM, BigQuery, SQL, R, Tableau, Meta Ads, HTML/CSS/JavaScript
