# For each epitope, tally the distances
stop("Not yet")
  
distances_filename <- "distances.csv"
testthat::expect_true(file.exists(distances_filename))
epitopes_filename <- "epitopes_for_mhc1_and_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))
epitope_locations_filename <- "epitope_locations.csv"
if (1 == 2) {
  epitope_locations_filename <- "epitope_locations_test.csv"
  
}
testthat::expect_true(file.exists(epitope_locations_filename))

distances <- readr::read_csv(distances_filename)
epitopes <- readr::read_csv(epitopes_filename)
epitope_locations <- readr::read_csv(epitope_locations_filename)

# Look for duplicate matches
n_epitope_per_protein <- stringr::str_count(
  string = epitope_locations$sequence, 
  pattern = epitope_locations$epitopes_sequence
)

message(
  "Total number proteins-epitope combination: ", nrow(epitope_locations), "\n",
  "1x epitope per protein: ", sum(n_epitope_per_protein == 1), "\n",
  "2x epitope per protein: ", sum(n_epitope_per_protein == 2), "\n"
)

start_positions <- stringr::str_locate(
  string = epitope_locations$sequence, 
  pattern = epitope_locations$epitopes_sequence
)[, 1]
end_positions <- stringr::str_locate(
  string = epitope_locations$sequence, 
  pattern = epitope_locations$epitopes_sequence
)[, 2]
epitope_locations$start <- start_positions
epitope_locations$end <- end_positions
#epitope_locations$sequence <- NULL

distances_list <- list()

n_epitope_locations <- nrow(epitope_locations)
if (1 == 2) {
  n_epitope_locations <- 100
}
for (i in seq_len(n_epitope_locations)) {
  message(i, "/", n_epitope_locations)
  protein_name <- epitope_locations$name[i]
  epitope_sequence <- epitope_locations$epitopes_sequence[i]
  protein_start <- epitope_locations$start[i]
  protein_end <- epitope_locations$end[i]
  head(distances$name)
  
  distances_to_tmh_center <- dplyr::filter(
    dplyr::filter(distances, name == protein_name),
    position >= protein_start & position <= protein_end
  )$distance_to_tmh_center
  testthat::expect_equal(
    length(distances_to_tmh_center),
    nchar(epitope_sequence)
  )
  distances_list[[i]] <- tibble::tibble(
    epitope = epitope_sequence, 
    distances_to_tmh_center
  )
}

distances <- dplyr::bind_rows(distances_list)

readr::write_csv(distances, "epitope_distances.csv")