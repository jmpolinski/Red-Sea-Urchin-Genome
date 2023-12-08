# Ortholog & Gene Family Expansion/Contraction Analyses

**Choosing species for analysis**  
Species for comparison were selected by Kate Castellano and QC'ed to improve quality/remove isoforms and duplicates. For information on QC of the protein sets prior to analysis, see files in "Species_Selection".  

**OrthoFinder ortholog analysis**  
Orthofinder v2.5.4 was used for this analysis. Protein files were placed in /data/prj/urchin/red-urchin-genome/gene-family-analyses/KC-files. Headers for each protein fasta were edited to remove excess information besides the gene/locus ID and to add the species name to the beginning of the IDs.   
Code for running Orthofinder is in "1_orthofinder.sh".  
  
**CAFE gene family analysis**  

