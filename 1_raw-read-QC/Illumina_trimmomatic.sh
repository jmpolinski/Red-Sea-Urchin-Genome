#!/bin/bash

# working in directory containing Illumina raw fastq files 

# Create "samples" file with ID's for looping, then run FastQC on raw Illumina data to look at the initial quality of the reads:
ls *R1*fastq > samples
sed -i -e 's/_R1_001.fastq//g' samples
mkdir fastqc
for i in `cat samples`; do fastqc -o fastqc -f fastq -t 4 ${i}_R1_001.fastq ${i}_R2_001.fastq; done

# Use trimmomatic to remove low quality bases and sequencing adapters:
for i in `cat samples`; 
do java -jar /data/app/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 12 -phred33 ${i}_R1_001.fastq \
${i}_R2_001.fastq ${i}_R1-qc.fq ${i}_R1-unpaired.fq ${i}_R2-qc.fq ${i}_R2-unpaired.fq \
ILLUMINACLIP:/data/app/Trimmomatic-0.38/adapters/TruSeq3-PE-2.fa:3:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50; 
done

# Combine all R1 and R2 QC'ed reads:
cat *R1-qc.fq > red-urchin-Mf1_Illumina_R1.fq
cat *R2-qc.fq > red-urchin-Mf1_Illumina_R2.fq

# Rerun FastQC on trimmed data:
fastqc -o fastqc -f fastq -t 4 red-urchin-Mf1_Illumina_R1.fq red-urchin-Mf1_Illumina_R2.fq

