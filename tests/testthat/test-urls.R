test_that("Can create a url tibble.", {
  test_result <- parse_tt_urls(head(tt_summary_tbl, 5))
  expect_identical(
    colnames(test_result),
    c(
      "year", "week", "type",
      "url", "scheme", "domain", "subdomain", "tld",
      "path", "query", "fragment"
    )
  )
  expect_equal(nrow(test_result), 10)
  expect_snapshot({
    dplyr::glimpse(test_result)
  })
})
