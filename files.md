# Files

```mermaid
graph Files;
    A[https://www.iedb.org/database_export_v3.php]--> |Click on 'mhc_ligand_full, single_file.zip'| B[https://www.iedb.org/downloader.php?file_name=doc/mhc_ligand_full_single_file.zip];
    B--> |Unzip| C[mhc_ligand_full.csv];
    C--> |Run 'do_it.R'| D[epitopes_for_mhc2_alleles.csv];
```

