#!/bin/bash
#pull out fasta sequences from TransposonPSI of red sea urchin genome
#November 8, 2021
#Kate Castellano


/data/app/bedtools2/bin/fastaFromBed -fi Mfran_genome_final.fa \
-bed Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.gff3 \
-s -fullHeader -fo Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.fasta

