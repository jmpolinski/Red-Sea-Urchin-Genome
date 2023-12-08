#!/bin/bash

########### Mapping RNAseq data with HISAT2 to use as evidence for gene model prediction ############
# working in /data/prj/urchin/red-urchin-genome/transcriptome/sra

# Build hisat2 index for the genome:
/data/app/hisat2-2.2.1/hisat2-build -f Mfran_genome_final.fa mfran

#### LOOP FOR SINGLE READ RNA-SEQ DATA ####
ls *fastq > files
sed -i -e 's/.fastq//g' files
export HISAT2_INDEXES=/data/prj/urchin/red-urchin-genome/transcriptome/
for i in `cat files`; do /data/app/hisat2-2.2.1/hisat2 -x mfran -U $i.fastq -S $i.sam; done

#### LOOP FOR PAIRED READ RNA-SEQ DATA ####
ls *_1.fastq > files
sed -i -e 's/_1.fastq//g' files
export HISAT2_INDEXES=/data/prj/urchin/red-urchin-genome/transcriptome/
for i in `cat files`; do /data/app/hisat2-2.2.1/hisat2 -x mfran -1 ${i}_1.fastq -2 ${i}_2.fastq -S $i.sam; done

# Convert SAM to BAM
for i in `cat files; do samtools view -Su $i.sam | samtools sort -o $i.bam; done

# Merge all sample BAM files
cd ../
samtools merge -@ 32 mfran_all-rnaseq.bam ./sra/*bam
