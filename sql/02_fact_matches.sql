-- ============================================================
-- 02_fact_matches.sql
-- Grain: one row per match
-- Purpose:
--   1. Convert average closing odds into implied probabilities.
--   2. Remove the market overround proportionally.
--   3. Encode the actual match result.
--   4. Calculate the multiclass Brier Score.
-- ============================================================
CREATE OR REPLACE VIEW analytics.fact_matches AS

WITH raw_probabilities AS (
    SELECT
        s.*,

        1.0 / NULLIF(s.avg_ch, 0) AS raw_prob_home,
        1.0 / NULLIF(s.avg_cd, 0) AS raw_prob_draw,
        1.0 / NULLIF(s.avg_ca, 0) AS raw_prob_away,

        (s.ftr = 'H')::INTEGER AS y_home,
        (s.ftr = 'D')::INTEGER AS y_draw,
        (s.ftr = 'A')::INTEGER AS y_away

    FROM staging.matches_clean AS s
),

probability_totals AS (
    SELECT
        r.*,

        r.raw_prob_home
        + r.raw_prob_draw
        + r.raw_prob_away
            AS implied_probability_sum

    FROM raw_probabilities AS r
),

normalized_probabilities AS (
    SELECT
        p.*,

        p.implied_probability_sum - 1.0
            AS market_overround,

        p.raw_prob_home
        / NULLIF(p.implied_probability_sum, 0)
            AS p_home,

        p.raw_prob_draw
        / NULLIF(p.implied_probability_sum, 0)
            AS p_draw,

        p.raw_prob_away
        / NULLIF(p.implied_probability_sum, 0)
            AS p_away

    FROM probability_totals AS p
),

scored_matches AS (
    SELECT
        n.*,

        POWER(n.p_home - n.y_home, 2)
        + POWER(n.p_draw - n.y_draw, 2)
        + POWER(n.p_away - n.y_away, 2)
            AS brier_score

    FROM normalized_probabilities AS n
)

SELECT
    match_id,
    season,
    source_file,
    div,
    match_date,
    kickoff_time,
    home_team,
    away_team,
    fthg,
    ftag,
    ftr,

    home_shots,
    away_shots,
    home_shots_on_target,
    away_shots_on_target,
    home_fouls,
    away_fouls,
    home_corners,
    away_corners,
    home_yellow_cards,
    away_yellow_cards,
    home_red_cards,
    away_red_cards,

    avg_h,
    avg_d,
    avg_a,
    avg_ch,
    avg_cd,
    avg_ca,

    b365_h,
    b365_d,
    b365_a,
    b365_ch,
    b365_cd,
    b365_ca,

    max_ch,
    max_cd,
    max_ca,

    market_overround,
    p_home,
    p_draw,
    p_away,

    y_home,
    y_draw,
    y_away,

    brier_score

FROM scored_matches;


-- ============================================================
-- Validation
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT match_id) AS unique_match_ids,

    COUNT(*) FILTER (
        WHERE y_home + y_draw + y_away <> 1
    ) AS invalid_outcome_flags,

    COUNT(*) FILTER (
        WHERE market_overround IS NULL
           OR p_home IS NULL
           OR p_draw IS NULL
           OR p_away IS NULL
    ) AS null_market_metrics,

    COUNT(*) FILTER (
        WHERE ABS(
            p_home
            + p_draw
            + p_away
            - 1.0
        ) > 0.000000000001
    ) AS invalid_probability_sums,

    COUNT(*) FILTER (
        WHERE brier_score IS NULL
    ) AS null_brier_scores,

    COUNT(*) FILTER (
        WHERE brier_score < 0
           OR brier_score > 2
    ) AS invalid_brier_scores

FROM analytics.fact_matches;
