# ttmeta

Metadata about the [TidyTuesday](https://tidytues.day) social data
project. Data includes a summary of each weekly TidyTuesday post,
information about the articles and data sources linked in those posts,
and details about the datasets themselves, including variable names and
classes.

The package updates weekly with the latest TidyTuesday data. Note that
the package version does *not* automatically change (yet) during that
update, so the date in the version number currently reflects the last
time the data was *manually* parsed.

## Installation

You can install the development version of ttmeta from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("r4ds/ttmeta")
```

## Usage

The useful parts of this package are the three exported datasets:

- `tt_summary_tbl` contains a summary of the weekly TidyTuesday posts.
- `tt_urls_tbl` contains source and article urls for TidyTuesday posts.
- `tt_datasets_metadata` contains metadata about the weekly TidyTuesday
  datasets.

## Code of Conduct

Please note that the ttmeta project is released with a [Contributor Code
of Conduct](https://r4ds.github.io/ttmeta/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
