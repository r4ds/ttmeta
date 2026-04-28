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
      "year",
      "week",
      "dataset_name",
      "variables",
      "observations",
      "variable_details"
    )
  )
  expect_identical(
    colnames(test_result$variable_details[[3]]),
    c("variable", "class", "n_unique", "min", "max", "description")
  )
  expect_null(test_result$variable_details[[1]])
  # Just lay it out exactly to avoid snapshot issues.
  # saveRDS(test_result, test_path("fixtures/test-datasets-metadata.rds"))
  expected_result <- readRDS(test_path("fixtures/test-datasets-metadata.rds"))
  expect_equal(
    head(dplyr::arrange(
      test_result$variable_details[[2]],
      variable,
      class,
      n_unique
    )),
    head(dplyr::arrange(
      expected_result$variable_details[[2]],
      variable,
      class,
      n_unique
    ))
  )
  expect_equal(
    dplyr::arrange(
      test_result$variable_details[[3]],
      variable,
      class,
      n_unique
    ),
    dplyr::arrange(
      expected_result$variable_details[[3]],
      variable,
      class,
      n_unique
    )
  )
  test_result$variable_details <- NULL
  expected_result$variable_details <- NULL
  expect_equal(test_result, expected_result)
})
