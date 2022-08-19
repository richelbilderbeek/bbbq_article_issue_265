# bbbq_article_issue_265

## Goal

Recreate figure 3 from Bianchi et al., 2017,
for MHC-II and epitopes from IEDB.

![](bianchi_et_2018_fig_3_published.png)

![](bianchi_et_2018_fig_3_raw.png)

## Run

```
make
```

Make sure you got about 18 GB of RAM for `get_epitopes.R`.

## Methods

```mermaid
graph TD;
    A[Uniprot]-->|Download| B[Human reference proteome without selenoproteins\bprotein_name,protein_sequence];
    B-->|Create look-up table| BL[protein name to protein code look-up table];
    B-->|TMHMM| C[Topology];
    BL-->|LUT| C;
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
