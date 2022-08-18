topology <- bbbq::get_topology(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  topology_prediction_tool = "tmhmm",
  data_folder = "."
)
testthat::expect_true(file.exists("UP000005640_9606_no_u.tmhmm"))