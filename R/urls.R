#' Create a URL dataset
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
        path = stringr::str_remove(.data$path, "/$")
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
        type = stringr::str_remove(.data$type, "_urls$")
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
