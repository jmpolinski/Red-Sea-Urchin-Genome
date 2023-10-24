#!/bin/bash

# working in directory that contains all MinION run directories

# First combine all fastq files from each MinioN run:
cat ./MinION_20201027_Mf1-run1/fastq_fast/*fastq > Mf1_minion-1.fastq
cat ./MinION_20201030_Mf1-run2/fastq_fast/*fastq > Mf1_minion-2.fastq
cat ./MinION_20201102_Mf1-run3/fastq_fast/*fastq > Mf1_minion-3.fastq
cat ./MinION_20201111_Mf1-run4/fastq_fast/*fastq > Mf1_minion-4.fastq

# Check read statistics:
/data/app/seqkit stats Mf1_minion-*

# Create text file for using with loops:
ls Mf1_minion*fastq > minion
sed -i -e 's/.fastq//g' minion

# Use NanoFilt to filter based on reach quality and length (installed nanofilt 3/29/2021):
for i in `cat minion`; do python3 /data/app/nanopore/nanofilt/NanoFilt.py -q 10 -l 1000 --headcrop 50 ${i}.fastq > ${i}_qc.fq; done

# Check QC'ed read stats:
/data/app/seqkit stats Mf1_minion*qc.fq
