-- PostgreSQL staging layer for the canonical output of
-- notebooks/00_data_preparation_and_validation.ipynb.
-- Create the table before loading data with COPY or a database-loading script.

CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS analytics;


CREATE TABLE IF NOT EXISTS staging.matches_clean (
    match_id TEXT PRIMARY KEY,
    season TEXT NOT NULL,
    source_file TEXT NOT NULL,
    div TEXT NOT NULL,
    match_date DATE NOT NULL,
    kickoff_time TEXT,
    home_team TEXT NOT NULL,
    away_team TEXT NOT NULL,
    fthg INTEGER NOT NULL,
    ftag INTEGER NOT NULL,
    ftr CHAR(1) NOT NULL,

    home_shots INTEGER,
    away_shots INTEGER,
    home_shots_on_target INTEGER,
    away_shots_on_target INTEGER,
    home_fouls INTEGER,
    away_fouls INTEGER,
    home_corners INTEGER,
    away_corners INTEGER,
    home_yellow_cards INTEGER,
    away_yellow_cards INTEGER,
    home_red_cards INTEGER,
    away_red_cards INTEGER,

    avg_h NUMERIC,
    avg_d NUMERIC,
    avg_a NUMERIC,

    avg_ch NUMERIC,
    avg_cd NUMERIC,
    avg_ca NUMERIC,

    b365_h NUMERIC,
    b365_d NUMERIC,
    b365_a NUMERIC,

    b365_ch NUMERIC,
    b365_cd NUMERIC,
    b365_ca NUMERIC,

    max_ch NUMERIC,
    max_cd NUMERIC,
    max_ca NUMERIC,

    CONSTRAINT valid_result
        CHECK (ftr IN ('H', 'D', 'A'))
);
