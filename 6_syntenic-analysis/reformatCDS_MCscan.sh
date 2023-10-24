#!/bin/bash
#Convert CDS/RNA file to a format compatible with MCscan
#Kate Castellano

#M franciscanus
python3 -m jcvi.formats.fasta format \
/data/prj/urchin/red-urchin-genome/Mfran_braker-transcripts_FINAL.fa \
Mfranciscanus.cds

#L variegatus
python3 -m jcvi.formats.fasta format \
/data/prj/urchin/red-urchin-genome/synteny-analysis/mfran_vs_lvar/GCF_018143015.1_Lvar_3.0_rna_from_genomic.fna \
Lvariegatus.cds

#Lpictus
python3 -m jcvi.formats.fasta format \
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Lpictus/fromAmroseLab/lytpic2.0.all.maker.transcripts.LPI.fasta \
Lpictus.cds

#Spurp
python3 -m jcvi.formats.fasta format \
/data/prj/urchin/red-urchin-genome/synteny-analysis/mfran_vs_spurp/sp5_0_GCF_CDS.fa \
Spurp.cds
