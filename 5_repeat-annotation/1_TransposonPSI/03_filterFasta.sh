#!/bin/bash
#remove sequences < 50 bp
#November 9, 2021 - Kate Castellano

awk '/!^>/ { next } { getline seq } length(seq) >= 50 { print $0 "\n" seq}' \
Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader.fasta > Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader_filter.fasta

