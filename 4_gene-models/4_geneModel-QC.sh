#!/bin/bash

######## QC to remove poor gene models from BRAKER2 set ###########

# Run Interproscan and pull out genes with Pfam hits to keep:
/data/app/interproscan-5.53-87.0/interproscan.sh -appl Pfam -i Mfran_uniq-braker-rna.faa -iprlookup -goterms
awk '{print $1}' Mfran_uniq-braker-rna.faa.tsv | sort | uniq > genes-w-pfam.txt
  # total of 22063 genes with PFam hits
/data/app/seqtk/seqtk subseq Mfran_uniq-braker-rna.faa genes-w-pfam.txt > Mfran_braker_w.pfam.faa

# Find and extract multi-exonic genes that did not have a Pfam hit:
ln -s ../gene-prediction/braker_runs/_braker-rna-FINAL/gfacs-uniq-multiex/genes.fasta Mfran_braker_multiex.fa
grep ">" Mfran_braker_multiex.fa | sort | uniq > genes-multiex.txt
sed -i -e 's/>//g' genes-multiex.txt
grep -wv -f genes-w-pfam.txt genes-multiex.txt > multiex_no-pfam.txt
/data/app/seqtk/seqtk subseq Mfran_uniq-braker-rna.faa multiex_no-pfam.txt > ./Mfran_braker_multiex-noPfam.fa
 # 11192 gene IDs

# Blast multi-exonic genes that do not have a Pfam domain against UniProt reviewed protein database:
## downloaded the newest Uniprot release, which was 2021-04 and made blast DB called "uniprot"
blastx -query ./Mfran_braker_multiex-noPfam.fa -db /data/app/databases/uniprot/uniprot -num_threads 4 -outfmt 6 -evalue 1e-05 -out multi-noP_uniprot.txt
awk '{print $1}' multi-noP_uniprot.txt | sort | uniq > multi-noP_blasthits.txt
/data/app/seqtk/seqtk subseq Mfran_uniq-braker-rna.faa multi-noP_blasthits.txt > Mfran_braker_w.uniprot.faa

# combine gene model sets that had Pfam domains and that were multiexonic with a hit against the Uniprot database (despite no Pfam):
cat Mfran_braker_w.pfam.faa Mfran_braker_w.uniprot.faa > Mfran_braker_qc-models.faa


# Check completeness with BUSCO:
busco -i ./Mfran_braker_qc-models.faa -o BUSCO_qc-prots -l /data/app/busco-5.1.2/lineages/metazoa_odb10 --mode proteins -c 12
  ## C:95.7%[S:84.2%,D:11.5%],F:3.4%,M:0.9%,n:954

# NOTE: there was an issue with some isoforms being called separate genes (bug in BRAKER) - these were manually corrected 
