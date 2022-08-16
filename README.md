# bbbq_article_issue_265

## Goal

Recreate figure 3 from Bianchi et al., 2017,
for MHC-II and epitopes from IEDB.

![](bianchi_et_2018_fig_3_published.png)

![](bianchi_et_2018_fig_3_raw.png)

## Method

 * Get human proteome
 * Get topology of human proteome
 * 

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
graph Method;
    U[Uniprot]--> |Download| A;
    A[Human reference proteome without selenoproteins]--> |Merge| E;
    A--> |TMHMM| B[Topology];
    B--> |Merge| E;
    C[All IEDB MHC ligands]--> |Filter for focal MHC-II ligands with linear sequences| D[Epitope sequences for alleles];
    D--> |Merge| E[Results];
```

## Files

```mermaid
graph Files;
    A[https://www.iedb.org/database_export_v3.php]--> |Click on 'mhc_ligand_full, single_file.zip'| B[https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip];
    B--> |Unzip| C[mhc_ligand_full.csv];
    C--> |Run 'do_it.R'| D[epitopes_for_mhc2_alleles.csv];
```

> Files

