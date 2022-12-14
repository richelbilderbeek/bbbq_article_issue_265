# For each epitope, obtain the proteins where it can be found

# epitope | protein_name
#

proteome_filename <- "membrane_proteins.fasta"
testthat::expect_true(file.exists(proteome_filename))
epitopes_filename <- "epitopes_for_mhc1_and_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))

epitopes_sequences <- unique(sort(readr::read_csv(epitopes_filename, show_col_types = FALSE)$sequence))
if (1 == 2) {
  epitopes_sequences <- epitopes_sequences[1:10]
}
  
message(length(epitopes_sequences), " unique MHC-II epitope sequences")

proteome <- pureseqtmr::load_fasta_file_as_tibble(proteome_filename)

n_epitopes <- length(epitopes_sequences)
n_proteins <- nrow(proteome)


epitope_location_list <- list()
for (i in seq_along(epitopes_sequences)) {
  epitopes_sequence <- epitopes_sequences[i]
  t <- proteome[stringr::str_detect(
    string = proteome$sequence,
    pattern = epitopes_sequence, 
  ), ]
  t$epitopes_sequence <- epitopes_sequence
  message(
    i, "/", n_epitopes, ": ", epitopes_sequence,
    ", found in ", nrow(t), "/", n_proteins, " proteins"
  )
  epitope_location_list[[i]] <- t
  
  #if (nrow(t) != 0) {
  #  epitope_locations <- dplyr::bind_rows(epitope_location_list)
  #  readr::write_csv(epitope_locations, "epitope_locations_temp.csv")    
  #}
}
epitope_locations <- dplyr::bind_rows(epitope_location_list)
readr::write_csv(epitope_locations, "epitope_locations.csv")
