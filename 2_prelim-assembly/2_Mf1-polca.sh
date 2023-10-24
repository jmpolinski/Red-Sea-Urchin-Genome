#!/bin/bash 

# working in /data/prj/urchin/red-urchin-genome/canu_04-2021

# symbolically link needed files (assembly & Illumina reads)
mkdir polca-corrected
cd polca-corrected
ln -s ../mfran-canu/mfran.contigs.fasta
ln -s ../../DATA/Illumina-data/red-urchin-Mf1_Illumina_R1.fq 
ln -s ../../DATA/Illumina-data/red-urchin-Mf1_Illumina_R2.fq 

# add needed tools to path
export PATH=$PATH:/data/app/bwa:/data/app/samtools/

# run POLCA
/data/app/MaSuRCA-4.0.3/bin/polca.sh -a ./mfran.contigs.fasta -r 'red-urchin-Mf1_Illumina_R1.fq red-urchin-Mf1_Illumina_R2.fq' -t 16 -m 1G
