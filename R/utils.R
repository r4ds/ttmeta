#' Extract the year portion of today's date
#'
#' Extract the year of today's date in your computer's system timezone.
#'
#' @return The current year as an integer.
#' @export
#'
#' @examples
#' this_year()
this_year <- function() {
  return(as.integer(lubridate::year(lubridate::today())))
}
