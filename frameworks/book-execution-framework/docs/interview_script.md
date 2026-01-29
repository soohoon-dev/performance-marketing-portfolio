# Interview Script — Book Execution Framework (Reading → Action)

## 1-minute version
I built an analytics case study using the Google Data Analytics framework: Ask, Prepare, Process, Analyze, Share, and Act.  
The business question was: **what drives readers to convert book completion into verified action?**

I uploaded a dummy dataset into BigQuery, ran data quality checks, then created cleaned views to standardize categories and handle invalid values.  
From 3,000 reading logs, the completion rate was **53.5%**, and the action rate among completed reads was **~37.0%**.

A key insight was that reminder opt-in users had a higher action rate: **45.0% vs 28.4%** for non-opt-in users (association, not causation).  
Based on this, I recommended improving the reminder opt-in funnel and adding follow-ups in the 1–10 day window, since verification often happens within that timeframe.

## 3-minute version
### Context / Goal
This project models a “reading → action” funnel. The main KPI is:
- **Action rate among completed reads** = completed reads with action / completed reads

### Data + Tools
- Dummy CSVs uploaded into BigQuery Sandbox (`book_exec_capstone`)
- SQL pipeline:
  1) `sql/01_data_quality_checks.sql` — QA metrics
  2) `sql/02_clean_views.sql` — reproducible cleaning as views
  3) `sql/03_kpi_queries.sql` — KPI tables and segment breakdowns
- Visualization + narrative in `analysis/01_eda_and_kpis.Rmd` exporting charts to `analysis/output/`

### Process (what I checked / fixed)
- Missing `user_id` rate was low (~0.33%), so segmentation is reliable
- Small number of inconsistent dates (completion before start) were flagged for exclusion in date-delta analyses
- Standardized category values (Business/BUSINESS/Biz → BUSINESS)
- Treated negative page counts as invalid placeholders

### Analysis (numbers)
- Total reads: 3,000
- Completed reads: 1,605 → completion rate **53.5%**
- Completed with action: 594 → action rate among completed **~37.0%**
- Reminder opt-in association: **45.0% vs 28.4%**

### Recommendations
- Improve reminder opt-in onboarding/UX and test causality (A/B test)
- Trigger follow-ups in the 1–10 day post-completion window to increase verification
- Validate whether action guides consistently increase conversion and prioritize that content type