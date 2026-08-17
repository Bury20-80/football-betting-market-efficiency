# Football CSV Data Quality Audit

## Decision

The dataset is **ready for canonical ingestion**, subject to filename normalization and the documented odds-completeness filters.

## Dataset summary

- Files audited: **35**
- Seasons: **7**
- League codes: **5**
- Match rows: **12,459**
- Distinct schemas: **6**
- Files whose filename does not match internal `Div`: **30**
- Complete average closing 1X2 trios: **12,459 (100.0%)**
- Complete Bet365 closing 1X2 trios: **12,458 (100.0%)**
- Files with a core integrity failure: **0**

## Coverage by league

| League | Files | Matches | Avg closing coverage | Bet365 closing coverage |
|---|---:|---:|---:|---:|
| D1 | 7 | 2,142 | 100.0% | 100.0% |
| E0 | 7 | 2,660 | 100.0% | 100.0% |
| F1 | 7 | 2,337 | 100.0% | 100.0% |
| I1 | 7 | 2,660 | 100.0% | 100.0% |
| SP1 | 7 | 2,660 | 100.0% | 100.0% |

## League-season matrix

`Match stats` is the minimum coverage across shots, shots on target, fouls, corners, yellow cards, and red cards.

| Season | Div | Source file | Rows | Columns | AvgC coverage | B365C coverage | Match stats | Filename = Div |
|---|---|---|---:|---:|---:|---:|---:|---|
| 2019_20 | D1 | D7.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2019_20 | E0 | E6.csv | 380 | 106 | 100.0% | 100.0% | 100.0% | no |
| 2019_20 | F1 | F7.csv | 279 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2019_20 | I1 | I7.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2019_20 | SP1 | SP7.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2020_21 | D1 | D6.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2020_21 | E0 | E5.csv | 380 | 106 | 100.0% | 100.0% | 100.0% | no |
| 2020_21 | F1 | F6.csv | 380 | 105 | 100.0% | 99.7% | 100.0% | no |
| 2020_21 | I1 | I6.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2020_21 | SP1 | SP6.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2021_22 | D1 | D5.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2021_22 | E0 | E4.csv | 380 | 106 | 100.0% | 100.0% | 100.0% | no |
| 2021_22 | F1 | F5.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2021_22 | I1 | I5.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2021_22 | SP1 | SP5.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2022_23 | D1 | D4.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2022_23 | E0 | E3.csv | 380 | 106 | 100.0% | 100.0% | 100.0% | no |
| 2022_23 | F1 | F4.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2022_23 | I1 | I4.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2022_23 | SP1 | SP4.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2023_24 | D1 | D3.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2023_24 | E0 | E2.csv | 380 | 106 | 100.0% | 100.0% | 100.0% | no |
| 2023_24 | F1 | F3.csv | 306 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2023_24 | I1 | I3.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2023_24 | SP1 | SP3.csv | 380 | 105 | 100.0% | 100.0% | 100.0% | no |
| 2024_25 | D1 | D2.csv | 306 | 119 | 100.0% | 100.0% | 99.7% | no |
| 2024_25 | E0 | E1.csv | 380 | 120 | 100.0% | 100.0% | 100.0% | no |
| 2024_25 | F1 | F2.csv | 306 | 119 | 100.0% | 100.0% | 100.0% | no |
| 2024_25 | I1 | I2.csv | 380 | 119 | 100.0% | 100.0% | 100.0% | no |
| 2024_25 | SP1 | SP2.csv | 380 | 119 | 100.0% | 100.0% | 100.0% | no |
| 2025_26 | D1 | D1.csv | 306 | 131 | 100.0% | 100.0% | 100.0% | yes |
| 2025_26 | E0 | E0.csv | 380 | 132 | 100.0% | 100.0% | 100.0% | yes |
| 2025_26 | F1 | F1.csv | 306 | 131 | 100.0% | 100.0% | 100.0% | yes |
| 2025_26 | I1 | I1.csv | 380 | 131 | 100.0% | 100.0% | 100.0% | yes |
| 2025_26 | SP1 | SP1.csv | 380 | 131 | 100.0% | 100.0% | 100.0% | yes |

## Critical findings

### Filename drift

The archive contains files such as `E6.csv`, `D7.csv`, and `SP7.csv`, although their internal league codes remain `E0`, `D1`, and `SP1`. These appear to be automatic duplicate-download suffixes rather than real division codes. Using filenames as league identifiers would silently assign incorrect leagues.

### Schema drift

There are **6 distinct ordered schemas** across the 35 files. The pipeline must select columns by name, tolerate optional fields, and never union raw files by column position.

### Odds coverage

Closing-odds analysis must use complete H/D/A trios. A missing value in any one member of a trio invalidates that match for that particular metric, but it does not require removing the match from every other analysis.

Bet365 closing exceptions:

- `2020_21` / `F1`: 18/10/2020: Monaco vs Montpellier

### Match-stat coverage

Home-advantage metrics must be tested separately from odds coverage. Any league-season with incomplete statistics should be excluded only from the affected statistic, not from the whole dataset.

Match-stat exceptions:

- `2024_25` / `D1`: 14/12/2024: Union Berlin vs Bochum

## Recommended ingestion decisions

- Use `AvgCH/AvgCD/AvgCA` as the primary closing market consensus only after filtering to complete and valid trios.
- Use `B365CH/B365CD/B365CA` for the primary single-book ROI calculation, with explicit coverage reporting.
- Build ingestion from the internal `Div` value and season folder, not from the current filenames.
- Create a canonical processed copy named `{season}_{Div}.csv`; keep the supplied raw archive unchanged.
- Do not use individual Pinnacle, Coral, or Ladbrokes fields as required columns.
- Keep the COVID analysis descriptive and maintain a league-specific period mapping outside the match CSVs.

## Required quality gates

- One unique match key per league, season, date, home team, and away team.
- Full-time result must agree with full-time goals.
- All selected decimal odds must be numeric and greater than 1.00.
- No-vig probabilities must sum to 1 within numerical tolerance.
- Every exclusion must retain an explicit reason.
- Coverage must be reported before league, season, or period comparisons.
- Raw files and their SHA-256 hashes must remain unchanged.

## Generated audit files

- `league_season_coverage.csv` — one row per source CSV with quality and coverage metrics.
- `schema_inventory.csv` — exact ordered column list and schema hash for every source CSV.
- `file_rename_map.csv` — current filenames mapped to canonical `{season}_{Div}.csv` names.

This report is a feasibility and data-contract audit. It does not yet estimate calibration, Brier Score, favourite–longshot bias, or COVID-period effects.
