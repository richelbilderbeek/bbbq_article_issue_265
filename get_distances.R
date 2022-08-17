topology_filename <- "UP000005640_9606_no_u.tmhmm"
testthat::expect_true(file.exists(topology_filename))
t_tmhmm_topology <- pureseqtmr::load_topology_file_as_tibble(topology_filename)
t_topology <- pureseqtmr::convert_tmhmm_to_pureseqtm_topology(t_tmhmm_topology)
t_distances <- pureseqtmr::calc_distance_to_tmh_center_from_topology(t_topology)
testthat::expect_true("name" %in% names(t_distances))
testthat::expect_true("position" %in% names(t_distances))
testthat::expect_true("distance_to_tmh_center" %in% names(t_distances))
readr::write_csv(t_distances, "distances.csv")


