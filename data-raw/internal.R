library(ttmeta)

.tt_gh_base <- "https://github.com/rfordatascience/tidytuesday/blob/master/"

tt_summary_tbl <- get_tt_tbl()
tt_datasets_metadata <- get_tt_datasets_metadata(tt_summary_tbl)
tt_urls_tbl <- parse_tt_urls(tt_summary_tbl)

usethis::use_data(
  .tt_gh_base,
  overwrite = TRUE,
  internal = TRUE
)

usethis::use_data(
  tt_summary_tbl,
  tt_datasets_metadata,
  tt_urls_tbl,
  overwrite = TRUE
)

rm(
  .tt_gh_base,
  tt_summary_tbl,
  tt_datasets_metadata,
  tt_urls_tbl
)
