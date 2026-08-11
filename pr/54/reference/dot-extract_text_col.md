# Extract text from a column of an html table

Extract text from a column of an html table

## Usage

``` r
.extract_text_col(rows, col_number)
```

## Arguments

- rows:

  An xml node_set of rows.

- col_number:

  The 1-indexed column number to extract.

## Value

A character vector of the contents of that column. Note that this is
*only* the text (not, for example, urls).
