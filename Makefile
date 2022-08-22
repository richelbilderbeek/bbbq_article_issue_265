all: epitope_distances.png \
  epitope_distances_per_allele_mhc_1.png \
  epitope_distances_per_allele_mhc_2.png

epitope_distances_per_allele_mhc_1.png epitope_distances_per_allele_mhc_2.png: \
                                                epitope_distances_per_allele.csv
	Rscript plot_epitope_distances_per_allele.R

epitope_distances_per_allele.csv: epitope_distances.csv
	Rscript get_epitope_distances_per_allele.R

epitope_distances.png: epitope_distances.csv
	Rscript plot_epitope_distances.R

epitope_distances.csv: distances.csv \
                       epitope_locations.csv
	Rscript get_epitope_distances.R

epitope_locations.csv: membrane_proteins.fasta \
                       epitopes_for_mhc1_and_mhc2_alleles.csv \
                       proteins_lut.csv
	Rscript get_epitope_locations.R

epitopes_for_mhc1_and_mhc2_alleles.csv:
	Rscript get_epitopes.R

distances.csv: membrane_proteins.tmhmm \
               membrane_proteins.fasta
	Rscript get_distances.R

membrane_proteins.tmhmm membrane_proteins.fasta: UP000005640_9606_no_u.tmhmm \
                                                 UP000005640_9606_no_u.fasta \
                                                 proteins_lut.csv
	Rscript get_membrane_proteins_sequences_and_topology.R

proteins_lut.csv: UP000005640_9606_no_u.tmhmm \
                  UP000005640_9606_no_u.fasta
	Rscript create_proteins_lut.R


UP000005640_9606_no_u.tmhmm:
	Rscript get_topology.R

UP000005640_9606_no_u.fasta:
	Rscript get_proteome.R

