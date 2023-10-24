#!/bin/bash
#MCscan convert gff files to bed files
#Kate Castellano

#M. fran
python3 -m jcvi.formats.gff bed --type=transcript \
/data/prj/urchin/red-urchin-genome/synteny-analysis/Mfran_braker-CORRECTED.gff \
-o Mfranciscanus.bed

#L. variegatus
python3 -m jcvi.formats.gff bed --type=mRNA \
--key=Name /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Lvariegatus3.0/GCF_018143015.1_Lvar_3.0_genomic.gff \
-o Lvariegatus.bed

#Lpictus
python3 -m jcvi.formats.gff bed --type=mRNA \
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Lpictus/fromAmroseLab/lytpic2.0.all.noseq.LPI.maker.sorted.gff \
-o Lpictus.bed

#Spurp
python3 -m jcvi.formats.gff bed --type=gene \
/data/prj/urchin/red-urchin-genome/synteny-analysis/mfran_vs_spurp/sp5_0_GCF_top21chr.gff3 \
-o Spurp_gene.bed
