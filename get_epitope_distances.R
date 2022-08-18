# For each epitope, tally the distances
if (1 == 2) {
  
distances_filename <- "distances.csv"
testthat::expect_true(file.exists(distances_filename))
proteome_filename <- "UP000005640_9606_no_u.fasta"
testthat::expect_true(file.exists(proteome_filename))
epitopes_filename <- "epitopes_for_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))

epitopes_raw <- readr::read_csv(epitopes_filename, show_col_types = FALSE)
epitopes_rordered <- dplyr::select(epitopes_raw, "allele_name", "sequence")
epitopes <- dplyr::arrange(epitopes_rordered, allele_name, sequence)
}
