# TidyTuesday dataset metadata

Metadata about the weekly TidyTuesday datasets.

## Usage

``` r
tt_datasets_metadata
```

## Format

A data frame with one row per dataset (555 rows as of 2023-06-05) and 6
variables:

- year:

  (integer) The year in which the dataset was released.

- week:

  (integer) The week number for this dataset within this year.

- dataset_name:

  (character) The name of this dataset. Some weeks have multiple
  datasets.

- variables:

  (integer) The number of columns in this dataset.

- observations:

  (integer) The number of rows in this dataset.

- variable_details:

  (tbl_df) A tibble with a row for each variable, and 6 columns:

  variable

  :   (character) The name of this variable.

  class

  :   (character) the class of this variable.

  n_unique

  :   (integer) the number of unique values of this variable within this
      dataset.

  min

  :   (list) The "lowest" value of this variable (lowest number, first
      value alphabetically, etc).

  max

  :   (list) The "highest" value of this variable (highest number, last
      value alphabetically, etc).

  description

  :   (character) A short description of this variable.

## Source

<https://github.com/rfordatascience/tidytuesday>

## See also

[`get_tt_datasets_metadata()`](https://r4ds.github.io/ttmeta/reference/get_tt_datasets_metadata.md)
for the function that is used to compile this dataset.
