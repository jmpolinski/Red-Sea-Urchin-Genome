#!/bin/bash
#run LTRdigest on LTRharvest output to remove false positive hits and LTRs without domain hits
#November 9, 2021 - Kate Castellano

export PATH=$PATH:/data/app/hmmer-3.3/bin/

/data/app/genometools-1.6.2/bin/gt -j 5 ltrdigest -outfileprefix Mfran_genome_LTRharvestDigest \
-hmms ~/*.hmm \
-matchdescstart Mfran_genome_LTRharvest_sort.gff3 \
Mfran_genome_final > Mfran_genome_LTRharvestDigest.gff3 2>&1 | tee -a LTRharvest.log
