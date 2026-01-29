-- Book Execution Framework — Clean Views (BigQuery Sandbox, DATE-safe)
-- Project: refined-iridium-478011-r3
-- Dataset: book_exec_capstone
--
-- Role in Google Data Analytics framework: PROCESS
-- This script creates cleaned/standardized VIEWS on top of the raw uploaded tables.
--
-- IMPORTANT (Sandbox UI Upload + Auto-detect):
-- - Your date columns (e.g., start_date) are already typed as DATE in the raw tables.
-- - Therefore we DO NOT use PARSE_DATE() here (it would error: PARSE_DATE expects STRING).
-- - Instead, we keep DATE columns as-is and focus on standardization + safe casting.

-- =========================================================
-- 1) Clean dim_book_metadata
--    - Normalize category values (Business/BUSINESS/Biz -> BUSINESS, etc.)
--    - Convert page_count=-100 to NULL
-- =========================================================
CREATE OR REPLACE VIEW `refined-iridium-478011-r3.book_exec_capstone.v_dim_book_metadata` AS
SELECT
  SAFE_CAST(book_id AS INT64) AS book_id,
  title,
  CASE
    WHEN UPPER(category) IN ('BUSINESS', 'BIZ') THEN 'BUSINESS'
    WHEN UPPER(category) = 'ECONOMICS' THEN 'ECONOMICS'
    WHEN UPPER(category) = 'MARKETING' THEN 'MARKETING'
    WHEN UPPER(category) = 'TECHNOLOGY' THEN 'TECHNOLOGY'
    WHEN UPPER(category) IN ('SELF-HELP', 'SELF HELP', 'SELFHELP') THEN 'SELF-HELP'
    ELSE UPPER(category)
  END AS category,
  -- treat -100 as an invalid placeholder in the dummy data
  CASE
    WHEN SAFE_CAST(page_count AS INT64) < 0 THEN NULL
    ELSE SAFE_CAST(page_count AS INT64)
  END AS page_count,
  SAFE_CAST(has_action_guide AS BOOL) AS has_action_guide,
  SAFE_CAST(difficulty AS INT64) AS difficulty
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_book_metadata`;

-- =========================================================
-- 2) Clean dim_user_profiles
--    - Keep signup_date as DATE (already DATE in raw table)
-- =========================================================
CREATE OR REPLACE VIEW `refined-iridium-478011-r3.book_exec_capstone.v_dim_user_profiles` AS
SELECT
  SAFE_CAST(user_id AS INT64) AS user_id,
  occupation,
  acquisition_channel,
  subscription_tier,
  signup_date  -- DATE-safe: no PARSE_DATE
FROM `refined-iridium-478011-r3.book_exec_capstone.dim_user_profiles`;

-- =========================================================
-- 3) Clean fact_reading_logs
--    - Keep all *_date columns as DATE (already DATE in raw table)
--    - Ensure boolean columns are BOOL
-- =========================================================
CREATE OR REPLACE VIEW `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs` AS
SELECT
  SAFE_CAST(log_id AS INT64) AS log_id,
  SAFE_CAST(user_id AS INT64) AS user_id,
  SAFE_CAST(book_id AS INT64) AS book_id,
  start_date,                -- DATE-safe: no PARSE_DATE
  completion_date,           -- DATE-safe: no PARSE_DATE
  SAFE_CAST(is_completed AS BOOL) AS is_completed,
  SAFE_CAST(reminder_opt_in AS BOOL) AS reminder_opt_in,
  SAFE_CAST(action_performed AS BOOL) AS action_performed,
  action_verification_date   -- DATE-safe: no PARSE_DATE
FROM `refined-iridium-478011-r3.book_exec_capstone.fact_reading_logs`;

-- =========================================================
-- 4) Analysis-ready joined view (enriched)
-- =========================================================
CREATE OR REPLACE VIEW `refined-iridium-478011-r3.book_exec_capstone.v_reading_logs_enriched` AS
SELECT
  f.*,
  b.title,
  b.category AS book_category,
  b.page_count,
  b.has_action_guide,
  b.difficulty,
  u.occupation,
  u.acquisition_channel,
  u.subscription_tier,
  u.signup_date
FROM `refined-iridium-478011-r3.book_exec_capstone.v_fact_reading_logs` f
LEFT JOIN `refined-iridium-478011-r3.book_exec_capstone.v_dim_book_metadata` b USING (book_id)
LEFT JOIN `refined-iridium-478011-r3.book_exec_capstone.v_dim_user_profiles` u USING (user_id);