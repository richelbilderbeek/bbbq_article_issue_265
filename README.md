# bbbq_article_issue_265

## Goal

Recreate figure 3 from Bianchi et al., 2017,
for MHC-II and epitopes from IEDB.

 * [Methods](methods.md)
 * [Files](files.md)

![](bianchi_et_2018_fig_3_published.png)

![](bianchi_et_2018_fig_3_raw.png)

 * Use `iedbr`
 * Use human TMH topology
 * Combine into plot

```
Epitopes from IEDB:

 AAAAAIFVI              
 MNILLQYVVKSFD           <----
 ALWMRLLPL              
 FLFAVGFYL              
 FLIVLSVAL              
 FLWSVFMLI              
 GIVEQCCTSI             
 GMAELMAGL               <----
 GSGDSENPGTARAWCQVAQKFTG
 GVLLKEFTVSGN         



                    GMAELMAGL
                                   MNILLQYVVKSFD

AAAAAAAAAAAAAAAAAAAAGMAELMAGLAAAAAAMNILLQYVVKSFDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
00000000000000000000000000011111111111100000000000000000000000000000000000000000000
```

## Methods

```mermaid
graph TD;
    A[Uniprot]-->|Download| B[Human reference proteome without selenoproteins];
    B-->|TMHMM| C[Topology];
    D[IEBD]-->|Download| E[All IEDB MHC ligands];
    E-->|Filter for focal MHC2 ligands with linear sequences| F[Epitope sequences for alleles];
    B-->|Merge| G[Results];
    C-->|Merge| G[Results];
    F-->|Merge| G[Results];
```

## Files

```mermaid
graph TD;
    A[https://www.iedb.org/database_export_v3.php]-->|Click on 'mhc_ligand_full, single_file.zip'| B[https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip];
    B-->|Unzip| C[mhc_ligand_full.csv];
    C-->|Run 'do_it.R'| D[epitopes_for_mhc2_alleles.csv];
```

