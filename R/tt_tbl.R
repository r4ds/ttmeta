#' Load the TidyTuesday week summaries
#'
#' TidyTuesday has published a new dataset weekly since April 2018. This
#' function gets the table of information about each of those weeks.
#'
#' @param min_year The minimum year to include, between 2018 and now.
#' @param max_year The maximum year to include, between 2018 and now.
#'
#' @return A `tt_tbl` tibble of information about TidyTuesday weeks in the
#'   requested timeframe.
#' @export
get_tt_tbl <- function(min_year = 2018L,
                       max_year = this_year()) {
  min_year <- max(as.integer(min_year), 2018L)
  max_year <- min(as.integer(max_year), this_year())

  if (max_year < min_year) {
    cli::cli_abort(
      "{.arg min_year} and {.arg max_year} should be between 2018 and now."
    )
  }

  tt_week_summaries <- purrr::map(
    min_year:max_year,
    .parse_tt_year_readme
  ) |>
    purrr::list_rbind()

  return(
    structure(
      tt_week_summaries,
      class = c("tt_tbl", class(tt_week_summaries))
    )
  )
}

#' Extract the weekly summary table from a TidyTuesday readme
#'
#' @param year The year to extract.
#'
#' @return A table of information about TidyTuesday weeks for that year.
#' @keywords internal
.parse_tt_year_readme <- function(year) {
  rows <- .tt_readme_rows(year)

  return(
    dplyr::tibble(
      year = year,
      week = as.integer(.extract_text_col(rows, 1)),
      date = lubridate::as_date(.extract_text_col(rows, 2)),
      title = .extract_text_col(rows, 3),
      source_title = .extract_text_col(rows, 4),
      source_urls = .extract_urls_col(rows, 4),
      article_title = .extract_text_col(rows, 5),
      article_urls = .extract_urls_col(rows, 5)
    )
  )
}
