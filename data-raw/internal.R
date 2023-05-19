library(ttapi)

tt_datasets_table <- get_tt_datasets_table()
tt_datasets_metadata <- get_tt_datasets_metadata(tt_datasets_table)

usethis::use_data(
  tt_datasets_table,
  tt_datasets_metadata,
  overwrite = TRUE,
  internal = TRUE
)

rm(
  tt_datasets_table,
  tt_datasets_metadata
)
