#!/bin/bash
#hyphy absrel


module load hyphy/v2.5.58
#ln -s /data/resources/app_modules/hyphy-2.5.58/res #only need to do this once; make symbolic link to batch files

fileList="*.fa"
treePath="/data/prj/urchin/red-urchin-genome/positive-selection/protein-files-urchinsOnly/OrthoFinder/Results_Sep15/Gene_Trees_edit/"

for file in ${fileList}
do

        prefix=$(echo ${file} | cut -d "_" -f 1)
	hyphy absrel --pvalue 0.05 --alignment ${file} --tree ${treePath}${prefix}_tree.txt --branches All >> ${prefix}_absrel_output.txt
	#will ouput a .json file and the specificed .txt file

done
