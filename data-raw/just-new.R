pkgload::load_all(reset = FALSE, helpers = FALSE, attach_testthat = FALSE)

updated_tt_summary_tbl <- get_tt_tbl()
new_datasets <- dplyr::filter(
  updated_tt_summary_tbl,
  !(date %fin% tt_summary_tbl$date)
)

if (nrow(new_datasets)) {
  new_tt_datasets_metadata <- get_tt_datasets_metadata(new_datasets)
  updated_tt_datasets_metadata <- tt_datasets_metadata |>
    # Make sure the new stuff isn't already there.
    dplyr::anti_join(
      new_tt_datasets_metadata,
      by = dplyr::join_by(year, week)
    ) |>
    dplyr::bind_rows(new_tt_datasets_metadata) |>
    dplyr::arrange(year, week, dataset_name)

  new_tt_urls_tbl <- parse_tt_urls(new_datasets)
  updated_tt_urls_tbl <- tt_urls_tbl |>
    # Make sure the new stuff isn't already there.
    dplyr::anti_join(
      new_tt_urls_tbl,
      by = dplyr::join_by(year, week)
    ) |>
    dplyr::bind_rows(new_tt_urls_tbl) |>
    dplyr::arrange(
      year, week, url, scheme, domain, subdomain, tld, path, query, fragment
    )

  if (
    !identical(updated_tt_summary_tbl, tt_summary_tbl) ||
      !identical(updated_tt_datasets_metadata, tt_datasets_metadata) ||
      !identical(updated_tt_urls_tbl, tt_urls_tbl)
  ) {
    tt_summary_tbl <- updated_tt_summary_tbl
    tt_datasets_metadata <- updated_tt_datasets_metadata
    tt_urls_tbl <- updated_tt_urls_tbl

    export_target <- here::here("data/tt_summary_tbl.rda")
    cli::cli_alert_info("Saving to {export_target}.")
    save(
      tt_summary_tbl,
      tt_datasets_metadata,
      tt_urls_tbl,
      file = export_target,
      compress = "xz",
      version = 2
    )

    export_target <- here::here("data/tt_datasets_metadata.rda")
    cli::cli_alert_info("Saving to {export_target}.")
    save(
      tt_datasets_metadata,
      file = export_target,
      compress = "bzip2",
      version = 2
    )

    export_target <- here::here("data/tt_urls_tbl.rda")
    cli::cli_alert_info("Saving to {export_target}.")
    save(
      tt_urls_tbl,
      file = export_target,
      compress = "bzip2",
      version = 2
    )

    rm(
      tt_summary_tbl,
      tt_datasets_metadata,
      tt_urls_tbl,
      export_target
    )
  }

  rm(
    new_tt_datasets_metadata,
    updated_tt_datasets_metadata,
    new_tt_urls_tbl,
    updated_tt_urls_tbl
  )
}

rm(
  new_datasets,
  updated_tt_summary_tbl
)
