# Create a url dataset

Parse the `source_urls` and `article_urls` columns of a `tt_tbl`
(returned by
[`get_tt_tbl()`](https://r4ds.github.io/ttmeta/reference/get_tt_tbl.md))
into a searchable url tibble.

## Usage

``` r
parse_tt_urls(tt_tbl)
```

## Arguments

- tt_tbl:

  A `tt_tbl` table returned by
  [`get_tt_tbl()`](https://r4ds.github.io/ttmeta/reference/get_tt_tbl.md).

## Value

A tbl_df with columns `year`, `week`, `type`, `url`, `scheme`, `domain`,
`subdomain`, `tld`, `path`, `query`, and `fragment`.
