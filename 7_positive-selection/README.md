# Positive Selection Analysis using Hyphy abSREL and MEME </br>
Analysis completed by Kate Castellano - Dec 2023 - January 2024 </br>
<b>Purpose:</b> Identify genes under positive selection in long- vs short-lived sea urchin species </br>
<b>Summary:</b> Positive selection analysis was conducted on the genomic coding regions of four sea urchin species with different lifespans (long-lived M. franciscanus and S. purpuratus, and short-lived L. variegatus and L. pictus) with B. floridae as the outgroup. OrthoFinder (v2.5.4) was run with the “-M msa” flag to include multiple sequence alignments. Orthogroups were filtered to keep only those containing all species. Pal2nal (v 14) was used to obtain codon alignments in phyllip format. Phylogenetic analysis of codons was completed using Hyphy abSREL (v2.5.58). Hyphy MEME (v2.5.58) will be used to identify sites under selection.

# Filter and format files for analysis
<html>
<head>
</head>

<body>
<ol type="A">
<li><b>Retrieve and filter Protein and associated CDS files for each species</b> </li>
<ol type="1">
<li><b> M. fran did not need to be filtered (see gene annotations README for details on filtering)</br></b> </li>

<li><b> Strongylocentrotus purpuratus [purple sea urchin] </b> </li>
    <ul style="list-style-type:circle;">
    <li>NCBI genome name and accession (Spur_5.0, GCF_000002235.5) </li>
    <li>Download via FTP:  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/235/GCF_000002235.5_Spur_5.0/ </li>
    <li>GCF_000002235.5_Spur_5.0_cds_from_genomic.fna </li>
    <li>GCF_000002235.5_Spur_5.0_genomic.gff </li>
    <li>GCF_000002235.5_Spur_5.0_protein.faa </li>
    <li>sex: male </li>
    </ul>
</br>
    <ol type="a">
    <li><b>Run Busco on original protein file to check quality (especially duplication rate) </b> </il>
        <b>database:</b> metazoa_odb10 </br>
        <b>input:</b> GCF_000002235.5_Spur_5.0_protein.faa </br>
        <b>output:</b> Spurpuratus_BUSCOprot </br>
        <b>script:</b> busco.sh </br>
 
<li><b>Filter GFF to get only the longest isoform (AGAT/v1.2.0) </b> </il>
    <b>input:</b> GCF_018143015.1_Lvar_3.0_genomic.gff </br>
    <b>output:</b> Spurpuratus_AGATfilt.gff </br>
    <b>script:</b> 1_AGAT_filt.sh </br>

<li><b>Get protein and cds sequences </b> </il>
<pre>
    <code>
#1. get list of headers from the AGAT filtered GFF file
awk '{print $9}' Spurpuratus_AGATfilt.gff | grep "cds" | sed 's/;.*//g' | sed 's/.*cds-//g' | sort | uniq > Spurpuratus_AGAT_filtGene_IDs.txt
#2. edit headers of cds file (did not need to do for protein file)
 #remove everything after the first space
sed -i 's/ .*//g' GCF_000002235.5_Spur_5.0_cds_from_genomic.fna
#realized there is an underscore after each XP #, remove that by removing everything after and including the second occurance of an "_"
sed -i 's/^\(.*_.*_.*_.*\)_.*/\1/' GCF_000002235.5_Spur_5.0_cds_from_genomic.fna
sed -i 's/.*cds_/>/g' GCF_000002235.5_Spur_5.0_cds_from_genomic.fna
#3. edit headers of the protein file
sed -i 's/ .*//g' GCF_000002235.5_Spur_5.0_protein.faa
  </code>
</pre>
</br>  
<li><b>pull out sequences (seqkit/v2.5.1) </b> </il>
        <b>input:</b> Spurpuratus_AGAT_filtGene_IDs.txt GCF_000002235.5_Spur_5.0_cds_from_genomic.fna and GCF_000002235.5_Spur_5.0_protein.faa </br>
        <b>output:</b> Spurpuratus_AGATfilt_protein.faa and Spurpuratus_AGATfilt_cds.fa </br>
        <b>script:</b> seqkit_GetSeqs.sh </br>
