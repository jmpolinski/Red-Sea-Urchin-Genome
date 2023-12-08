#!/bin/bash
#busco version 5.1.2 - check genomes for orthofinder and cafe analysis with the red sea urchin
#October 19, 2021 - KCastellano

#fileList="GCA_002754855.1_Ajaponicus_seacucumber_ASM275485v1_protein.faa"
#fileList="GCF_000003605.2_Skow_1.1_protein.faa GCF_001949145.1_Aplanci_OKI-Apl_1.0_genomic.fna GCF_902459465.1_eAstRub1.3_protein.faa GCF_000003815.2_Bfl_VNyyK_protein.faa GCF_011630105.1_Ajaponica_ASM1163010v1_protein.faa GCA_002754855.1_Ajaponicus_seacucumber_ASM275485v1_protein.faa GCF_000224145.3_KH_protein.faa GCF_013122585.1_Sclava_ASM1312258v2_protein.faa"
#fileList="GCF_001949145.1_OKI-Aplanci_1.0_protein.faa"
#fileList=" GCF_015706575.1_Pminiata_ASM1570657v1_protein.faa"
#fileList="GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed.faa"
#fileList="GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed_0.95.faa"
#fileList="GCF_902459465.1_eAstRub1.3_protein_collapse0.90.faa GCF_902459465.1_eAstRub1.3_protein_collapse0.95.faa"

fileList="GCF_011630105.1_Ajaponica_longestIso.faa"

lineage="/data/app/busco-5.1.2/lineages/metazoa_odb10/"

for file in ${fileList}
do

	prefix=$(echo ${file} | cut -d "." -f 1,2)
	#busco -i ${file} -l ${lineage} -o ${prefix} -m proteins  2>&1 | tee -a busco_v5.log
        busco -i ${file} -l ${lineage} -o ${prefix} -m proteins  2>&1 | tee -a busco_v5_collapsedProteins.log

done


