epitope_distances_filename <- "epitope_distances.csv"
testthat::expect_true(file.exists(epitope_distances_filename))
epitope_distances <- readr::read_csv(epitope_distances_filename)

tmh_width <- 23 # amino acids

my_plot <- ggplot2::ggplot(
  epitope_distances,
  ggplot2::aes(x = distances_to_tmh_center)
) + ggplot2::geom_histogram(binwidth = 1.0) + 
    ggplot2::scale_x_continuous(limits = c(-30, 30)) +
    ggplot2::geom_vline(xintercept = -tmh_width / 2) +
    ggplot2::geom_vline(xintercept = tmh_width / 2)

ggplot2::ggsave("epitope_distances.png", plot = my_plot, width = 7, height = 7)

ggplot2::ggsave("epitope_distances.eps", plot = my_plot, width = 7, height = 7)
