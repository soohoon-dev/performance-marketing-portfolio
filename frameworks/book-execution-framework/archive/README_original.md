# 📚 Book-based Execution Framework (MVP)

> **Turning Passive Readers into Active Executors.**  
> A data-driven, behavioral-design framework to close the "Knowledge → Action" gap.

**Live Demo:** https://soohoon-dev.github.io/book-execution-framework/  
**Measurement Plan:** [docs/measurement_plan.md](./docs/measurement_plan.md)

---

## 📊 Real-World Validation: Meta Ads Campaign Test

**Campaign Period:** January 13-19, 2026 (7 days)  
**Objective:** Test market demand and landing page effectiveness with cold traffic

### Campaign Results

| Metric                 | Result | Industry Benchmark | Performance     |
| ---------------------- | ------ | ------------------ | --------------- |
| **Budget Spent**       | $59.24 | -                  | -               |
| **Landing Page Views** | 189    | -                  | -               |
| **CTR (Link Click)**   | 1.965% | 0.9%               | ✅ +118%        |
| **CPC (Link Click)**   | $0.254 | $1.72              | ✅ -85%         |
| **Scroll Rate**        | 22.2%  | 50-60%             | ⚠️ -28 to -38pp |
| **Conversion Rate**    | 0%     | 2-5%               | 🚨 Failed       |

### Key Finding: Acquisition vs Activation Gap

**What Succeeded:**

- ✅ **Ad performance:** 1.97% CTR proves concept resonates
- ✅ **Cost efficiency:** $0.254 CPC demonstrates effective targeting
- ✅ **Demand validation:** High-intent traffic successfully acquired

**What Failed—and Why:**

- ❌ **77.8% bounced without scrolling** - Above-the-fold messaging problem
- ❌ **0 conversions despite 18 form starts** - Mobile input friction
- ❌ **"Homework" perception** - Ad promised "2-min plan," page delivered typing exercise

**Critical Insight:**
Users attempted to engage immediately (`frame_start` events occurred without corresponding `scroll` events), proving **high intent but interface blockage**. This wasn't an audience problem—it was a UX problem.

### Lessons Learned

1. **Acquisition ≠ Activation** - Getting clicks is easy; getting action is hard
2. **Mobile-first is mandatory** - 90%+ Meta traffic is mobile; text input creates massive friction
3. **Promise-delivery match matters** - Ad: "Plan" / Page: "Homework" = abandonment
4. **High intent without action = interface problem** - Users tried to engage but were blocked by UX

📄 **[Full Campaign Analysis](./docs/meta-ads-test-analysis.md)** - Detailed breakdown of failure points, audience insights, and redesign recommendations

### Solution Developed

Based on campaign learnings, redesigned landing page with:

- ✅ Radio buttons replacing text input (reduce 60s typing to 5s selection)
- ✅ Above-the-fold CTA with auto-scroll
- ✅ Progress bar for visual feedback
- ✅ Sticky save button (mobile-optimized)

**Implementation:** [`assets/implementation/after-landing-page.html`](./assets/implementation/after-landing-page.html)

---

## 0) Analytics Case Study (BigQuery + SQL + R)

This repository also includes an analytics case study that demonstrates an end-to-end workflow aligned with the **Google Data Analytics framework**:
**Ask → Prepare → Process → Analyze → Share → Act**

**Quick links**

- **Case study narrative:** [docs/case_study.md](./docs/case_study.md)
- **SQL pipeline:** [`sql/`](./sql/)
- **R Markdown analysis:** [`analysis/01_eda_and_kpis.Rmd`](./analysis/01_eda_and_kpis.Rmd)
- **Exported charts:** [`analysis/output/`](./analysis/output/)
- **Interview script (1-min / 3-min):** [docs/interview_script.md](./docs/interview_script.md)

### Tableau Public dashboard (Share)

- **Live dashboard:** https://public.tableau.com/views/BookExecutionFrameworkMacroFunnelDashboard/MacroFunnelDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
- **Dashboard notes (metrics/filters):** [docs/tableau_dashboard.md](./docs/tableau_dashboard.md)

