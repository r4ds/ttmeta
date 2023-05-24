pkgload::load_all(reset = FALSE, helpers = FALSE, attach_testthat = FALSE)

updated_tt_summary_tbl <- get_tt_tbl()
new_datasets <- dplyr::filter(
  updated_tt_summary_tbl,
  !(date %fin% tt_summary_tbl$date)
)

new_tt_datasets_metadata <- get_tt_datasets_metadata(new_datasets)
updated_tt_datasets_metadata <- tt_datasets_metadata |>
  # Make sure the new stuff isn't already there.
  dplyr::anti_join(
    new_tt_datasets_metadata,
    by = dplyr::join_by(year, week)
  ) |>
  dplyr::bind_rows(new_tt_datasets_metadata) |>
  dplyr::arrange(year, week, dataset_name)

if (
  !identical(updated_tt_summary_tbl, tt_summary_tbl) ||
  !identical(updated_tt_datasets_metadata, tt_datasets_metadata)
) {
  tt_summary_tbl <- updated_tt_summary_tbl
  tt_datasets_metadata <- updated_tt_datasets_metadata
  .tt_gh_base <- "https://github.com/rfordatascience/tidytuesday/blob/master/"
  save(
    .tt_gh_base,
    tt_summary_tbl,
    tt_datasets_metadata,
    file = "R/sysdata.rda",
    compress = "bzip2",
    version = 2
  )

  rm(
    .tt_gh_base,
    tt_summary_tbl,
    tt_datasets_metadata
  )
}

rm(
  new_datasets,
  new_tt_datasets_metadata,
  updated_tt_summary_tbl,
  updated_tt_datasets_metadata
)
