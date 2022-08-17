fasta_filename <- "UP000005640_9606_no_u.tmhmm"
testthat::expect_true(file.exists(fasta_filename))
t_topology <- pureseqtmr::load_fasta_file_as_tibble(fasta_filename)
names(t_topology)
t_distances <- pureseqtmr::calc_distance_to_tmh_center_from_topology(t_topology)
testthat::expect_true("name" %in% names(t_distances))
testthat::expect_true("position" %in% names(t_distances))
testthat::expect_true("distance_to_tmh_center" %in% names(t_distances))


