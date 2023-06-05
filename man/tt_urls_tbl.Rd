% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/urls.R
\docType{data}
\name{tt_urls_tbl}
\alias{tt_urls_tbl}
\title{TidyTuesday urls}
\format{
A data frame with one row per article or source url (569 rows as of
2023-06-05) and 11 variables:
\describe{
\item{year (integer)}{The year in which the dataset was realeased.}
\item{week (integer)}{The week number for this dataset within this year.}
\item{type (factor)}{Whether this url appeared as an "article" or as a
data "source".}
\item{url (character)}{The full url.}
\item{scheme (factor)}{Whether this url uses "http" or "https".}
\item{domain (character)}{The main part of the url. For example, in
www.google.com, "google" would be the domain for this column.}
\item{subdomain (character)}{The part of the url before the period (when
present). For example, in www.google.com, "www" would be the subdomain for
this column.}
\item{tld (character)}{The top-level domain, the part of the url after the
domain. For example, in www.google.com, "com" would be the tld for this
column.}
\item{path (character)}{The part of the url after the slash but before any
"?" or "#" (when present). For example, in
www.google.com/maps/place/Googleplex, "maps/place/Googleplex" would be the
path for this column.}
\item{query (named list)}{The parts of the url after "?" (when present),
parsed into name-value pairs. For example, for example.com/source?a=1&b=2,
this column would contain \code{list(a = 1, b = 2)}.}
}
}
\source{
\url{https://github.com/rfordatascience/tidytuesday}
}
\usage{
tt_urls_tbl
}
\description{
Source and article urls for TidyTuesday posts.
}
\seealso{
\code{\link[=get_tt_tbl]{get_tt_tbl()}} for the function that is used to compile this
dataset.
}
\keyword{datasets}