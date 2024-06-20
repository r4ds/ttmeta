
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ttmeta

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ttmeta)](https://CRAN.R-project.org/package=ttmeta)
[![Codecov test
coverage](https://codecov.io/gh/r4ds/ttmeta/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r4ds/ttmeta?branch=main)
[![R-CMD-check](https://github.com/r4ds/ttmeta/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r4ds/ttmeta/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

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
