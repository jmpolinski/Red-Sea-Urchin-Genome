#!/bin/bash

#split genome into 10kb windows (-b = genome length file, -w = window size)
/data/app/bedtools2/bin/windowMaker -b Mfran_chr_length_forBedtools_sort.txt \
-w 10000 > Mfran_genome_FINAL_10kb.windows.bed

#sort with bedtools
/data/app/bedtools2/bin/sortBed -i Mfran_genome_FINAL_10kb.windows.bed > Mfran_genome_FINAL_10kb.windowsSort.bed
rm Mfran_genome_FINAL_10kb.windows.bed

#get gene density (-c = use column 2 in file b (start position) to overlap with file a, -o = specifies counting, can also do mean, median etc)
/data/app/bedtools2/bin/mapBed -c 2 -o count -a Mfran_genome_FINAL_10kb.windowsSort.bed -b Mfran_braker_transcriptsSort.bed > Mfran_genecount_10kb.bed
