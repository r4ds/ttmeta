test_that("this_year() gets this year", {
  expect_identical(
    {this_year()},
    {as.POSIXlt(Sys.time())$year + 1900L}
  )
})
