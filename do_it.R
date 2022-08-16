proteome <- bbbq::get_proteome(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative"
)
topology <- bbbq::get_topology(
  target_name = "human",
  keep_selenoproteins = FALSE,
  proteome_type = "representative",
  topology_prediction_tool = "tmhmm"
)
testthat::expect_equal(length(proteome), length(topology))
testthat::expect_true("name" %in% names(proteome))
testthat::expect_true("sequence" %in% names(proteome))
testthat::expect_true("name" %in% names(topology))
testthat::expect_true("sequence" %in% names(topology))
testthat::expect_equal(proteome$name[1], topology$name[1])
testthat::expect_equal(nchar(proteome$sequence[1]), nchar(topology$sequence[1]))
testthat::expect_equal(nchar(proteome$name), nchar(topology$name))
testthat::expect_equal(nchar(proteome$sequence), nchar(topology$sequence))

allele_filename_map <- tibble::tibble(
  mhc2_allele_name = bbbq::get_mhc2_allele_names(),
  csv_filename = NA
)
allele_filename_map$csv_filename <- paste0(
  seq(1, nrow(allele_filename_map)), ".csv"
)
if (1 == 2) {
  allele_filename_map <- allele_filename_map[1:3, ]
}


# FAILS
# https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip
download.file(
  url = "https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip",
  destfile = "mhc_ligand_full_single_file.zip"
)

# Download from
# https://www.iedb.org/downloader.php?file_name=doc/iedb_export.zip
