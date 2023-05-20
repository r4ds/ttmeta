test_that("get_tt_datasets_metadata works", {
  skip_on_cran()
  tt_tbl <- structure(
    list(year = 2018L, week = 8:9),
    row.names = c(NA, -1L),
    class = c("tt_tbl", "tbl_df", "tbl", "data.frame")
  )
  expect_no_error({test_result <- get_tt_datasets_metadata(tt_tbl)})
  expect_equal(nrow(test_result), 2)
  expect_identical(
    colnames(test_result),
    c(
      "year", "week", "dataset_name",
      "variables", "observations", "variable_details"
    )
  )
  expect_snapshot({test_result})
})
