# Input
proteome_filename <- "UP000005640_9606_no_u.fasta"
topology_filename <- "UP000005640_9606_no_u.tmhmm"
lut_filename <- "proteins_lut.csv"
testthat::expect_true(file.exists(proteome_filename))
testthat::expect_true(file.exists(topology_filename))
testthat::expect_true(file.exists(lut_filename))

# Output
proteome_tmh_only_filename <- "membrane_proteins.fasta"
topology_tmh_only_filename <- "membrane_proteins.tmhmm"

proteome <- pureseqtmr::load_fasta_file_as_tibble(proteome_filename)
topology <- pureseqtmr::convert_tmhmm_to_pureseqtm_topology(pureseqtmr::load_topology_file_as_tibble(topology_filename))
lut <- readr::read_csv(lut_filename)
testthat::expect_equal(nrow(proteome), nrow(topology))
testthat::expect_equal(proteome$name, topology$name)
testthat::expect_equal(nchar(proteome$sequence), nchar(topology$topology))
testthat::expect_equal(lut$full_protein_name, proteome$name)
testthat::expect_equal(lut$full_protein_name, topology$name)

# Replaced the names by the LUTted ones
proteome$name <- lut$name
topology$name <- lut$name

n_proteins <- nrow(proteome)
is_membrane_protein <- pureseqtmr::count_n_tmhs(topology$topology) != 0
n_membrane_proteins <- sum(n_proteins)
message(
  n_membrane_proteins, "/", n_proteins, " are membrane proteins, ",
  "i.e. ", (100.0 * n_membrane_proteins / n_proteins), "%"
)

proteome_tmh_only <- proteome[is_membrane_protein, ]
topology_tmh_only <- topology[is_membrane_protein, ]

pureseqtmr::save_tibble_as_fasta_file(
  t = proteome_tmh_only,
  fasta_filename = proteome_tmh_only_filename
)
pureseqtmr::save_tibble_as_fasta_file(
  t = topology_tmh_only,
  fasta_filename = topology_tmh_only_filename
)

testthat::expect_true(file.exists(proteome_tmh_only_filename))
testthat::expect_true(file.exists(topology_tmh_only_filename))
