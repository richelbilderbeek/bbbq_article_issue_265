# For each epitope, obtain the proteins where it can be found

# epitope | protein_name
#

proteome_filename <- "UP000005640_9606_no_u.fasta"
testthat::expect_true(file.exists(proteome_filename))
epitopes_filename <- "epitopes_for_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))

epitopes_sequences <- unique(sort(readr::read_csv(epitopes_filename, show_col_types = FALSE)$sequence))
message(length(epitopes_sequences), " unique MHC-II epitope sequences")

proteome <- bbbq::get_proteome(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  data_folder = "."
)


epitope_location_list <- list()
for (i in seq_along(epitopes_sequences)) {
  epitopes_sequence <- epitopes_sequences[i]
  message(i, "/", length(epitopes_sequences), ": ", epitopes_sequence)
  t <- proteome[stringr::str_detect(epitopes_sequence, proteome$sequence), ]
  message("Found ", nrow(t), " proteins the epitope is in")
  epitope_location_list[[i]] <- t
}