[![Tableau Public](https://img.shields.io/badge/Tableau%20Public-Live%20Dashboard-4E79A7?style=for-the-badge)](https://public.tableau.com/views/BookExecutionFrameworkMacroFunnelDashboard/MacroFunnelDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### Headline results (dummy dataset)

- Completion rate: **0.535 (53.5%)** (1605 / 3000 reads)
- Action rate among completed reads: **0.3701 (37.0%)** (594 / 1605)
- Reminder opt-in association: **0.4501 (45.0%)** action rate (opt-in=true) vs **0.2842 (28.4%)** (opt-in=false)

> Note: the analytics results come from a **dummy dataset** used to showcase a reproducible pipeline. They should not be treated as real-world estimates.

### Reproduce (high-level)

1. Upload CSVs to BigQuery (Sandbox) into dataset `book_exec_capstone`
2. Run:
   - `sql/01_data_quality_checks.sql`
   - `sql/02_clean_views.sql`
   - `sql/03_kpi_queries.sql`
3. Knit: `analysis/01_eda_and_kpis.Rmd` (exports charts into `analysis/output/`)

---

## 1) Project Overview

- **Role:** Solo builder (Product + Frontend + Tracking + Paid Media)
- **Objective:** Validate whether a structured "Execution Frame" raises post-reading action rates
- **Stack**
  - Frontend: HTML5, CSS3, JavaScript (localStorage)
  - Tracking: Google Tag Manager (GTM), GA4 event taxonomy
  - Paid Media: Meta Ads (Facebook/Instagram)

## 2) Problem → Solution

- **Problem:** Readers rarely translate book insights into action (knowledge–action gap).
- **Hypothesis:** Forcing users to fill a concise execution frame immediately after reading raises action rate by **30%+**.
- **MVP:** A single-page form to define Core Skill, Weak Point, Practice, and Reflections, then save locally.
- **Real-World Test:** Meta Ads campaign validated demand but revealed critical UX friction on mobile

## 3) What's Inside

- Execution form + reflection checkpoints
- Persistence via `localStorage` (no backend for faster iteration)
- Instrumented events: `frame_start`, `opt_in_click`, `form_error`, `frame_save`
- **Meta Ads campaign test** with full performance analysis

---

## 4) Analytics Instrumentation (GTM + GA4)

### Event taxonomy (implementation-level)

| Event name     | When it fires                | Key parameters                  | Why it matters                                          |
| -------------- | ---------------------------- | ------------------------------- | ------------------------------------------------------- |
| `frame_start`  | User focuses an input field  | `field_name`                    | Measures intent and where users begin (top-of-funnel).  |
| `opt_in_click` | User checks an opt-in option | `opt_in_type`                   | Captures retention/interest signals for prioritization. |
| `form_error`   | Validation fails on save     | `error_field`, `error_message`  | Identifies UX friction and drop-off causes.             |
| `frame_save`   | Frame saved successfully     | `book_id`, `input_length_total` | Primary conversion (Key event).                         |

### Evidence (GA4 DebugView + Key events)

**DebugView parameter proof:**

- `frame_start` (`field_name`)  
  ![GA4 DebugView - frame_start](./assets/images/ga4-debugview-frame_start.png)

- `opt_in_click` (`opt_in_type`)  
  ![GA4 DebugView - opt_in_click](./assets/images/ga4-debugview-opt_in_click.png)

- `form_error` (`error_field`, `error_message`)  
  ![GA4 DebugView - form_error](./assets/images/ga4-debugview-form_error.png)

- `frame_save` (`book_id`, `input_length_total`)  
  ![GA4 DebugView - frame_save](./assets/images/ga4-debugview-frame_save.png)

**Key event registration:**

- `frame_save` appears under **Events → Key events**  
  ![GA4 Key events - frame_save](./assets/images/ga4-key-events-frame_save.png)

---

## 5) Skills Demonstrated

This project showcases technical competencies relevant to Performance Marketing + Analytics roles:

### **Paid Media Execution**

- ✅ Meta Ads campaign setup and management
- ✅ Broad targeting strategy for budget-constrained testing
- ✅ Cross-platform tracking (Meta Pixel + GA4)
- ✅ Cost-efficient acquisition ($0.254 CPC vs $1.72 industry avg)

### **Analytics Implementation**

- ✅ GA4 event taxonomy design with custom parameters
- ✅ GTM configuration for multi-event tracking
- ✅ Funnel analysis and drop-off diagnosis
- ✅ Cross-platform attribution (paid social + organic)

### **Data Analysis**

- ✅ BigQuery SQL data pipeline (quality checks → clean views → KPIs)
- ✅ R (tidyverse) for exploratory data analysis
- ✅ Tableau Public dashboard creation
- ✅ Actionable insights from conversion funnel breakdown

### **Problem Diagnosis & Optimization**

- ✅ Identified mobile UX friction through behavioral data
- ✅ Developed evidence-based redesign (radio buttons, sticky CTA)
- ✅ Prevented $200+ waste through early problem detection
- ✅ Budget management and optimization decisions

---

## 6) Run Locally

```bash
git clone https://github.com/soohoon-dev/book-execution-framework.git
cd book-execution-framework
python -m http.server 8000
```

Open: http://localhost:8000

## 7) Deployment (GitHub Pages)

- Settings → Pages → Deploy from branch: `main` / Folder: `/ (root)`
- Auto redeploy in ~1–3 minutes → https://soohoon-dev.github.io/book-execution-framework/

## 8) Project Assets

### **Meta Ads Campaign**

- [Campaign Screenshots](./assets/meta-ads/) - Overview, demographics, targeting
- [Campaign Data (CSV)](./data/) - Full performance metrics
- [Full Analysis Report](./docs/meta-ads-test-analysis.md) - Detailed findings

### **GA4 Analytics**

- [Funnel Visualization](./assets/ga4/ga4-funnel-visualization.png)
- [Device Breakdown](./assets/ga4/ga4-device-breakdown.png)
- [Event Data (CSV)](./data/ga4-event-counts.csv)

### **Implementation**

- [Before Version](./assets/implementation/before-landing-page.html) - Original (failed)
- [After Version](./assets/implementation/after-landing-page.html) - Improved UX
- [GTM Configuration](./assets/implementation/gtm-tag-configuration.png)

---

## 9) Next Improvements (Backlog)

**Immediate (Based on Meta Ads Learnings):**

- [ ] Deploy improved landing page (radio buttons, mobile-first)
- [ ] Re-test with $100 budget to validate UX improvements
- [ ] Implement A/B test framework for CTA variations

**Technical:**

- [ ] Add OG/Twitter meta tags and favicon
- [ ] Run Lighthouse for performance/accessibility
- [ ] Add 404 page; cache-bust static assets (`?v=1`)
- [ ] Automate event QA checks (GTM Preview / GA4 DebugView checklist)

**Scale (If 3%+ conversion achieved):**

- [ ] Refine targeting to age 35-54 + business book interests
- [ ] Expand to Google Ads Display for comparison
- [ ] Implement email capture for nurture sequence

---

## 10) Key Takeaways

### For Employers/Recruiters

This project demonstrates:

1. **Full-stack marketing capability** - From campaign setup to data analysis to UX optimization
2. **Data-driven problem solving** - Used GA4 funnel analysis to diagnose exact failure point
3. **Cost consciousness** - Spent $59 to learn what would have cost $200+ to discover through scaling
4. **Honest analysis** - 0% conversion rate taught more than vanity metrics would have
5. **Technical depth** - GA4/GTM implementation, BigQuery SQL, R analysis, Tableau visualization

### The Real Lesson

**"Traffic is easy, but Activation is hard."**

This campaign proved demand exists (high CTR, low CPC) but revealed that mobile UX friction kills conversion. The solution isn't better ads—it's better design.

---

**Author:** Soo Hoon Yu  
**Portfolio:** [github.com/soohoon-dev](https://github.com/soohoon-dev)  
**Project Type:** Solo end-to-end execution (Product + Frontend + Analytics + Paid Media)
