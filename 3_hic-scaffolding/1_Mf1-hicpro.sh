#!/bin/bash

# working in /data/prj/urchin/red-urchin-genome/hi-c/hic-pro_0810/input
# configuration file needed to be copied and edited prior to running HiC-Pro (see README)



# Symbolically link genome reference and HiC fastq files:
ln -s ../../../Mfran_genome-v1_no-mt.fa .
ln -s ../../polinski-mf1_S3HiC_R1.fastq.gz ./fastqs/mf1-hic_R1.fastq.gz
ln -s ../../polinski-mf1_S3HiC_R2.fastq.gz ./fastqs/mf1-hic_R2.fastq.gz

# Bowtie2 index files: 
/data/app/bowtie2/bowtie2-build Mfran_genome-v1_no-mt.fa mfran-v1

# Digest the reference genome by the provided restriction enzymes(s) and generate a BED file with the list of restriction fragments after digestion:
/data/app/HiC-Pro_3.0.0/bin/utils/digest_genome.py -r ^GATC -o mfran_dpnii.bed Mfran_genome-v1_no-mt.fa

# Generate a table file of chromosome sizes:
samtools faidx Mfran_genome-v1_no-mt.fa
cut -f 1,2 Mfran_genome-v1_no-mt.fa.fai > chromosome_sizes.tbl

# run HiC-Pro
/data/app/HiC-Pro_3.0.0/bin/HiC-Pro -i /data/prj/urchin/red-urchin-genome/hi-c/hic-pro_0810/input -o /data/prj/urchin/red-urchin-genome/hi-c/hic-pro_0810/output -c config-hicpro_mfran.txt
