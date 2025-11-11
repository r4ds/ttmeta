# Get a table from a particular TidyTuesday year readme

Get a table from a particular TidyTuesday year readme

## Usage

``` r
.tt_year_readme_table(year, table_number)
```

## Arguments

- year:

  The year of the desired README.

- table_number:

  Which table on the page to load. I do not currently validate this, so
  errors might be confusing if you send in a number higher than the
  number of tables in that README.

## Value

An xml node_set containing the body of the table.
