#!/bin/bash
#get results for branches under selection according to hyphy absrel


fileList="*output.txt"

#outside of loop add file header
echo "Hyphy MEME sites under episodic selection" > hyphy_meme_Results.txt
echo "K. Castellano - 2024 January 8" >> hyphy_meme_Results.txt
echo "------------------------------" >> hyphy_meme_Results.txt

for file in ${fileList}
do
        prefix=$(echo ${file} | cut -d "_" -f 1)
	echo ${prefix} >> hyphy_meme_Results.txt #print orthogroup ID
	#this command below will print all lines after the string "###  For partition" which contain the sites under selection
	sed -e '1,/### For partition/d' ${file} >> hyphy_meme_Results.txt
	echo "" >> hyphy_meme_Results.txt #add empty line after each orthogroup in the output file to help make it clearer to read

done
