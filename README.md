# bbbq_article_issue_265

## Goal

Recreate figure 3 from Bianchi et al., 2017,
for MHC-II and epitopes from IEDB.

![](bianchi_et_2018_fig_3_published.png)

![](bianchi_et_2018_fig_3_raw.png)

## Result

![](results/epitope_distances_combined.png)

## Run

```
make
```

Make sure you got about 18 GB of RAM for `get_epitopes.R`.

## Methods

I use [https://mermaid.live](https://mermaid.live) to be able to zoom in.

```mermaid
graph TD;
    A[Internet<br>UniProt]-->|get_proteome.R| B[UP000005640_9606_no_u.fasta];
    C[Internet<br>Earlier BBBQ result]-->|get_topology.R| D[UP000005640_9606_no_u.tmhmm];
    A-.->C
    B-->|create_proteins_lut.R| E[proteins_lut.csv<br>name,full_protein_name]
    D-->|create_proteins_lut.R| E
    B-->|get_membrane_proteins_sequences_and_topology.R| F[membrane_proteins.fasta]
    D-->|get_membrane_proteins_sequences_and_topology.R| F
    E-->|get_membrane_proteins_sequences_and_topology.R| F
    B-->|get_membrane_proteins_sequences_and_topology.R| G[membrane_proteins.tmhmm]
    D-->|get_membrane_proteins_sequences_and_topology.R| G
    E-->|get_membrane_proteins_sequences_and_topology.R| G
    F-->|get_distances.R| H[distances.csv<br>name,position,distance_to_tmh_center]
    G-->|get_distances.R| H
    I[Internet<br>IEDB]-->|get_epitopes.R| J[epitopes_for_mhc1_and_mhc2_alleles.csv<br>sequence,allele_name]
    E-->|get_epitope_locations.R| K[epitope_locations.csv<br>name,sequence,epitopes_sequence]
    F-->|get_epitope_locations.R| K
    J-->|get_epitope_locations.R| K
    H-->|get_epitope_distances.R| L[epitope_distances.csv<br>epitope,distances_to_tmh_center]
    K-->|get_epitope_distances.R| L
    L-->|plot_epitope_distances.R| M[epitope_distances.png]
    L-->|get_epitope_distances_per_allele.R| N[epitope_distances_per_allele.csv<br>epitope_sequence,allele_name,distances_to_tmh_center]
    N-->|plot_epitope_distances_per_allele.R| O[epitope_distances_per_allele_mhc_1.png]
    N-->|plot_epitope_distances_per_allele.R| P[epitope_distances_per_allele_mhc_2.png]


```

Note `name` instead of the more expressive `protein_name` is used, due
to the use of FASTA files: when parsing these, `name` is the default
column name.

## Bias for negative distances

Imagine this topology:

```
01010
```

This will be talled as such:

Position|Distance to TMH
--------|---------------
1       |-1
2       |0
3       |-1
4       |0
5       |1

Position 3 is right in between two TMHs, so the distance to the closest
TMH is undecided.

We expect this to be irrelevant in reality, as:

 * we expect TMHs to be separated by many amino acids
 * we plot from -30 to +30 amino acids

If you see a bias in negative distances, this cause be the cause.

## Ignore two epitopes in same protein

We assume an epitope to be present in a protein once.
Partial data shows that in (8 out of 3891 = ) 0.2%
of all cases this assumption is false.

For the epitopes that appear in a protein twice, 
only the location of the first is used in the calculations.

```
Total number proteins-epitope combination: 3899
1x epitope per protein: 3891
2x epitope per protein: 8
```

## Create graph from Makefile

From https://unix.stackexchange.com/a/576563:

```
cd GitHubs
git clone https://github.com/lindenb/makefile2graph
cd makefile2graph
make
```

```
make -Bnd |  ../makefile2graph/make2graph | dot -Tpng -o my_graph.png
```
