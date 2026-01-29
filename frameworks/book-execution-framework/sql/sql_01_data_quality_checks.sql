-- Book Execution Framework — Data Quality Checks (BigQuery Sandbox)
-- Project: refined-iridium-478011-r3
-- Dataset: book_exec_capstone
--
-- Role in Google Data Analytics framework: PROCESS
-- Goal: Run QA checks on the raw uploaded tables and return metrics in "report-ready" format.
--
-- How to use
-- 1) Run each section and copy the output rows into docs/case_study.md (Process section).
-- 2) This script is designed to produce compact result tables (metric_name, metric_value, notes).

-- =========================================================
-- A) FACT: Missing keys (user_id)
-- =========================================================
SELECT
  'fact_reading_logs.missing_user_id_rows' AS metric_name,
  CAST(COUNTIF(user_id IS NULL) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT
  'fact_reading_logs.total_rows' AS metric_name,
  CAST(COUNT(*) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT
  'fact_reading_logs.missing_user_id_rate' AS metric_name,
  CAST(SAFE_DIVIDE(COUNTIF(user_id IS NULL), COUNT(*)) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`;

-- =========================================================
-- B) DIM: Invalid values (page_count)
-- =========================================================
SELECT
  'dim_book_metadata.negative_page_count_rows' AS metric_name,
  CAST(COUNTIF(SAFE_CAST(page_count AS INT64) < 0) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`
UNION ALL
SELECT
  'dim_book_metadata.total_books' AS metric_name,
  CAST(COUNT(*) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`;

-- =========================================================
-- C) FACT: Date completeness (NULLs)
-- =========================================================
SELECT
  'fact_reading_logs.null_start_date' AS metric_name,
  CAST(COUNTIF(start_date IS NULL) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT
  'fact_reading_logs.null_completion_date' AS metric_name,
  CAST(COUNTIF(completion_date IS NULL) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT
  'fact_reading_logs.null_action_verification_date' AS metric_name,
  CAST(COUNTIF(action_verification_date IS NULL) AS STRING) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`;

-- =========================================================
-- D) FACT: Date logic sanity checks
-- =========================================================
SELECT
  'fact_reading_logs.completion_before_start_rows' AS metric_name,
  CAST(
    COUNTIF(completion_date IS NOT NULL AND start_date IS NOT NULL AND completion_date < start_date)
    AS STRING
  ) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT
  'fact_reading_logs.verification_before_completion_rows' AS metric_name,
  CAST(
    COUNTIF(action_verification_date IS NOT NULL AND completion_date IS NOT NULL AND action_verification_date < completion_date)
    AS STRING
  ) AS metric_value
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`;

-- =========================================================
-- E) DIM: Category value distribution (for standardization mapping)
-- =========================================================
-- This returns a separate table (not metric_name/value) because it is used to design the mapping.
SELECT
  category,
  COUNT(*) AS books
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`
GROUP BY category
ORDER BY books DESC, category;