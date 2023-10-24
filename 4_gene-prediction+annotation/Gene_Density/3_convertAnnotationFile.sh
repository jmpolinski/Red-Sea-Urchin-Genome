#!/bin/bash

#get just one line per gene
awk '$3 == "transcript" {print}' /data/prj/urchin/red-urchin-genome/Mfran_braker-FINAL.gtf \
| awk -v OFS="\t" '{print $1,$4,$5,$10}' | sed 's/"//g' | sed 's/;//g' > Mfran_braker_transcripts.bed

#sort with bedtools
/data/app/bedtools2/bin/sortBed -i Mfran_braker_transcripts.bed > Mfran_braker_transcriptsSort.bed 
rm Mfran_braker_transcripts.bed #remove unsorted fileo

