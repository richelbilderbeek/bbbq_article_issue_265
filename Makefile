all: epitopes_for_mhc2_alleles.csv distances.csv epitope_locations.csv

# epitope_distances.csv: distances.csv epitopes_for_mhc2_alleles.csv
# Rscript get_epitope_distances.R

epitope_locations.csv: UP000005640_9606_no_u.fasta epitopes_for_mhc2_alleles.csv
	Rscript get_epitope_locations.R

distances.csv: UP000005640_9606_no_u_tmh_only.tmhmm
	Rscript get_distances.R

UP000005640_9606_no_u_tmh_only.tmhmm UP000005640_9606_no_u_tmh_only.fasta: UP000005640_9606_no_u.tmhmm UP000005640_9606_no_u.fasta
	Rscript get_proteome_and_topology_tmh_only.R

epitopes_for_mhc2_alleles.csv:
	Rscript get_epitopes.R

UP000005640_9606_no_u.fasta:
	Rscript get_proteome.R

UP000005640_9606_no_u.tmhmm:
	Rscript get_topology.R

