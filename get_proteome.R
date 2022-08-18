proteome <- bbbq::get_proteome(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  data_folder = "."
)
testthat::expect_true(file.exists("UP000005640_9606_no_u.fasta"))