#' Load the Table of DataSets
#'
#' TidyTuesday has published a new dataset weekly since April 2018. This
#' function get the table of information about the dataset from each of those
#' weeks.
#'
#' @param min_year The minimum year to include, between 2018 and now.
#' @param max_year The maximum year to include, between 2018 and now.
#'
#' @return A tibble of information about TidyTuesday datasets in the requested
#'   timeframe.
#' @export
get_tt_datasets_table <- function(min_year = 2018L,
                                  max_year = this_year()) {
  min_year <- max(as.integer(min_year), 2018L)
  max_year <- min(as.integer(max_year), this_year())

  if (max_year < min_year) {
    cli::cli_abort(
      "{.arg min_year} and {.arg max_year} should be between 2018 and now."
    )
  }

  tt_datasets_table <- purrr::map(
    min_year:max_year,
    \(yr) {
      tidytuesdayR::tt_datasets(yr) |>
        unclass() |>
        dplyr::as_tibble() |>
        dplyr::mutate(year = yr, .before = "Week")
    }
  ) |>
    purrr::list_rbind() |>
    dplyr::select(
      "year",
      week = "Week",
      date = "Date",
      title = "Data",
      source_text = "Source",
      article_text = "Article"
    )

  # TODO: Go lower-level and also grab the links for source and article.

  return(
    structure(
      tt_datasets_table,
      class = c("tt_datasets", class(tt_datasets_table))
    )
  )
}

#' Load and Parse Metadata About a TidyTuesday DataSets
#'
#' Load data week-by-week for all weeks in a tt_datasets_table, and parse the
#' datasets for information such as number of variables and number of
#' observations.
#'
#' @param tt_datasets_table A `tt_datasets` table returned by
#'   [get_tt_datasets_table()].
#'
#' @return A tbl_df with columns year, week, dataset_name, variables (number of
#'   columns), observations (number of rows), and variable_details (names and
#'   classes of all variables).
#' @export
get_tt_datasets_metadata <- function(tt_datasets_table) {
  purrr::pmap(
    dplyr::select(
      tt_datasets_table,
      "year", "week"
    ),
    get_tt_week_metadata
  ) |>
    purrr::list_rbind()
}

#' Load and Parse Metadata About a TidyTuesday Week
#'
#' Load a week's TidyTuesday dataset(s), and calculate metadata.
#'
#' @param year The year of the dataset.
#' @param week The integer week of that dataset within that year.
#'
#' @return A tbl_df with columns year, week, dataset_name, variables (number of
#'   columns), observations (number of rows), and variable_details (names and
#'   classes of all variables).
#' @export
get_tt_week_metadata <- function(year, week) {
  this_week <- purrr::safely(tidytuesdayR::tt_load)(year, week)
  if (length(this_week$result)) {
    purrr::map(
      this_week$result,
      \(tt_dataset) {
        .parse_tt_dataset(tt_dataset, year, week)
      }
    ) |>
      purrr::list_rbind(names_to = "dataset_name")
  } else {
    dplyr::tibble(
      year = year,
      week = week,
      dataset_name = NA_character_,
      variables = NA_integer_,
      observations = NA_integer_,
      variable_details = list(NULL)
    )
  }
  # TODO: Figure out how to read the dictionary. The README HTML is here:
  # attr(this_week, ".tt") |> attr(".readme")
}

.parse_tt_dataset <- function(tt_dataset, year, week) {
  return(
    dplyr::tibble(
      year = year,
      week = week,
      variables = length(tt_dataset),
      observations = nrow(tt_dataset),
      variable_details = list(
        dplyr::tibble(
          variable = names(tt_dataset),
          class = purrr::map_chr(tt_dataset, ~sloop::s3_class(.x)[[1]])
        )
      )
    )
  )
}
