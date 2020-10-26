# TCRdb: A comprehensive database of T-cell receptor sequences in various conditions 

<a href=''><img src='Homepage.png' align='right' height='250' /></a>

TCRdb contains more than 100 million highly reliable TCR sequences from over 6600 TCR-Seq samples across hundreds of tissues/clinical conditions/cell types. The unique features of TCRdb include: 
* Comprehensive and reliable sequences for TCR repertoire in different samples generated by a strict and uniform pipeline of TCRdb;  
* Powerful search function, allowing users to identify their interested TCR sequences in different conditions; 
* Categorized sample metadata, enabling comparison of TCRs in different sample types; 
* Interactive data visualization charts, describing the TCR repertoire in TCR diversity, length distribution and V-J gene utilization.

The TCRdb database is freely available at [http://bioinfo.life.hust.edu.cn/TCRdb/ ](http://bioinfo.life.hust.edu.cn/TCRdb/ )

## Description

`CATT .smk`, `MiXCR.smk`, `IMSEQ.smk`: The parameters used for each method.

`Download.smk`： For data download from NCBI.

`QC_single/double.smk`: For raw data quanlity control.

All the pipepines were written in Snakemake.

## Citing

Si-Yi Chen, Tao Yue, Qian Lei, An-Yuan Guo, TCRdb: a comprehensive database for T-cell receptor sequences with powerful search function, *Nucleic Acids Research*, , gkaa796, https://doi.org/10.1093/nar/gkaa796