# This is a big file, of several gigabytes that cannot be downloaded using wget.
# It can be downloaded from here:
#
# https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip
#
# Unzip it and update the path below
#
csv_filename <- "/media/richel/D2B40C93B40C7BEB/bbbq_article_issue_265/mhc_ligand_full.csv"

n_commas <- 111 # max(stringr::str_count(readr::read_lines("head.csv"), ","))
n_cols <- n_commas + 1
# csv_filename <- "head.csv"
if (!file.exists(csv_filename))
{
  stop(
    "Cannot find .csv filename ", csv_filename, "\n",
    "  \n",
    "1. Downloaded the compressed file from: \n",
    "  \n",
    "  https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip \n",
    "  \n",
    "2. Unzip the file and update the path at the top of this script"
  )
}
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

message("Unique MHC allele classes: ", unique(t_human[t_human$MHC.allele.class))
stop("Do again!")

t_human_mhc2 <- t_human[t_human$MHC.allele.class == "II", ]
t_clean <- dplyr::select(
  t_human_mhc2, c("sequence" = "Description...12"), c("allele_name" = "Allele.Name")
)
t_focal <- dplyr::filter(t_clean, t_clean$allele_name %in% bbbq::get_mhc2_haplotypes())

# Remove complex epitopes such as HPSFKERFHASVRRL + CITR(R7, R14)
aa_sequence_regex <- paste0("^[", paste0(Peptides::aaList(), collapse = ""), "]+$")

t_clean_focal <- t_focal[stringr::str_detect(t_focal$sequence, aa_sequence_regex), ]

readr::write_csv(t_clean_focal, "epitopes_for_mhc2_alleles.csv", quote = "none")
