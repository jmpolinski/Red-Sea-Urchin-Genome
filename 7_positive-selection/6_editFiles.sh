#!/bin/bash
#edit pal2nal alignment files for hyphy

#copy pal2nal files to this location
#cp /data/prj/urchin/red-urchin-genome/positive-selection/protein-files-urchinsOnly/OrthoFinder/Results_Sep15/MultipleSequenceAlignments_AllSpecies/pal2nal/*.fa .


fileList="*.fa"

for file in ${fileList}
do

	prefix=$(echo ${file} | cut -d "." -f 1) 
	sed '1d' ${file} > ${prefix}_edit.fa #remove first line which contains the number of aligned nucleotides

	#add > in front of each header to turn it into a fasta file
	sed -i 's/B/>B/' ${prefix}_edit.fa
	sed -i 's/M/>M/' ${prefix}_edit.fa
	sed -i 's/L/>L/' ${prefix}_edit.fa
	sed -i 's/S/>S/' ${prefix}_edit.fa
	
	rm ${file} #remove original pal2nal files we copied over to this location

done