<li><b>add species names to headers  </b> </il>
<pre>
    <code>
sed -i 's/>/>Spurpuratus_/g' Spurpuratus_AGATfilt_cds.fa </br>
sed -i 's/>/>Spurpuratus_/g' Spurpuratus_AGATfilt_protein.faa </br>
  </code>
</pre>
</br> 
<li><b>Run Busco on original protein file to check quality (especially duplication rate) </b> </il>
    <b>database:</b> metazoa_odb10 </br>
    <b>input:</b> Spurpuratus_AGATfilt_protein.faa  </br>
    <b>output:</b> Spurpuratus_AGATfilt_BUSCOprot/ </br>
    <b>script:</b> busco.sh </br>

</ul>
</il>
</ol>

<li><b> Lytechinus pictus </b> </li>
    <ul style="list-style-type:circle;">
    <li>given the protein and CDS file from paper authors so just edit fasta headers and file name </li>
    </ul>
    <ol type="a">
    <li><b> protein file - remove extra header info we dont need </li> </b>
<pre>
    <code>
sed -i 's/ .*//g' lytpic2.0.all.maker.proteins.LPI.fasta
#rename protein file
mv lytpic2.0.all.maker.proteins.LPI.fasta Lpictus_proteinFiltered.faa
  </code>
</pre> 
   <li><b> CDS file - remove extra header info we dont need </li> </b>
<pre>
    <code>
sed -i 's/ .*//g' lytpic2.0.all.maker.transcripts.LPI.fasta
#rename CDS file
mv lytpic2.0.all.maker.transcripts.LPI.fasta Lpictus_CDSFiltered.faa
  </code>
</pre> 
   <li><b> add species name to header </li> </b>
<pre>
    <code>
sed -i 's/>/>Lpictus_/g' Lpictus_CDSFiltered.fa
sed -i 's/>/>Lpictus_/g' Lpictus_proteinFiltered.faa
  </code>
</pre>
</ul>
</il>
</ol>

<li><b> Lytechinus variegatus [green or variegated sea urchin]  </b> </li>
    <ul style="list-style-type:circle;">
    <li>NCBI genome name and accession (Lvar_3.0, GCA_018143015.1) </li>
    <li>Download via FTP:  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/018/143/015/GCF_018143015.1_Lvar_3.0/ </li>
    <li> GCF_018143015.1_Lvar_3.0_cds_from_genomic.fna </li>
    <li>GCF_018143015.1_Lvar_3.0_genomic.gff </li>
    <li>GCF_018143015.1_Lvar_3.0_protein.faa </li>
    <li>sex: female </li>
    </ul>
</br>
    <ol type="a">
    <li><b>Run Busco on original protein file to check quality (especially duplication rate) </b> </il> </br>
    <b>database:</b> metazoa_odb10 </br>
    <b>input:</b> GCF_018143015.1_Lvar_3.0_protein.faa </br>
    <b>output:</b> Lvariegatus_BUSCOprot </br>
    <b>script:</b> busco.sh </br>
 
<li><b> Filter GFF to get only the longest isoform (AGAT/v1.2.0) </b> </li>
    <b>input:</b> GCF_018143015.1_Lvar_3.0_genomic.gff </br>
    <b>output:</b> Lvariegatus_AGATfilt.gff </br>
    <b>script:</b> 1_AGAT_filt.sh </br>

<li><b> Get protein and cds sequences </b> </li>
<pre>
    <code>
#1. get list of headers from the AGAT filtered GFF file
awk '{print $9}' Lvariegatus_AGATfilt.gff | grep "cds" | sed 's/;.*//g' | sed 's/.*cds-//g' | sort | uniq > Lvariegatus_AGAT_filtGene_IDs.txt
#2. edit headers of cds file (did not need to do for protein file)
sed -i 's/ .*//g' GCF_018143015.1_Lvar_3.0_cds_from_genomic.fna #remove everything after the first space
sed -i 's/^\(.*_.*_.*_.*\)_.*/\1/' GCF_018143015.1_Lvar_3.0_cds_from_genomic.fna #realized there is an underscore after each XP #, remove that by removing everything after and including the second occurance of an "_"
sed -i 's/.*cds_/>/g' GCF_018143015.1_Lvar_3.0_cds_from_genomic.fna
#3. edit headers of the protein file
sed -i 's/ .*//g' GCF_018143015.1_Lvar_3.0_protein.faa
    </code>
