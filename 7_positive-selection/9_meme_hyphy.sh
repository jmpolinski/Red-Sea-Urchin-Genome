#!/bin/bash
#run hyphy MEME on orthogroups that showed signatures of positive selection using hyphy absrel to identify sites under selection
#K Castellano January 2024

module load hyphy/v2.5.58

treePath="/data/prj/urchin/red-urchin-genome/positive-selection/protein-files-urchinsOnly/OrthoFinder/Results_Sep15/Gene_Trees_edit/"

for i in `cat meme_list.txt`
do

	hyphy meme --alignment ${i}_1_pal2nal_edit.fa --tree ${treePath}${i}_tree.txt >> ${i}_meme_output.txt

done
