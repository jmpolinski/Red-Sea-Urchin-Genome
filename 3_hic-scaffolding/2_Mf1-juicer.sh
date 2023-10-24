#!/bin/bash

# working in /data/prj/urchin/red-urchin-genome/hi-c/juicer_hic

# Generate bwa index for genome draft (using version with contigs <15 Kbp removed)
/data/app/bwa/bwa index draft_15kb+.fa

# Generate restriction site file for Juicer
/data/app/juicer-1.6/misc/generate_site_positions.py DpnII draft_15kb+ draft_15kb+.fa
# resulting file = draft_15kb+_DpnII.txt

# Generate chromosome size file for Juicer
samtools faidx draft_15kb+.fa
cut -f 1,2 draft_15kb+.fa.fai > chrom.sizes

# run juicer pipeline
export PATH=$PATH:/data/app/bwa/
/data/app/juicer-1.6/CPU/juicer.sh -g draft_15kb+ -s DpnII -z draft_15kb+.fa -y draft_15kb+_DpnII.txt -p chrom.sizes
