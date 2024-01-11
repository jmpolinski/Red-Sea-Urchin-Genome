#!/bin/bash
#Get Get CDS sequences for each orthogroup
#Kate Castellano

listFiles="*_headers.txt"
cdsFile="/data/prj/urchin/red-urchin-genome/positive-selection/cds-files-urchinsOnly/AllSpecies.faa"

for file in ${listFiles}
do

	prefix=$(echo ${file} | cut -d "_" -f 1,2)

	seqtk subseq ${cdsFile} ${file} > ${prefix}_CDS.fa

done
