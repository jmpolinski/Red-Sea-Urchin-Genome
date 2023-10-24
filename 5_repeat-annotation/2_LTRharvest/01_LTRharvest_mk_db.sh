#!/bin/bash
#LTRharvest - make the genome into an LTRharvest database
#November 8, 2021
#Kate Castellano


/data/app/genometools-1.6.2/bin/gt suffixerator -db Mfran_genome_final.fa \
-indexname Mfran_genome_final  -tis -suf -lcp -des -ssp -sds -dna
