# Load the TidyTuesday week summaries

TidyTuesday has published a new dataset weekly since April 2018. This
function gets the table of information about each of those weeks.

## Usage

``` r
get_tt_tbl(min_year = 2018L, max_year = this_year())
```

## Arguments

- min_year:

  The minimum year to include, between 2018 and now.

- max_year:

  The maximum year to include, between 2018 and now.

## Value

A `tt_tbl` tibble of information about TidyTuesday weeks in the
requested timeframe.
