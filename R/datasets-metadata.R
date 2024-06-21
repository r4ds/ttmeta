#' TidyTuesday dataset metadata
#'
#' Metadata about the weekly TidyTuesday datasets.
#'
#' @format A data frame with one row per dataset (555 rows as of 2023-06-05) and
#'   6 variables:
#' \describe{
#'   \item{year}{(integer) The year in which the dataset was released.}
#'   \item{week}{(integer) The week number for this dataset within this year.}
#'   \item{dataset_name}{(character) The name of this dataset. Some weeks
#'   have multiple datasets.}
#'   \item{variables}{(integer) The number of columns in this dataset.}
#'   \item{observations}{(integer) The number of rows in this dataset.}
#'   \item{variable_details}{(tbl_df) A tibble with a row for each variable, and
#'   6 columns:
#'     \describe{
#'       \item{variable}{(character) The name of this variable.}
#'       \item{class}{(character) the class of this variable.}
#'       \item{n_unique}{(integer) the number of unique values of this variable within this dataset.}
#'       \item{min}{(list) The "lowest" value of this variable (lowest number, first value alphabetically, etc).}
#'       \item{max}{(list) The "highest" value of this variable (highest number, last value alphabetically, etc).}
#'       \item{description}{(character) A short description of this variable.}
#'     }
#'   }
#' }
#'
#' @source <https://github.com/rfordatascience/tidytuesday>
#' @seealso [`get_tt_datasets_metadata()`] for the function that is used to
#' compile this dataset.
"tt_datasets_metadata"

#' Load and parse metadata about TidyTuesday datasets
#'
#' Load data week-by-week for all weeks in a tt_week_summaries, and parse the
#' datasets for information such as number of variables and number of
#' observations.
#'
#' @param tt_tbl A `tt_tbl` table returned by [get_tt_tbl()].
#'
#' @return A tbl_df with columns year, week, dataset_name, variables (number of
#'   columns), observations (number of rows), and variable_details (names and
#'   classes of all variables).
#' @export
#' @seealso [`tt_datasets_metadata`] the resulting dataset.
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
#'   columns), observations (number of rows), and variable_details (names,
#'   classes, n_unique (number of unique observations), min (or first
#'   alphabetically) and max (or last alphabetically) of all variables).
#' @export
get_tt_week_metadata <- function(year, week) {
  this_week <- purrr::quietly(purrr::safely(tidytuesdayR::tt_load))(year, week)
  this_week <- this_week$result$result
  if (length(this_week)) {
    dictionaries <- .extract_dataset_dictionaries(this_week)

    purrr::map2(
      this_week,
      dictionaries,
      \(tt_dataset, dictionary) {
        .summarize_tt_dataset(
          tt_dataset,
          dictionary,
          year,
          week
        )
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
}

#' Summarize a TidyTuesday dataset
#'
#' @param tt_dataset The dataset to summarize.
#' @param dictionary The extracted data dictionary for this dataset.
#' @param year The year of this dataset (to include in the summary info).
#' @param week The week of this dataset (to include in the summary info).
#'
#' @return A `tbl_df` summarizing the data.
#' @keywords internal
.summarize_tt_dataset <- function(tt_dataset,
                                  dictionary,
                                  year,
                                  week) {
  return(
    dplyr::tibble(
      year = year,
      week = week,
      variables = length(tt_dataset),
      observations = nrow(tt_dataset),
      variable_details = list(
        dplyr::tibble(
          variable = names(tt_dataset),
          class = purrr::map_chr(tt_dataset, ~ sloop::s3_class(.x)[[1]]),
          n_unique = purrr::map_int(tt_dataset, ~ length(unique(.x))),
          # If min/max fail, the NULL result is fine.
          min = purrr::map(tt_dataset, ~ purrr::safely(min)(.x)$result) |>
            unname(),
          max = purrr::map(tt_dataset, ~ purrr::safely(max)(.x)$result) |>
            unname()
        ) |>
          dplyr::left_join(dictionary, by = "variable")
      )
    )
  )
}

#' Extract data dictionaries from week readmes
#'
#' @param tt_data A `tt_data` object from [tidytuesdayR::tt_load()].
#'
#' @return A named list of `tbl_df`s, with one tibble per dataset. The tibbles
#'   have columns `variable` and `description`, and either one row per variable
#'   or 0 rows.
#' @keywords internal
.extract_dataset_dictionaries <- function(tt_data) {
  datanames <- names(tt_data)
  dictionaries <- list()

  readme <- attr(
    attr(tt_data, ".tt", exact = TRUE),
    ".readme",
    exact = TRUE
  )
  if (length(readme)) {
    tables <- .extract_tables(readme)
    description_locations <- purrr::map_int(
      tables,
      \(table) {
        return(
          purrr::detect_index(
            tolower(.table_headings(table)),
            ~ .x %fin% c("description", "definition")
          )
        )
      }
    )
    dictionaries <- purrr::map2(
      tables[description_locations != 0],
      description_locations[description_locations != 0],
      \(this_table, this_description_col) {
        dplyr::tibble(
          variable = .extract_text_col_table(this_table, 1),
          description = .extract_text_col_table(
            this_table,
            this_description_col
          )
        )
      }
    )

    if (length(dictionaries)) {
      # Now we need to figure out the dataset name to associate with each table.
      filenames <- attr(
        attr(tt_data, ".tt"),
        ".files"
      )$data_files

      # For each dataset, the matching heading is sometimes the filename, and
      # sometimes something like "dataset table", and probably sometimes
      # "dataset". Construct a regex to test for that.
      heading_regex <- glue::glue(
        "{filenames}|(^|\\s+){datanames}($|\\s+)"
      )

      # Figure out which order the dictionaries are in.
      headings <- xml2::xml_find_all(readme, ".//h1|//h2|//h3") |>
        rvest::html_text(trim = TRUE)

      locations <- purrr::map_int(
        heading_regex,
        \(this_head_regex) {
          idx <- stringr::str_which(headings, this_head_regex)
          if (!length(idx)) {
            idx <- 0L # nocov
          }
          if (length(idx) > 1) {
            # Use the one that has the fewest characters.
            idx <- idx[order(nchar(headings[idx]))][[1]] # nocov
          }
          return(idx)
        }
      )
      names(locations) <- datanames
      locations <- locations[locations != 0]
      names(dictionaries) <- names(locations[order(locations)])
    }
  }
  # Make sure the descriptions are in the expected order, and that there's
  # an entry for every dataname.
  dictionaries <- dictionaries[datanames]
  names(dictionaries) <- datanames

  # Provide empty dictionaries for downstream joins.
  dictionaries[lengths(dictionaries) == 0] <- list(
    dplyr::tibble(
      variable = character(),
      description = character()
    )
  )
  return(dictionaries)
}
