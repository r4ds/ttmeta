#' TidyTuesday urls
#'
#' Source and article urls for TidyTuesday posts.
#'
#' @format A data frame with one row per article or source url (569 rows as of
#'   2023-06-05) and 11 variables:
#' \describe{
#'   \item{year}{(integer) The year in which the dataset was released.}
#'   \item{week}{(integer) The week number for this dataset within this year.}
#'   \item{type}{(factor) Whether this url appeared as an "article" or as a
#'   data "source".}
#'   \item{url}{(character) The full url.}
#'   \item{scheme}{(factor) Whether this url uses "http" or "https".}
#'   \item{domain}{(character) The main part of the url. For example, in
#'   www.google.com, "google" would be the domain for this column.}
#'   \item{subdomain}{(character) The part of the url before the period (when
#'   present). For example, in www.google.com, "www" would be the subdomain for
#'   this column.}
#'   \item{tld}{(character) The top-level domain, the part of the url after the
#'   domain. For example, in www.google.com, "com" would be the tld for this
#'   column.}
#'   \item{path}{(character) The part of the url after the slash but before any
#'   "?" or "#" (when present). For example, in
#'   www.google.com/maps/place/Googleplex, "maps/place/Googleplex" would be the
#'   path for this column.}
#'   \item{query}{(named list) The parts of the url after "?" (when present),
#'   parsed into name-value pairs. For example, for example.com/source?a=1&b=2,
#'   this column would contain `list(a = 1, b = 2)`.}
#'   \item{fragment}{(character) The part of the url after "#" (when present).
#'   for example, for cascadiarconf.com/agenda/#craggy, this column would
#'   contain "craggy".}
#' }
#'
#' @source <https://github.com/rfordatascience/tidytuesday>
#' @seealso [`parse_tt_urls()`] for the function that is used to compile this
#' dataset.
"tt_urls_tbl"

#' Create a url dataset
#'
#' Parse the `source_urls` and `article_urls` columns of a `tt_tbl` (returned by
#' [get_tt_tbl()]) into a searchable url tibble.
#'
#' @inheritParams get_tt_datasets_metadata
#'
#' @return A tbl_df with columns `year`, `week`, `type`, `url`, `scheme`,
#'   `domain`, `subdomain`, `tld`, `path`, `query`, and `fragment`.
#' @export
parse_tt_urls <- function(tt_tbl) {
  return(
    tt_tbl |>
      .prep_url_column() |>
      .split_url_column() |>
      .split_domain_column() |>
      dplyr::mutate(
        query = .split_query(.data$query),
        path = stringr::str_remove(.data$path, "/$"),
        # scheme only has a couple possible values. tld is tempting but they're
        # added too often.
        scheme = factor(.data$scheme, levels = c("http", "https"))
      ) |>
      dplyr::arrange(
        .data$year, .data$week, .data$type, .data$url, .data$scheme,
        .data$domain, .data$subdomain, .data$tld, .data$path, .data$query,
        .data$fragment
      )
  )
}

.prep_url_column <- function(tt_tbl) {
  return(
    tt_tbl |>
      dplyr::select("year", "week", "source_urls", "article_urls") |>
      tidyr::pivot_longer(
        c("source_urls", "article_urls"),
        names_to = "type",
        values_to = "url"
      ) |>
      tidyr::unnest_longer("url") |>
      dplyr::mutate(
        type = factor(
          stringr::str_remove(.data$type, "_urls$"),
          levels = c("article", "source")
        ),
        # TODO: Sort out a permanent fix.
        url = stringr::str_replace(
          .data$url,
          "medium.com/@",
          "medium.com/"
        )
      )
  )
}

.split_url_column <- function(tt_url_tbl) {
  return(
    tt_url_tbl |>
      dplyr::mutate(
        url_pieces = urltools::url_parse(.data$url)
      ) |>
      tidyr::unnest_wider("url_pieces") |>
      dplyr::select(-"port") |>
      dplyr::rename("query" = "parameter")
  )
}

.split_domain_column <- function(tt_domain_tbl) {
  return(
    tt_domain_tbl |>
      dplyr::mutate(
        domain_pieces = strsplit(.data$domain, "\\."),
        subdomain = purrr::map_chr(
          .data$domain_pieces,
          \(dp) {
            if (length(dp) > 2) {
              return(
                paste(
                  dp[1:(length(dp) - 2)],
                  collapse = "."
                )
              )
            }
            return(NA_character_)
          }
        ),
        domain = purrr::map_chr(
          .data$domain_pieces,
          ~ .x[[length(.x) - 1]]
        ),
        tld = purrr::map_chr(
          .data$domain_pieces,
          ~ .x[[length(.x)]]
        ),
        .after = "domain"
      ) |>
      dplyr::select(-"domain_pieces")
  )
}

.split_query <- function(query_str) {
  return(
    purrr::map(
      query_str,
      \(q) {
        if (is.na(q)) {
          return(NULL)
        }
        return(shiny::parseQueryString(q))
      }
    )
  )
}
