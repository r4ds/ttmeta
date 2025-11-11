# TidyTuesday week summaries

A summary of the weekly TidyTuesday posts.

## Usage

``` r
tt_summary_tbl
```

## Format

A data frame with one row per week (269 rows as of 2023-06-05) and 8
variables:

- year:

  (integer) The year in which the dataset was released.

- week:

  (integer) The week number for this dataset within this year.

- date:

  (date) The date of the Tuesday of this week.

- title:

  (character) The overall title of this week's TidyTuesday. This is
  different from the individual dataset titles (although often similar).

- source_title:

  (character) The title of this week's source. If there are multiple
  sources, there is still a single title merging them.

- source_urls:

  (list of characters) urls for each source.

- article_title:

  (character) The title of this week's article If there are multiple
  articles, there is still a single title merging them.

- article_urls:

  (list of characters) urls for each article.

## Source

<https://github.com/rfordatascience/tidytuesday>

## See also

[`get_tt_tbl()`](https://r4ds.github.io/ttmeta/reference/get_tt_tbl.md)
for the function that is used to compile this dataset.