</pre>
</br> 
<li><b> pull out sequences (seqkit/v2.5.1) </b> </li>
        <b>input:</b> Lvariegatus_AGAT_filtGene_IDs.txt GCF_018143015.1_Lvar_3.0_cds_from_genomic.fna and GCF_018143015.1_Lvar_3.0_protein.faa </br>
        <b>output:</b> Lvariegatus_AGATfilt_protein.faa and Aplanci_AGATfilt_cds.fa </br>
        <b>script:</b> seqkit_GetSeqs.sh </br>
<li><b> add species names to headers </b> </li>
<pre>
    <code>
        sed -i 's/>/>Lvariegatus_/g' Lvariegatus_AGATfilt_cds.fa
        sed -i 's/>/>Lvariegatus_/g' Lvariegatus_AGATfilt_protein.faa
  </code>
</pre> 
</br>
<li><b> Run Busco on original protein file to check quality (especially duplication rate) </b> </li>
    <b>database:</b> metazoa_odb10 </br>
    <b>input:</b> Lvariegatus_AGATfilt_protein.faa  </br>
    <b>output:</b> Lvariegatus_AGATfilt_BUSCOprot/ </br>
    <b>script:</b> busco.sh </br>

</ul>
</il>
</ol>

<li><b> Branchiostoma floridae [Florida lancelet]</b> </li>
    <ul style="list-style-type:circle;">
    <li> NCBI genome name and accession (Bfl_VNyyK, GCA_000003815.2) </li>
    <li> Download via FTP: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/815/GCF_000003815.2_Bfl_VNyyK/ </li>
    <li> GCF_000003815.2_Bfl_VNyyK_cds_from_genomic.fna </li>
    <li> GCF_000003815.2_Bfl_VNyyK_protein.faa </li>
    <li> GCF_000003815.2_Bfl_VNyyK_genomic.gff </li>
    <li> sex: male </li>
    </ul>
</br>
    <ol type="a">
    <li><b> Run Busco on original protein file to check quality (especially duplication rate) </b> </li>
        <b>database:</b> metazoa_odb10 </br>
        <b>input:</b> GCF_000003815.2_Bfl_VNyyK_protein.faa </br>
        <b>output:</b> Bfloridae_BUSCOprot/ </br>
        <b>script:</b> busco.sh </br>
    </br>
<li><b> Filter GFF to get only the longest isoform (AGAT/v1.2.0) </b> </li>
        <b>input:</b> GCF_902459465.1_eAstRub1.3_genomic.gff </br>
        <b>output:</b> Bfloridae_AGATfilt.gff </br>
        <b>script:</b> 1_AGAT_filt.sh </br>

<li><b> Get protein and cds sequences </li> </b>
<pre>
    <code>
#1. get list of headers from the AGAT filtered GFF file
    awk '{print $9}' Bfloridae_AGATfilt.gff | grep "cds" | sed 's/;.*//g' | sed 's/.*cds-//g' | sort | uniq > Bfloridae_AGAT_filtGene_IDs.txt
#2. edit headers of cds file (did not need to do for protein file)
    sed -i 's/ .*//g' GCF_000003815.2_Bfl_VNyyK_cds_from_genomic.fna #remove everything after the first space
    sed -i 's/^\(.*_.*_.*_.*\)_.*/\1/' GCF_000003815.2_Bfl_VNyyK_cds_from_genomic.fna #realized there is an underscore after each XP #, remove that by removing everything after and including the second occurance of an "_"
    sed -i 's/.*cds_/>/g' GCF_000003815.2_Bfl_VNyyK_cds_from_genomic.fna
