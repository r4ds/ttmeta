# Load and parse metadata about a TidyTuesday week

Load a week's TidyTuesday dataset(s), and calculate metadata.

## Usage

``` r
get_tt_week_metadata(year, week)
```

## Arguments

- year:

  The year of the dataset.

- week:

  The integer week of that dataset within that year. Note that this is
  the TidyTuesday week number, not necessarily the week number of that
  year.

## Value

A tbl_df with columns year, week, dataset_name, variables (number of
columns), observations (number of rows), and variable_details (names,
classes, n_unique (number of unique observations), min (or first
alphabetically) and max (or last alphabetically) of all variables).
