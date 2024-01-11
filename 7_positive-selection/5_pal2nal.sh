#!/bin/bash
#this script will create phyllip format alignments for each orthogroup
#the list.txt file contains the prefix for each file <orthogroup#>_1

for i in `cat list.txt`
do

	/data/app/pal2nal.v14/pal2nal.pl ${i}.fa ${i}_CDS.fa -output paml -nomismatch -nogap -codontable 1 > ${i}_pal2nal.fa  2>&1 | tee -a pal2nal_log.txt

done

