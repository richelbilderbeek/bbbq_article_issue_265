setwd("~/GitHubs/bbbq_article_issue_265/")
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

# https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip
n_commas <- 111 # max(stringr::str_count(readr::read_lines("head.csv"), ","))
n_cols <- n_commas + 1
# csv_filename <- "head.csv"
csv_filename <- "/media/richel/D2B40C93B40C7BEB/bbbq_article_issue_265/mhc_ligand_full.csv"
testthat::expect_true(file.exists(csv_filename))
t <- readr::read_csv(csv_filename, skip = 1, n_max = 1)

first_colnames <- names(t)
last_colnames <- paste0("V", seq_len(n_commas + 1 - length(first_colnames)))
testthat::expect_equal(n_cols, length(first_colnames) + length(last_colnames))
all_colnames <- c(first_colnames, last_colnames)
testthat::expect_equal(n_cols, length(all_colnames))

df <- read.table(
  csv_filename,
  skip = 2,
  header = FALSE,
  sep = ",",
  col.names = all_colnames,
  fill = TRUE
)
t <- dplyr::select(tibble::as_tibble(df), c("Name", "MHC.allele.class", "Description...12", "Allele.Name"))
t_human <- t[stringr::str_which(t$Name, "human"), ]
t_human_mhc2 <- t_human[t_human$MHC.allele.class == "II", ]
t_clean <- dplyr::select(
  t_human_mhc2, c("sequence" = "Description...12"), c("allele_name" = "Allele.Name")
)
t_focal <- dplyr::filter(t_clean, t_clean$allele_name %in% bbbq::get_mhc2_haplotypes())

readr::write_csv(t_focal, "epitopes_for_mhc2_alleles.csv")


