# Input
proteome_filename <- "UP000005640_9606_no_u.fasta"
topology_filename <- "UP000005640_9606_no_u.tmhmm"
testthat::expect_true(file.exists(proteome_filename))
testthat::expect_true(file.exists(topology_filename))

# Output
lut_filename <- "proteins_lut.csv"

proteome <- pureseqtmr::load_fasta_file_as_tibble(proteome_filename)
topology <- pureseqtmr::convert_tmhmm_to_pureseqtm_topology(pureseqtmr::load_topology_file_as_tibble(topology_filename))
testthat::expect_equal(nrow(proteome), nrow(topology))
testthat::expect_equal(proteome$name, topology$name)
testthat::expect_equal(nchar(proteome$sequence), nchar(topology$topology))
testthat::expect_equal(
  length(unique(sort(proteome$name))),
  length(proteome$name)
)

proteins_lut <- tibble::tibble(
  name = paste0("p", seq(1, nrow(proteome))),
  full_protein_name = proteome$name  
)

readr::write_csv(x = proteins_lut, lut_filename)

# Output is created
testthat::expect_true(file.exists(lut_filename))
