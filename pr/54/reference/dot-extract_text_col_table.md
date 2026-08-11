# Extract text from all rows of a column in a table

Extract text from all rows of a column in a table

## Usage

``` r
.extract_text_col_table(table, col_number)
```

## Arguments

- table:

  An xml table object.

- col_number:

  The 1-indexed column number to extract.

## Value

A character vector of the contents of that column. Note that this is
*only* the text (not, for example, urls).
