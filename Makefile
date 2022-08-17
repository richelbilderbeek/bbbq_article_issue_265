all: epitopes_for_mhc2_alleles.csv distances.csv

UP000005640_9606_no_u.fasta:
	Rscript get_proteome.R

UP000005640_9606_no_u.tmhmm:
	Rscript get_topology.R

epitopes_for_mhc2_alleles.csv: UP000005640_9606_no_u.fasta UP000005640_9606_no_u.tmhmm
	Rscript get_epitopes.R

distances.csv: UP000005640_9606_no_u.tmhmm
	Rscript get_distances.R



