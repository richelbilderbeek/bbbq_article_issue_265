epitope_distances_per_allele_filename <- "epitope_distances_per_allele.csv"
testthat::expect_true(file.exists(epitope_distances_per_allele_filename))
epitope_distances_per_allele <- readr::read_csv(epitope_distances_per_allele_filename)

tmh_width <- 23 # amino acids

mhc_1 <- ggplot2::ggplot(
  dplyr::filter(epitope_distances_per_allele, allele_name %in% bbbq::get_mhc1_allele_names()),
  ggplot2::aes(x = distances_to_tmh_center)
) + ggplot2::geom_histogram(binwidth = 1.0) + 
    ggplot2::scale_x_continuous(limits = c(-30, 30)) +
    ggplot2::geom_vline(xintercept = -tmh_width / 2) +
    ggplot2::geom_vline(xintercept = tmh_width / 2) + 
  ggplot2::facet_grid(allele_name ~ ., scales = "free_y")

ggplot2::ggsave("epitope_distances_per_allele_mhc_1.png", plot = mhc_1, width = 7, height = 35)
ggplot2::ggsave("epitope_distances_per_allele_mhc_1.eps", plot = mhc_1, width = 7, height = 35)

mhc_2 <- ggplot2::ggplot(
  dplyr::filter(epitope_distances_per_allele, allele_name %in% bbbq::get_mhc2_allele_names()),
  ggplot2::aes(x = distances_to_tmh_center)
) + ggplot2::geom_histogram(binwidth = 1.0) + 
  ggplot2::scale_x_continuous(limits = c(-30, 30)) +
  ggplot2::geom_vline(xintercept = -tmh_width / 2) +
  ggplot2::geom_vline(xintercept = tmh_width / 2) + 
  ggplot2::facet_grid(allele_name ~ ., scales = "free_y")

ggplot2::ggsave("epitope_distances_per_allele_mhc_2.png", plot = mhc_2, width = 7, height = 35)
ggplot2::ggsave("epitope_distances_per_allele_mhc_2.eps", plot = mhc_2, width = 7, height = 35)
