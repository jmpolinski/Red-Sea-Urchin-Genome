#!/bin/bash
#run LTRharvest
#November 9, 2021 - Kate Castellano

/data/app/genometools-1.6.2/bin/gt ltrharvest -index Mfran_genome_final -gff3 Mfran_genome_LTRharvest.gff3 \
-out Mfran_genome_LTRharvest.fasta 2>&1 | tee -a LTRharvest.log
