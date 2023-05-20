#' Load and parse metadata about TidyTuesday datasets
#'
#' Load data week-by-week for all weeks in a tt_week_summaries, and parse the
#' datasets for information such as number of variables and number of
#' observations.
#'
#' @param tt_tbl A `tt_tbl` table returned by
#'   [get_tt_tbl()].
#'
#' @return A tbl_df with columns year, week, dataset_name, variables (number of
#'   columns), observations (number of rows), and variable_details (names and
#'   classes of all variables).
#' @export
get_tt_datasets_metadata <- function(tt_tbl) {
  purrr::pmap(
    dplyr::select(
      tt_tbl,
      "year", "week"
    ),
    get_tt_week_metadata
  ) |>
    purrr::list_rbind() |>
    # Make sure the columns are always in the expected order.
    dplyr::select(
      "year",
      "week",
      "dataset_name",
      "variables",
      "observations",
      "variable_details"
    )
}

#' Load and parse metadata about a TidyTuesday week
#'
#' Load a week's TidyTuesday dataset(s), and calculate metadata.
#'
#' @param year The year of the dataset.
#' @param week The integer week of that dataset within that year. Note that this
#'   is the TidyTuesday week number, not necessarily the week number of that
#'   year.
#'
#' @return A tbl_df with columns year, week, dataset_name, variables (number of
#'   columns), observations (number of rows), and variable_details (names and
#'   classes of all variables).
#' @export
get_tt_week_metadata <- function(year, week) {
  this_week <- purrr::quietly(purrr::safely(tidytuesdayR::tt_load))(year, week)
  if (length(this_week$result$result)) {
    purrr::map(
      this_week$result$result,
      \(tt_dataset) {
        .summarize_tt_dataset(tt_dataset, year, week)
      }
    ) |>
      purrr::list_rbind(names_to = "dataset_name") |>
      # Make sure the columns are always in the expected order.
      dplyr::select(
        "year",
        "week",
        "dataset_name",
        "variables",
        "observations",
        "variable_details"
      )
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

#' Summarize a TidyTuesday dataset
#'
#' @param tt_dataset The dataset to summarize.
#' @param year The year of this dataset (to include in the summary info).
#' @param week The week of this dataset (to include in the summary info).
#'
#' @return A `tbl_df` summarizing the data.
#' @keywords internal
.summarize_tt_dataset <- function(tt_dataset, year, week) {
  return(
    dplyr::tibble(
      year = year,
      week = week,
      variables = length(tt_dataset),
      observations = nrow(tt_dataset),
      variable_details = list(
        dplyr::tibble(
          variable = names(tt_dataset),
          class = purrr::map_chr(tt_dataset, ~ sloop::s3_class(.x)[[1]])
        )
      )
    )
  )
}
