epitope_distances_filename <- "epitope_distances.csv"
testthat::expect_true(file.exists(epitope_distances_filename))
epitopes_filename <- "epitopes_for_mhc1_and_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))


epitope_distances <- readr::read_csv(epitope_distances_filename)
names(epitope_distances)
epitope_distances <- dplyr::rename(epitope_distances, epitope_sequence = "epitope")
names(epitope_distances)

epitopes <- readr::read_csv(epitopes_filename)
names(epitopes)
epitopes <- dplyr::rename(epitopes, epitope_sequence = "sequence")
names(epitopes)

epitope_distances_per_allele <- merge(epitopes, epitope_distances)
readr::write_csv(epitope_distances_per_allele, "epitope_distances_per_allele.csv")
