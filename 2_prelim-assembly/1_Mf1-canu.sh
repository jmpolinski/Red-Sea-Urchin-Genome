#!/bin/bash 

# Note that the base directory for this project is /data/prj/urchin/red-urchin/genome

# Run CANU assembler with QC'ed MinION data
mkdir canu_04-2021; cd canu_04-2021
ln -s ../Mf1_minion_all.fastq .
export PATH=$PATH:/data/app/canu-2.1.1/bin/
canu -p mfran -d mfran-canu genomeSize=1.0g -nanopore Mf1_minion_all.fastq useGrid=true

# Check assembly stats
/data/app/assembly-stats/assembly-stats ./mfran-canu/mfran.contigs.fasta
/data/app/bbmap-38.26/stats.sh ./mfran-canu/mfran.contigs.fasta

