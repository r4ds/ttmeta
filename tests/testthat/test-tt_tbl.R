test_that("get_tt_tbl() gets a summary table", {
  skip_on_cran()
  expect_no_error({
    test_result <- get_tt_tbl(2018L, 2018L)
  })
  class(test_result)
  expect_s3_class(
    test_result,
    c("tt_tbl", "tbl_df", "tbl", "data.frame")
  )
  expect_identical(
    colnames(test_result),
    c(
      "year", "week", "date", "title",
      "source_title", "source_urls",
      "article_title", "article_urls"
    )
  )
  expect_equal(
    nrow(test_result),
    38
  )
})

test_that("get_tt_tbl() errors informatively", {
  expect_snapshot(
    {
      get_tt_tbl(2020, 2019)
    },
    error = TRUE
  )
})
