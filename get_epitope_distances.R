# For each epitope, tally the distances
stop("Not yet")
  
distances_filename <- "distances.csv"
testthat::expect_true(file.exists(distances_filename))
epitopes_filename <- "epitopes_for_mhc2_alleles.csv"
testthat::expect_true(file.exists(epitopes_filename))
epitope_locations_filename <- "epitope_locations.csv"
testthat::expect_true(file.exists(epitope_locations_filename))

distances <- readr::read_csv(distances_filename)
# epitopes <- readr::read_csv(epitopes_filename)
epitope_locations <- readr::read_csv(epitope_locations_filename)

epitope_distances <- tibble::tibble(
  epitope = ,
  distances = 
)