#3. edit headers of the protein file
    sed -i 's/ .*//g' GCF_000003815.2_Bfl_VNyyK_protein.faa
  </code>
</pre>
</br>      
<li><b> pull out sequences (seqkit/v2.5.1) </b> </li>
        <b>input:</b> Bfloridae_AGAT_filtGene_IDs.txt GCF_000003815.2_Bfl_VNyyK_cds_from_genomic.fna and GCF_000003815.2_Bfl_VNyyK_protein.faa </br>
        <b>output:</b> Bfloridae_AGATfilt_protein.faa and Bfloridae_AGATfilt_cds.fa </br>
        <b>script:</b> seqkit_GetSeqs.sh </br>
<pre>
    <code>
#add species names to headers
        sed -i 's/>/>Bfloridae_/g' Bfloridae_AGATfilt_cds.fa
        sed -i 's/>/>Bfloridae_/g' Bfloridae_AGATfilt_protein.faa
  </code>
</pre>
</br>
<li><b> Run Busco on original protein file to check quality (especially duplication rate) </b> </li>
        <b>database:</b> metazoa_odb10 </br> 
        <b>input:</b> Bfloridae_AGATfilt_protein.faa </br>
        <b>output:</b> Bfloridae_AGATfilt_BUSCOprot/ </br>
        <b>script:</b> busco.sh </br>
</ul>
</il>
</ol>
</ol>
</ol>

# Run Orthofinder to identify orthologues 
<html>
<head>
</head>

<ol type="A">
<li><b> Run orthofinder </b></li>
    <ul style="list-style-type:circle;">
    <li>add the "-M msa" flag to get the multiple sequence alignments </li>
    <li>you can re-run/re-start a previous run but could not re-run from Jen's run, kept getting errors so started the run over using the -M msa flag to get the multiple sequence alignments</li>
    </ul>
    <b>input:</b> protein files for each species </br>
    <b>output:</b> folder: Orthofinder/Results_Oct2023 </br>
    <b>script:</b> OrthoFinder_MSA.sh </br>
</ul>
</il>
</br>
<li><b>Get orthogroups that have all 5 species in it </li> </b>
        <b>input:</b> multiple sequence alignment folder (~/positive-selection/protein-files-urchinsOnly/OrthoFinder/Results_Sep15/MultipleSequenceAlignments)</li></br>
        <b>output:</b> folder with orthogroups only containing all 5 species (~/positive-selection/protein-files-urchinsOnly/OrthoFinder/Results_Sep15/MultipleSequenceAlignments_AllSpecies) </br>
        <b>script:</b> 3_get_fasta_w_min_number.pl</br>
</ul>
</il>
</br>
<li><b>Get CDS files for each orthogroup</li> </b>
        <b>input:</b> *_headers.fa for each orthogroup from all species; combined cds file from all species: AllSpecies.faa </br>
        <b>output:</b> *_CDS.fa for each orthogroup with all species </br>
        <b>Script:</b> 4_getCDS.sh </br>
</ul>
</il>
</ol>

# Run Pal2Nal to get codon alignments
<html>
<head>
</head>
<ol type="A">
<li><b> Get codon alignments in phylip format using pal2nal (v14) </li> </b>
    <ul style="list-style-type:circle;">
    <li>Make a file with the list of alignment files and cds files</li>
    </ul>
<pre>
    <code>
ls *_1_CDS.fa > list.txt
#edit the file to get just <orthogroup>_1
sed -i 's/_CDS.*//g' list.txt
  </code>
</pre>
</br>
<li> run pal2nal to get phyllip alignments for each orthogroup</li>
    <b>input:</b> protein <orthogroup#>_1.fa and CDS <orthogroup#>_1_CDS.fa </br>
    <b>output:</b> phyllip format CDS alignment for each orthogroup <orthogroup#>_1_pal2nal.fa </br>
    <b>script:</b> 5_pal2nal.sh </br>
</br>
<li> Edit pal2nal alignment files so they are in the proper format for Hyphy</li>
    #This script will loop through files and 1) remove the first line which contains nucleotide count 2) add ">" before each sequence header </br>
    <b>script:</b> 6_editFiles.sh </br>
