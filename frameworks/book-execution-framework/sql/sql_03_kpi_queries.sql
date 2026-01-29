-- Book Execution Framework — KPI Queries (Report-ready Tables)
-- Project: refined-iridium-478011-r3
-- Dataset: book_exec_capstone
--
-- Role in Google Data Analytics framework: ANALYZE
-- This script outputs KPIs in "copy/paste friendly" result-table shapes similar to sql/01_data_quality_checks.sql.
--
-- Dependencies (run first):
-- - sql/02_clean_views.sql
--   - `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`
--   - `refined-iridium-478011-r3.book_exec_capstone.v_reading_logs_enriched`
--
-- How to use
-- - Run each section (A~D). Each section returns a small result table you can paste into docs/case_study.md.
-- - Sections are separated because BigQuery returns one result set per query execution.

-- =========================================================
-- A) Overall KPIs (single-row metric table)
-- =========================================================
SELECT
  metric_name,
  metric_value,
  notes
FROM (
  SELECT
    'kpi.total_reads' AS metric_name,
    CAST(COUNT(*) AS STRING) AS metric_value,
    'All rows in v_fact_reading_logs' AS notes
  FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`

  UNION ALL
  SELECT
    'kpi.completed_reads' AS metric_name,
    CAST(COUNTIF(is_completed) AS STRING) AS metric_value,
    'Rows where is_completed=TRUE' AS notes
  FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`

  UNION ALL
  SELECT
    'kpi.completion_rate' AS metric_name,
    CAST(SAFE_DIVIDE(COUNTIF(is_completed), COUNT(*)) AS STRING) AS metric_value,
    'completed_reads / total_reads' AS notes
  FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`

  UNION ALL
  SELECT
    'kpi.completed_with_action' AS metric_name,
    CAST(COUNTIF(is_completed AND action_performed) AS STRING) AS metric_value,
    'Rows where is_completed=TRUE AND action_performed=TRUE' AS notes
  FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`

  UNION ALL
  SELECT
    'kpi.action_rate_completed_only' AS metric_name,
    CAST(
      SAFE_DIVIDE(
        COUNTIF(is_completed AND action_performed),
        COUNTIF(is_completed)
      ) AS STRING
    ) AS metric_value,
    'completed_with_action / completed_reads' AS notes
  FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`
);

-- =========================================================
-- B) Reminder opt-in vs Action Rate (completed-only)
-- =========================================================
SELECT
  'reminder_opt_in' AS segment_type,
  CAST(reminder_opt_in AS STRING) AS segment_value,
  COUNTIF(is_completed) AS completed_reads,
  COUNTIF(is_completed AND action_performed) AS completed_with_action,
  SAFE_DIVIDE(COUNTIF(is_completed AND action_performed), COUNTIF(is_completed)) AS action_rate_completed_only
FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`
GROUP BY reminder_opt_in
ORDER BY segment_value;

-- =========================================================
-- C) Book attributes vs Action Rate (completed-only)
-- Notes:
-- - This output can be large because it groups by 3 dimensions.
-- - You can filter to top categories later if needed.
-- =========================================================
SELECT
  CAST(has_action_guide AS STRING) AS has_action_guide,
  difficulty,
  book_category,
  COUNTIF(is_completed) AS completed_reads,
  COUNTIF(is_completed AND action_performed) AS completed_with_action,
  SAFE_DIVIDE(COUNTIF(is_completed AND action_performed), COUNTIF(is_completed)) AS action_rate_completed_only
FROM `refined-iridium-478011-r3.book_exec_capstone.v_reading_logs_enriched`
GROUP BY has_action_guide, difficulty, book_category
ORDER BY completed_reads DESC;

-- =========================================================
-- D) User segments vs Completion Rate
-- Notes:
-- - Restricted to user_id IS NOT NULL because segmentation requires joining user profiles.
-- =========================================================
SELECT
  acquisition_channel,
  subscription_tier,
  occupation,
  COUNT(*) AS total_reads,
  COUNTIF(is_completed) AS completed_reads,
  SAFE_DIVIDE(COUNTIF(is_completed), COUNT(*)) AS completion_rate
FROM `refined-iridium-478011-r3.book_exec_capstone.v_reading_logs_enriched`
WHERE user_id IS NOT NULL
GROUP BY acquisition_channel, subscription_tier, occupation
ORDER BY total_reads DESC;

-- =========================================================
-- E) Time-to-verification (days) distribution for verified actions
-- =========================================================
SELECT
  COUNT(*) AS verified_actions,
  AVG(DATE_DIFF(action_verification_date, completion_date, DAY)) AS avg_days_to_verification,
  APPROX_QUANTILES(DATE_DIFF(action_verification_date, completion_date, DAY), 5) AS days_to_verification_quantiles
FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs`
WHERE is_completed
  AND action_performed
  AND action_verification_date IS NOT NULL
  AND completion_date IS NOT NULL;