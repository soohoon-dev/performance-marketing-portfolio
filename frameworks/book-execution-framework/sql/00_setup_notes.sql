-- Book Execution Framework — BigQuery Sandbox Setup Notes
-- Project: refined-iridium-478011-r3
-- Dataset: book_exec_capstone
--
-- Purpose
-- - This repository uses the Google Data Analytics workflow (Ask–Prepare–Process–Analyze–Share–Act).
-- - In this sandbox environment, the "Prepare" step (loading raw data) was done via the
--   BigQuery Console UI using: Create table → Upload (CSV) → Auto-detect schema.
-- - This file exists to document that setup so others can reproduce it.
--
-- How to reproduce (UI)
-- 1) BigQuery → Select project `refined-iridium-478011-r3`
-- 2) Create dataset: `book_exec_capstone` (location should match your sandbox default)
-- 3) For each CSV file below:
--    - Click dataset `book_exec_capstone` → Create table
--    - Source: Upload (CSV), Skip header rows = 1, Auto detect = ON
--    - Destination table name: as listed below
--
-- Raw source files (in this repo)
-- - data/fact_reading_logs.csv
-- - data/dim_book_metadata.csv
-- - data/dim_user_profiles.csv
--
-- Tables created in BigQuery (raw layer)
-- - `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
-- - `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`
-- - `refined-iridium-478011-r3.book_exec_capstone.dim_user_profiles`
--
-- Notes / schema expectations (used by downstream SQL views)
-- 1) fact_reading_logs (one row per reading log)
--    - log_id: INT64 (unique key)
--    - user_id: INT64 (nullable; missing values exist in the dummy data)
--    - book_id: INT64
--    - start_date: DATE-like string in CSV (YYYY-MM-DD)
--    - completion_date: DATE-like string in CSV (YYYY-MM-DD, nullable)
--    - is_completed: BOOL-like (True/False)
--    - reminder_opt_in: BOOL-like (True/False)
--    - action_performed: BOOL-like (True/False)
--    - action_verification_date: DATE-like string in CSV (YYYY-MM-DD, nullable)
--
-- 2) dim_book_metadata (one row per book)
--    - book_id: INT64 (unique key)
--    - title: STRING
--    - category: STRING (inconsistent casing/labels exist: e.g., Business, BUSINESS, Biz)
--    - page_count: INT64-like (dummy data contains invalid values like -100)
--    - has_action_guide: BOOL-like (True/False)
--    - difficulty: INT64
--
-- 3) dim_user_profiles (one row per user)
--    - user_id: INT64 (unique key)
--    - occupation: STRING
--    - acquisition_channel: STRING
--    - subscription_tier: STRING
--    - signup_date: DATE-like string in CSV (YYYY-MM-DD)
--
-- Downstream (Process/Analyze)
-- - Cleaned views and KPI queries are defined in:
--   - sql/02_data_quality_checks.sql
--   - sql/03_clean_views.sql
--   - sql/04_kpi_queries.sql
--
-- Quick sanity checks (optional)
-- Row counts
SELECT 'fact_reading_logs' AS table_name, COUNT(*) AS rows
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`
UNION ALL
SELECT 'dim_book_metadata' AS table_name, COUNT(*) AS rows
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`
UNION ALL
SELECT 'dim_user_profiles' AS table_name, COUNT(*) AS rows
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_user_profiles`;