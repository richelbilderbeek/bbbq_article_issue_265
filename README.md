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

## Method

```mermaid
graph Methods;
    MA-->|Download| MB[Human reference proteome without selenoproteins];
    MB-->|Merge| MF;
    MB-->|TMHMM| MC[Topology];
    MC-->|Merge| MD[All IEDB MHC ligands];
    MD-->|Filter for focal MHC2 ligands with linear sequences| MD[Epitope sequences for alleles];
    MD-->|Merge| ME[Results];
```

