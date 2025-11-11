# Extract urls from a column of an html table

Extract urls from a column of an html table

## Usage

``` r
.extract_urls_col(rows, col_number)
```

## Arguments

- rows:

  An xml node_set of rows.

- col_number:

  The 1-indexed column number to extract.

## Value

A list of character vectors of the urls in the table, with one vector
per row.
