topology <- bbbq::get_topology(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  topology_prediction_tool = "tmhmm",
  data_folder = "."
)

