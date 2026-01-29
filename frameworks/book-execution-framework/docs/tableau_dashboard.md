# Tableau Public Dashboard — Macro Funnel

**Live dashboard:** https://public.tableau.com/views/BookExecutionFrameworkMacroFunnelDashboard/MacroFunnelDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

## What this dashboard shows
- **KPI volume:** Started, Completed, Verified
- **Rates:** Completion Rate, Verified Rate (of Completed)
- **Macro funnel chart:** Started → Completed → Verified
- **Action Impact (Guide):** Comparison of verified action rate by `Has Action Guide`

## Filters (interactive)
- Book Category
- Difficulty

## Metric definitions
- **Started:** `COUNTD(log_id)`
- **Completed:** `SUM(Completed Flag)` where Completed Flag = 1 if `is_completed` is true
- **Verified:** `SUM(Verified Flag)` where Verified Flag = 1 if `action_verification_date` is not null
- **Completion Rate:** Completed / Started
- **Verified Rate (of Completed):** Verified / Completed