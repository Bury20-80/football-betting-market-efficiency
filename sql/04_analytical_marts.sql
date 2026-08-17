-- ============================================================
-- 04_analytical_marts.sql
-- Power BI-ready analytical summary views.
-- ============================================================


-- ============================================================
-- 1. MARKET OVERVIEW
-- Grain: one row per season and league
-- ============================================================

CREATE OR REPLACE VIEW analytics.mart_market_overview AS

SELECT
    season,
    div,

    COUNT(*) AS matches,

    COUNT(*) FILTER (
        WHERE market_overround > 0
    ) AS avg_market_calibration_matches,

    AVG(market_overround) FILTER (
        WHERE market_overround > 0
    ) AS avg_market_overround_mean,

    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY market_overround)
        FILTER (WHERE market_overround > 0)
        AS avg_market_overround_median,

    AVG(brier_score) FILTER (
        WHERE market_overround > 0
    ) AS avg_market_multiclass_brier_score

FROM analytics.fact_matches

GROUP BY
    season,
    div;


-- ============================================================
-- 2. DATA QUALITY
-- Grain: one row per season and league
-- ============================================================

CREATE OR REPLACE VIEW analytics.mart_data_quality AS

SELECT
    season,
    div,

    COUNT(*) AS matches,

    COUNT(*) FILTER (
        WHERE avg_ch IS NULL
           OR avg_cd IS NULL
           OR avg_ca IS NULL
    ) AS incomplete_avg_closing_rows,

    COUNT(*) FILTER (
        WHERE market_overround <= 0
           OR market_overround IS NULL
    ) AS invalid_avg_market_rows,

    COUNT(*) FILTER (
        WHERE brier_score IS NULL
    ) AS null_brier_score_rows,

    COUNT(*) FILTER (
        WHERE b365_ch IS NULL
           OR b365_cd IS NULL
           OR b365_ca IS NULL
    ) AS incomplete_b365_closing_rows,

    COUNT(*) FILTER (
        WHERE home_shots IS NULL
           OR away_shots IS NULL
           OR home_shots_on_target IS NULL
           OR away_shots_on_target IS NULL
           OR home_fouls IS NULL
           OR away_fouls IS NULL
           OR home_corners IS NULL
           OR away_corners IS NULL
           OR home_yellow_cards IS NULL
           OR away_yellow_cards IS NULL
           OR home_red_cards IS NULL
           OR away_red_cards IS NULL
    ) AS incomplete_match_stats_rows

FROM analytics.fact_matches

GROUP BY
    season,
    div;


-- ============================================================
-- FUTURE MARTS
-- Do not implement before methodological rules are frozen.
-- ============================================================

-- TODO: mart_calibration_bins
-- Requires approved probability-bin boundaries and sparse-bin rules.

-- TODO: mart_favourite_longshot
-- Requires approved odds-band boundaries and sparse-group rules.

-- TODO: mart_home_advantage_period
-- Requires approved league-specific COVID period definitions.

-- TODO: mart_bootstrap_intervals
-- Bootstrap will be calculated in Python and exported for Power BI.


-- ============================================================
-- VALIDATION 1: MARKET OVERVIEW
-- ============================================================

SELECT
    COUNT(*) AS mart_rows,
    COUNT(DISTINCT div) AS league_count,
    COUNT(DISTINCT season) AS season_count,
    COUNT(DISTINCT (div, season)) AS league_season_count,

    SUM(matches) AS mart_matches,
    SUM(avg_market_calibration_matches) AS calibration_matches

FROM analytics.mart_market_overview;


-- ============================================================
-- VALIDATION 2: RECONCILIATION WITH FACT_MATCHES
-- ============================================================

SELECT
    (SELECT COUNT(*)
     FROM analytics.fact_matches) AS source_matches,

    (SELECT SUM(matches)
     FROM analytics.mart_market_overview) AS mart_matches,

    (SELECT COUNT(DISTINCT div)
     FROM analytics.fact_matches) AS source_leagues,

    (SELECT COUNT(DISTINCT season)
     FROM analytics.fact_matches) AS source_seasons,

    (SELECT COUNT(DISTINCT (div, season))
     FROM analytics.fact_matches) AS source_league_seasons;


-- ============================================================
-- VALIDATION 3: DATA QUALITY TOTALS
-- ============================================================

SELECT
    SUM(matches) AS total_matches,
    SUM(incomplete_avg_closing_rows) AS incomplete_avg_closing_rows,
    SUM(invalid_avg_market_rows) AS invalid_avg_market_rows,
    SUM(null_brier_score_rows) AS null_brier_score_rows,
    SUM(incomplete_b365_closing_rows) AS incomplete_b365_closing_rows,
    SUM(incomplete_match_stats_rows) AS incomplete_match_stats_rows

FROM analytics.mart_data_quality;
