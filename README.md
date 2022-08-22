# bbbq_article_issue_265

## Goal

Recreate figure 3 from Bianchi et al., 2017,
for MHC-II and epitopes from IEDB.

![](bianchi_et_2018_fig_3_published.png)

![](bianchi_et_2018_fig_3_raw.png)

## Result

![](epitope_distances.png)

## Run

```
make
```

Make sure you got about 18 GB of RAM for `get_epitopes.R`.

## Methods

```mermaid
graph TD;
    A[Internet<br>UniProt]-->|get_proteome.R| B[UP000005640_9606_no_u.fasta];
    C[Internet<br>Earlier BBBQ result]-->|get_topology.R| D[UP000005640_9606_no_u.tmhmm];
    A-.->C
    B-->|create_proteins_lut.R| E[proteins_lut.csv]
    D-->|create_proteins_lut.R| E[proteins_lut.csv]
    B-->|get_membrane_proteins_sequences_and_topology.R| F[membrane_proteins.fasta]
    D-->|get_membrane_proteins_sequences_and_topology.R| F
    E-->|get_membrane_proteins_sequences_and_topology.R| F
    B-->|get_membrane_proteins_sequences_and_topology.R| G[membrane_proteins.tmhmm]
    D-->|get_membrane_proteins_sequences_and_topology.R| G
    E-->|get_membrane_proteins_sequences_and_topology.R| G
    F-->|get_distances.R| H[distances.csv]
    G-->|get_distances.R| H
    I[Internet<br>IEDB]-->|get_epitopes.R| J[epitopes_for_mhc1_and_mhc2_alleles.csv]
    E-->|get_epitope_locations.R| K[epitope_locations.csv]
    F-->|get_epitope_locations.R| K
    J-->|get_epitope_locations.R| K
    H-->|get_epitope_distances.R| L[epitope_distances.csv]
    K-->|get_epitope_distances.R| L
    L-->|plot_epitope_distances.R| M[epitope_distances.png]
```


```mermaid
graph TD;
    A[Uniprot]-->|Download\nget_proteome.R| B[Human reference proteome without selenoproteins\nUP000005640_9606_no_u.fasta\nprotein_name,protein_sequence];
    B-->|Create look-up table| BL[protein name to protein code look-up table\nproteins_lut.csv\name,full_protein_name];
    T[Download\nUP000005640_9606_no_u.tmhmm\nfull_protein_name,topology]-->|TMHMM| C[Topology];
    BL-->|LUT\nproteins_lut.csv\name,fullproteinname| C[membrane_proteins.tmhmm\nname,topology];

    B-->|Keep only proteins with TMH| BM[Membrane proteins]
    BL-->|LUT| BM;
    C-->|Keep only proteins with TMH| BM
    D[IEBD]-->|Download| E[All IEDB MHC ligands];
    E-->|Filter for focal MHC-I or MHC-II ligands with linear sequences| F[Epitope sequences for alleles];
    BM-->|Calculate distances| G[Distance of each AA to a TMH center];
    E-->|Merge| G[Distances of epitopes to TMH center];
    G-->|Merge| G;
```

Sketch of merge:

```
                    GMAELMAGL      MNILLQYVVKSFD            Epitopes from IEDB:

AAAAAAAAAAAAAAAAAAAAGMAELMAGLAAAAAAMNILLQYVVKSFDAAAAAAAAAAA Uniprot reference proteome sequence
00000000000000000000000000011111111111100000000000000000000 TMHMM topology
                    ...-9876543210123456789...              Distances from TMH
                    +++++++++      +++++++++++++            Tally
                    0.0   0.5 0.0  0.5       0.5 0.0        Overlap count
                               
```

## Files

```mermaid
graph TD;
    A[https://www.iedb.org/database_export_v3.php]-->|Click on 'mhc_ligand_full, single_file.zip'| B[https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip];
    B-->|Unzip| C[mhc_ligand_full.csv];
    C-->|Run 'do_it.R'| D[epitopes_for_mhc2_alleles.csv];
```

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
