#' Extract text from a column of an html table
#'
#' @param rows An xml node_set of rows.
#' @param col_number The 1-indexed column number to extract.
#'
#' @return A character vector of the contents of that column. Note that this is
#'   *only* the text (not, for example, urls).
#' @keywords internal
.extract_text_col <- function(rows, col_number) {
  return(
    purrr::map_chr(
      rows,
      ~ .extract_text_cell(.x, col_number)
    ) |>
      dplyr::na_if("")
  )
}

#' Extract text from a particular row of an html table row
#'
#' @param row An xml node_set of a single row.
#' @inheritParams .extract_text_col
#'
#' @return A character scalar of the contents of that cell.
#' @keywords internal
.extract_text_cell <- function(row, col_number) {
  return(
    rvest::html_text(
      xml2::xml_find_all(row, ".//td")[[col_number]]
    )
  )
}

#' Extract URLs from a column of an html table
#'
#' @inheritParams .extract_text_col
#'
#' @return A list of character vectors of the urls in the table, with one vector
#'   per row.
#' @keywords internal
.extract_urls_col <- function(rows, col_number) {
  return(
    purrr::map(
      rows,
      ~ .extract_urls_cell(.x, col_number)
    )
  )
}

#' Extract urls from a particular row of an html table row
#'
#' @inheritParams .extract_text_cell
#'
#' @return A character vector of any
#' @keywords internal
.extract_urls_cell <- function(row, col_number) {
  return(
    xml2::xml_find_all(row, ".//td")[[col_number]] |>
      xml2::xml_find_all(".//a") |>
      xml2::xml_attr("href")
  )
}

#' Get dataset rows for a particular TidyTuesday year readme
#'
#' @param year The year of the desired README.
#'
#' @return An xml node_set of rows.
#' @keywords internal
.tt_readme_rows <- function(year) {
  return(
    .tt_readme_table(year, 1) |>
      xml2::xml_find_all(".//tr")
  )
}

#' Get a table from a particular TidyTuesday year readme
#'
#' @inheritParams .tt_readme_rows
#' @param table_number Which table on the page to load. I do not currently
#'   validate this, so errors might be confusing if you send in a number higher
#'   than the number of tables in that README.
#'
#' @return An xml node_set containing the body of the table.
#' @keywords internal
.tt_readme_table <- function(year, table_number) {
  all_tables <- rvest::read_html(
    glue::glue(
      .tt_gh_base,
      "data/{year}/readme.md"
    )
  ) |>
    xml2::xml_find_all(".//tbody")

  return(all_tables[[table_number]])
}
