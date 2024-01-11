#!/bin/bash
#get results for branches under selection according to hyphy absrel


fileList="*output.txt"

#outside of loop add file header
echo "Adaptive branch site random effects likelihood test Results - Urchins Only - Hyphy abSREL all branches" > hyphy_absrel_Results.txt
echo "K. Castellano - 2024 January 4" >> hyphy_absrel_Results.txt
echo "------------------------------------------------------------------------------------------------------" >> hyphy_absrel_Results.txt

for file in ${fileList}
do
        prefix=$(echo ${file} | cut -d "_" -f 1)
	echo ${prefix} >> hyphy_absrel_Results.txt #print orthogroup ID
	#this command below will print all lines after the string "### Adaptive branch site random effects likelihood test" which contain the branches under selection
	sed -e '1,/### Adaptive branch site random effects likelihood test/d' ${file} >> hyphy_absrel_Results.txt
	echo "" >> hyphy_absrel_Results.txt #add empty line after each orthogroup in the output file to help make it clearer to read

done

sed -i '/tested./{N;s/\n$//}' hyphy_absrel_Results.txt #remove the empty line between the number of branches under selection and the lines with the p-value of the branches under selection; just makes it easier to read and see what data goes with which orthogroup
