-- ============================================================
-- 03_fact_selections.sql
-- Grain: three rows per match (H / D / A)
--
-- AvgC probabilities -> market calibration
-- Bet365 closing odds -> ROI
-- ============================================================

CREATE OR REPLACE VIEW analytics.fact_selections AS

SELECT
    m.match_id,
    m.season,
    m.div,
    m.match_date,
    m.home_team,
    m.away_team,

    s.selection_type,
    s.selection_won,
    s.market_raw_implied_probability,
    s.market_no_vig_probability,
    s.b365_closing_odds,

    CASE
        WHEN s.b365_closing_odds IS NULL OR s.selection_won IS NULL THEN NULL
        WHEN s.selection_won = 1 THEN s.b365_closing_odds - 1
        ELSE -1
    END AS profit_1u,

    m.market_overround > 0 AS avg_market_calibration_eligible

FROM analytics.fact_matches AS m

CROSS JOIN LATERAL (
    VALUES
        ('H', m.y_home, 1.0 / NULLIF(m.avg_ch, 0), m.p_home, m.b365_ch),
        ('D', m.y_draw, 1.0 / NULLIF(m.avg_cd, 0), m.p_draw, m.b365_cd),
        ('A', m.y_away, 1.0 / NULLIF(m.avg_ca, 0), m.p_away, m.b365_ca)
) AS s (
    selection_type,
    selection_won,
    market_raw_implied_probability,
    market_no_vig_probability,
    b365_closing_odds
);


-- ============================================================
-- Validation
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT match_id) AS unique_matches,

    COUNT(*) FILTER (WHERE selection_type = 'H') AS home_rows,
    COUNT(*) FILTER (WHERE selection_type = 'D') AS draw_rows,
    COUNT(*) FILTER (WHERE selection_type = 'A') AS away_rows,

    COUNT(*) FILTER (WHERE selection_won = 1) AS winning_selections,
    COUNT(*) FILTER (WHERE selection_won IS NULL) AS null_selection_won,

    COUNT(*) FILTER (
        WHERE b365_closing_odds IS NULL
    ) AS missing_b365_closing_odds,

    COUNT(*) FILTER (
        WHERE avg_market_calibration_eligible IS NOT TRUE
    ) AS calibration_ineligible_rows

FROM analytics.fact_selections;


-- we hope to get 3 ineligible_rows, because of Barca - Mallorca anomaly