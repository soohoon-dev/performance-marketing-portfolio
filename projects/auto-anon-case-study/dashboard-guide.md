# Automotive DV360 Case Study — Looker Studio Dashboard (Build Notes)

This document explains how to build a simple, recruiter-friendly Looker Studio dashboard using the anonymized campaign comparison CSVs.

## Data files
CSV folder: assets/files/auto-anon/

Recommended CSVs:
- dv360_ctv_comparison.csv
- programmatic_display_sales.csv
- programmatic_display_launch.csv
- youtube_video_launch.csv
- youtube_video_sales.csv
- paid_search_comparison.csv

Tip: Upload each CSV into Google Sheets (one sheet per file) for easier Looker Studio connections.

---

## Dashboard structure (4 pages)

### Page 1 — Summary
Goal: show the 4 headline improvements in 10 seconds.
- Scorecard: Display sales CTR (0.18% → 3.86%)
- Scorecard: Display sales CPC ($0.66 → $0.05)
- Scorecard: CTV CPM ($8.87 → $6.34)
- Scorecard: YouTube views (372,516 → 700,601)

### Page 2 — Display
- Table: display launch + sales rows
- Bar chart: CTR by campaign
- Bar chart: CPC by campaign

### Page 3 — Video (CTV + YouTube)
- Gauge: CTV completion rate (98%)
- Comparison charts: CPM (CTV), CPV/CPM (YouTube)
- Funnel chart (YouTube): 25% → 50% → 75% → 100%

### Page 4 — Search
- Table: paid search comparison
- Bar chart: CTR before vs after
- Scatter: impressions vs CTR (optional)

---

## Styling
- 2021: Red
- 2024: Yellow
- 2025: Green

Keep labels literal (no claims beyond the report). Add a small “Data notes” box:
- Campaign durations vary (14–29 days). Metrics shown as provided by client reports.

---

## Publishing
- Share: Anyone with the link can view
- Paste the link into:
  - projects/[auto-anon-case-study.md](http://auto-anon-case-study.md) (Dashboard section)
  - optionally portfolio/[README.md](http://README.md) as a featured link
```