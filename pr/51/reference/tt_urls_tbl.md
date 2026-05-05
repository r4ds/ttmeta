# TidyTuesday urls

Source and article urls for TidyTuesday posts.

## Usage

``` r
tt_urls_tbl
```

## Format

A data frame with one row per article or source url (569 rows as of
2023-06-05) and 11 variables:

- year:

  (integer) The year in which the dataset was released.

- week:

  (integer) The week number for this dataset within this year.

- type:

  (factor) Whether this url appeared as an "article" or as a data
  "source".

- url:

  (character) The full url.

- scheme:

  (factor) Whether this url uses "http" or "https".

- domain:

  (character) The main part of the url. For example, in www.google.com,
  "google" would be the domain for this column.

- subdomain:

  (character) The part of the url before the period (when present). For
  example, in www.google.com, "www" would be the subdomain for this
  column.

- tld:

  (character) The top-level domain, the part of the url after the
  domain. For example, in www.google.com, "com" would be the tld for
  this column.

- path:

  (character) The part of the url after the slash but before any "?" or
  "#" (when present). For example, in
  www.google.com/maps/place/Googleplex, "maps/place/Googleplex" would be
  the path for this column.

- query:

  (named list) The parts of the url after "?" (when present), parsed
  into name-value pairs. For example, for example.com/source?a=1&b=2,
  this column would contain `list(a = 1, b = 2)`.

- fragment:

  (character) The part of the url after "#" (when present). for example,
  for cascadiarconf.com/agenda/#craggy, this column would contain
  "craggy".

## Source

<https://github.com/rfordatascience/tidytuesday>

## See also

[`parse_tt_urls()`](https://r4ds.github.io/ttmeta/reference/parse_tt_urls.md)
for the function that is used to compile this dataset.
