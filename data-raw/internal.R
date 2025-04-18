pkgload::load_all(helpers = FALSE, attach_testthat = FALSE)

.tt_gh_base <- "https://github.com/rfordatascience/tidytuesday/blob/main/"

usethis::use_data(
  .tt_gh_base,
  overwrite = TRUE,
  internal = TRUE,
  compress = "xz"
)

rm(.tt_gh_base)

pkgload::load_all(helpers = FALSE, attach_testthat = FALSE)

tt_summary_tbl <- get_tt_tbl()
tt_datasets_metadata <- get_tt_datasets_metadata(tt_summary_tbl)
tt_urls_tbl <- parse_tt_urls(tt_summary_tbl)

usethis::use_data(
  tt_summary_tbl,
  tt_datasets_metadata,
  tt_urls_tbl,
  overwrite = TRUE,
  compress = "xz"
)

# The "compress" argument was determined by running these commands:
# tools::resaveRdaFiles("data/") (and also "R/")
# tools::checkRdaFiles("data/") (and also "R/")

rm(
  tt_summary_tbl,
  tt_datasets_metadata,
  tt_urls_tbl
)
