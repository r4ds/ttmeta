test_that("get_tt_datasets_metadata works", {
  skip_on_cran()
  # One bad dataset, one missing dictionary, one fully good.
  tt_tbl <- structure(
    list(year = c(2018L, 2018L, 2023L), week = c(8L, 9L, 20L)),
    row.names = c(NA, -3L),
    class = c("tt_tbl", "tbl_df", "tbl", "data.frame")
  )
  expect_no_error({
    test_result <- get_tt_datasets_metadata(tt_tbl)
  })
  expect_equal(nrow(test_result), 3)
  expect_identical(
    colnames(test_result),
    c(
      "year", "week", "dataset_name",
      "variables", "observations", "variable_details"
    )
  )
  expect_identical(
    colnames(test_result$variable_details[[3]]),
    c("variable", "class", "description")
  )
  expect_snapshot({
    test_result
  })
})
