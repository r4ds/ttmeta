#' TidyTuesday week summaries
#'
#' A summary of the weekly TidyTuesday posts.
#'
#' @format A data frame with one row per week (269 rows as of 2023-06-05) and
#'   8 variables:
#' \describe{
#'   \item{year}{(integer) The year in which the dataset was realeased.}
#'   \item{week}{(integer) The week number for this dataset within this year.}
#'   \item{date}{(date) The date of the Tuesday of this week.}
#'   \item{title}{(character) The overall title of this week's TidyTuesday. This
#'   is different from the individual dataset titles (although often similar).}
#'   \item{source_title}{(character) The title of this week's source. If there
#'   are multiple sources, there is still a single title merging them.}
#'   \item{source_urls}{(list of characters) urls for each source.}
#'   \item{article_title}{(character) The title of this week's article If there
#'   are multiple articles, there is still a single title merging them.}
#'   \item{article_urls}{(list of characters) urls for each article.}
#' }
#'
#' @source <https://github.com/rfordatascience/tidytuesday>
#' @seealso [`get_tt_tbl()`] for the function that is used to compile this
#' dataset.
"tt_summary_tbl"

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
  rows <- .tt_year_readme_rows(year)

  parsed <- dplyr::tibble(
    year = year,
    week = as.integer(.extract_text_col(rows, 1)),
    date = lubridate::as_date(.extract_text_col(rows, 2)),
    title = .extract_text_col(rows, 3),
    source_title = .extract_text_col(rows, 4),
    source_urls = .extract_urls_col(rows, 4),
    article_title = .extract_text_col(rows, 5),
    article_urls = .extract_urls_col(rows, 5)
  )

  # Check data and alert if something is weird.
  tues_check <- .is_tuesday(parsed$date)

  if (any(!tues_check)) {
    bad_dates <- parsed$date[!tues_check]

    bad_dates <- glue::glue_collapse(parsed$date[!tues_check], sep = "\n")
    cli::cli_alert_warning(
      "These dates are not Tuesday: {bad_dates}"
    )
  }

  return(parsed)
}
