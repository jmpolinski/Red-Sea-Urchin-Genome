#!/bin/bash
#RepeatMasker with combined library
#November 19, 2021 - Kate Castellano

/data/app/RepeatMasker/RepeatMasker -pa 10 -lib Mfran_RepeatLibCombined_clustered.fa.classified \
Mfran_genome_final.fa -gff -a -noisy -xsmall 2>&1 | tee -a RepeatMasker.log
