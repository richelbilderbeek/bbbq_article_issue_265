proteome <- bbbq::get_proteome(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative"
)
bbbq::get_topology(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  topology_prediction_tool = "tmhmm"
)
