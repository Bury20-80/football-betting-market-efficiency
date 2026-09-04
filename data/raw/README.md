# Raw Football-Data files

The raw CSV files are not committed to the repository. Download them from
[Football-Data.co.uk](https://www.football-data.co.uk/data.php) and place them
under `data/raw/` before running `00_data_preparation_and_validation.ipynb`.

## Expected scope

- Seasons: `2019_20` through `2025_26`
- Leagues per season: 5
- Total source files: 35

League codes used by the project:

| Code | League |
|---|---|
| `E0` | Premier League |
| `D1` | Bundesliga |
| `I1` | Serie A |
| `SP1` | La Liga |
| `F1` | Ligue 1 |

## Folder layout

```text
data/raw/
├── 2019_20/
│   ├── <Premier League CSV>
│   ├── <Bundesliga CSV>
│   ├── <Serie A CSV>
│   ├── <La Liga CSV>
│   └── <Ligue 1 CSV>
├── 2020_21/
├── 2021_22/
├── 2022_23/
├── 2023_24/
├── 2024_25/
└── 2025_26/
```

The preparation notebook reads all CSV files recursively and identifies the
league from the file's internal `Div` column. Historical Football-Data archive
filenames can vary, so the notebook does not rely on the filename itself to
identify the league. The parent folder name is used as the season identifier.

## Validation expectations

Before the files are combined, the notebook checks that:

- exactly 35 CSV files are present,
- each file contains the required match columns,
- each file contains one league code in `Div`,
- the combined dataset contains 12,459 matches,
- match keys are unique.

Historical filename normalization and the source-to-canonical mapping from the
original audit are documented in `reports/file_rename_map.csv`.
