# Extract data dictionaries from week readmes

Extract data dictionaries from week readmes

## Usage

``` r
.extract_dataset_dictionaries(tt_data)
```

## Arguments

- tt_data:

  A `tt_data` object from
  [`tidytuesdayR::tt_load()`](https://dslc-io.github.io/tidytuesdayR/reference/tt_load.html).

## Value

A named list of `tbl_df`s, with one tibble per dataset. The tibbles have
columns `variable` and `description`, and either one row per variable or
0 rows.