</ul>
</il>
</ol>

# Positive Selection Analysis with Hyphy aBSREL
<html>
<head>
</head>
<ol type="A">
<li><b> Run Hyphy aBSREL</li> </b>
    <b>input:</b> <orthogroup>_1_pal2nal_edit.fa and tree file from Orthofinder: <orthogroup>_tree.txt </br>
    <b>parameters:</b> --pvalue 0.05 --branches All </br>
    <b>output:</b> <orthogroup>_1_pal2nal_edit.fa.ABSREL.json file and <orthogroup>_absrel_output.txt with summary results for each orthogroup </br>
    <b>script:</b> 7_hyphy_absrel.sh </br>
    </br>
<li><b> Combine results from each orthogroup into one file </li> </b>
    <ul style="list-style-type:circle;">
    <li>Compile the results (the *output.txt file) from each orthogroup in one file </li>
        <b>script:</b> 8_absrel_getResults.sh </br>
    </ul>
    <li>Manually reformat the combined output file from the last step to make it easier to parse the results</li>
<pre>
    <code>
#Remove header (top 3 lines) | put everything on one line | create a new line before each "OG" string
sed -e '1,3d' hyphy_absrel_Results.txt | awk 'BEGIN { ORS = " " } { print }' | sed 's/OG/\nOG/g' > hyphy_absrel_Results_editedTable.txt

#Remove extra text and symbols
sed -i 's/Likelihood ratio test for episodic diversifying positive selection at Holm-Bonferroni corrected _p =   0.0500_ found \**/\t/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/\** branches under selection among \**/\t/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/\* tested. /\t/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/*//g' hyphy_absrel_Results_editedTable.txt

#make tab delimited
sed -i 's/  N/\tN/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/  S/\tS/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/  B/\tS/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/  L/\tL/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/  M/\tM/g' hyphy_absrel_Results_editedTable.txt
sed -i 's/, /\t/g' hyphy_absrel_Results_editedTable.txt

#remove empty first line and add header
sed -ie '1d' hyphy_absrel_Results_editedTable.txt
sed -i 1i"orthgroup\tBranches_Under_Selection\tTotal_Branches_Tested\tSpecies_Branch_Under_Selection\tp-value" hyphy_absrel_Results_editedTable.txt
    </code>
</pre>
</ul>
    <li>Parse results to find Orthgroups where there are signals of positive selection only on the long-lived branches (M.fran only or both Mfran and S.purp)</li></br>
<pre>
    <code>
sed -n '/Mfran/p' hyphy_absrel_Results_editedTable.txt
#485 (these lines include all Mfran so some have a combination of short- and long-lived under selection as well)

sed -n '/Spurp/p' hyphy_absrel_Results_editedTable.txt | wc -l
#212
  </code>
</pre>
</ul>

<li>Find rows with only one branch under selection in M.fran</li></br>
<pre>
    <code>
 grep "Mfran" hyphy_absrel_Results_editedTable.txt | awk '$2 == 1 {print}' > hyphy_absrel_Results_MfranONLY.txt
 #237
  </code>
</pre>
</ul>
</il>
</ol>

# Identify sites under selection with Hyphy MEME
<html>
<head>
</head>
<ol type="A">
<li><b> Run Hyphy MEME on only the orthogroups under selection selected above (M. fran only and both M.fran and S. purp)</li> </b>
    <b>input:</b> <orthogroup>_1_pal2nal_edit.fa and tree file from Orthofinder: <orthogroup>_tree.txt </br>
    <b>output:</b> <orthogroup>_1_pal2nal_edit.fa.MEME.json file and <orthogroup>_meme_output.txt with summary results for each orthogroup </br>
    <b>script:</b> 9_meme_hyphy.sh</br>
    </br>
<li><b> Combine results from each orthogroup into one file </li> </b>
    <ul style="list-style-type:circle;">
    <li>Compile the results (the <orthogroup>_meme_output.txt files) from each orthogroup in one file </li>
        <b>script:</b> 10_meme_getResults.sh </br>
</ul>
</il>
</ol>