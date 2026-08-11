# Load and parse metadata about TidyTuesday datasets

Load data week-by-week for all weeks in a tt_week_summaries, and parse
the datasets for information such as number of variables and number of
observations.

## Usage

``` r
get_tt_datasets_metadata(tt_tbl)
```

## Arguments

- tt_tbl:

  A `tt_tbl` table returned by
  [`get_tt_tbl()`](https://r4ds.github.io/ttmeta/reference/get_tt_tbl.md).

## Value

A tbl_df with columns year, week, dataset_name, variables (number of
columns), observations (number of rows), and variable_details (names and
classes of all variables).

## See also

[`tt_datasets_metadata`](https://r4ds.github.io/ttmeta/reference/tt_datasets_metadata.md)
the resulting dataset.
