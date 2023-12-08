**Identify Species with good Protein sequences for Orthofinder and CAFE Analysis** *K. Castellano - October 19,2021* _genome file location:_ 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/ _excel sheet:_ Species_for_gain_loss_8Oct2021.xlsx A. Download appropriate protein files from 
available genomes for comparison (see excel sheet)
    1. Check quality with BUSCO _program and version:_ BUSCO v5.1.2 _lineage database:_ metazoa ODBv10 _input:_ protein files and log file (busco_v5.log) 
            GCF_000003605.2_Skow_1.1_protein.faa GCF_001949145.1_Aplanci_OKI-Apl_1.0_genomic.fna GCF_902459465.1_eAstRub1.3_protein.faa 
            GCF_000003815.2_Bfl_VNyyK_protein.faa GCF_011630105.1_Ajaponica_ASM1163010v1_protein.faa 
            GCA_002754855.1_Ajaponicus_seacucumber_ASM275485v1_protein.faa GCF_000224145.3_KH_protein.faa GCF_013122585.1_Sclava_ASM1312258v2_protein.faa
        /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/ _output:_ folder with BUSCO statistics for each protein file 
            GCF_000003605.2_Skow_1.1_protein GCF_001949145.1_Aplanci_OKI-Apl_1.0_genomic GCF_902459465.1_eAstRub1.3_protein GCF_000003815.2_Bfl_VNyyK_protein 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein GCA_002754855.1_Ajaponicus_seacucumber_ASM275485v1_protein GCF_000224145.3_KH_protein 
            GCF_013122585.1_Sclava_ASM1312258v2_protein
        /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/ _script:_ /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/busco_v5.sh *BUSCO 
         data also in excel sheet*
        _NOTES:_ All have really nice completeness scores but also really high duplication rates 2. Test using usearch to cluster to reduce duplication rate - 
    DO NOT USE THIS METHOD
        a. remove line breaks - test on A. japonica protein file ``` awk '/^>/ { print (NR==1 ? "" : RS) $0; next } { printf "%s", $0 } END { printf RS }' 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein.faa > GCF_011630105.1_Ajaponica_ASM1163010v1_protein_nolinebreak.faa ```
        b. cluster *test identity cutoff of 0.9 and 0.95* _program and version:_ usearch v11.0.667_i86linux64 _input:_ 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein_nolinebreak.faa /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica _output:_ 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed.faa (0.9 identity cutoff) 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed_0.95.faa /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica
        c. run BUSCO to assess filtering _input:_ clustered protein files GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed.faa (0.9 identity cutoff) 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed_0.95.faa /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica _output:_ 
            folder with busco summary GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed (0.9 identity cutoff) 
            GCF_011630105.1_Ajaponica_ASM1163010v1_protein_collapsed_0 (0.95 identity cutoff) 
            /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica _script:_ 
            /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica/busco_v5.sh _NOTES:_ Did reduce the duplicated % but also increased 
            fragmentation %. Also concerned about collapsing real duplicates so decided this was not the best method
    3. Test pulling out the longest isoform using the gene feature table - DO NOT USE THIS METHOD *test on A. japonica protein file*
        
        ```
        #1. get longest isoform from gene feature table
            cat GCF_011630105.1_ASM1163010v1_feature_table.txt \
            | awk 'BEGIN{FS="\t";OFS="\t"}($1=="CDS"){print $11,$13,$16,$19}' \ sort -k3,3 -k4,4nr \ awk 'BEGIN{FS="\t";OFS="\t";l=0;g=0}{if($3==g) {if 
            | ($4>=l) \
            {print $0; g=$3; l=$4}} else {print $0; g=$3; l=$4} }' > GCF_011630105.1_Ajaponica_longestIso.txt
        #2. get just the first column with transcript Id
            awk '{print $1}' GCF_011630105.1_Ajaponica_longestIso.txt > GCF_011630105.1_Ajaponica_longestIso_2.txt
        #3. get only the longest isoform sequences
            grep -A 1 -wFf GCF_011630105.1_Ajaponica_longestIso_2.txt GCF_011630105.1_Ajaponica_ASM1163010v1_protein_nolinebreak.faa > 
            GCF_011630105.1_Ajaponica_longestIso.faa grep ">" GCF_011630105.1_Ajaponica_longestIso.faa | wc -l
        #4. remove "-- characters that appear for some reason (checked and the sequences the come after are not effected, still full length when compared to 
        #the original file)
            sed -i 's/--//g' GCF_011630105.1_Ajaponica_longestIso.faa
                #the above command leaves empty lines - so this will remove the empty lines (does not work in a pipe - also sed '/--/d' removes other lines 
                #for some reasons)
            sed -i '/^$/d' GCF_011630105.1_Ajaponica_longestIso.faa
        #5. check to make sure the number of sequences is the same
            grep ">" GCF_011630105.1_Ajaponica_longestIso.faa | wc -l
                #25404
    4. Try gfacs to collapse uniques *pull out the ref seq gff file and genome file from NCBI* *the --unique-genes-only flag which will collapse directly 
        overlapping genes and resolve transcripts created* a. edit files so the names in the genome match the gff file
            ```
            #1. Edit header to match gff file
                #remove all characters after first space
                sed -i 's/\s.*$//' <file>_genomic.fasta
            #A.japonicus
            sed -i 's/\s.*$//' GCA_002754855.1_ASM275485v1_genomic.fna
            #A.rubens
            sed -i 's/\s.*$//' GCF_902459465.1_eAstRub1.3_genomic.fna
                #after gfacs repeat lines but one has no sequence below it - this has happened to me before listed when BUSCO tries to run because it cant run 
                #on repeat headers get lines and line number containing the specificed ID
                grep -n -A 2 "LOC117300036.1" Arubens_genes.fasta.faa 19019:>ID=gene-LOC117300036.1 19020:>ID=gene-LOC117300036.1 
                    19021-MGTWEPLFGRRGGSLMPLPIRKNSLCLQNKEVQTDMQQIDDTHVLFNIFNAATINHIVVFLTGTAAVPEGMGGAIYFSWPSPEGEMVWMFLGFITNEKPSAIFKVVGLKKGSSTNNSFMQSMPVQQPMKTMSQIGISVEPLHVIQHQIPAETTQTSTLTSFSEFSMKMLENFYNYASSF*
                #remove false header
                sed -i '19019d' Arubens_genes.fasta.faa
            #P. minimata
            sed -i 's/\s.*$//' GCF_015706575.1_ASM1570657v1_genomic.fasta
            #A. planci
            sed -i 's/\s.*$//' GCF_001949145.1_OKI-Apl_1.0_genomic.fasta
                #remove duplicate line
                grep -n -A 1 "LOC110983006.2" Aplanci_genes.fasta.faa 29723:>ID=gene-LOC110983006.2 29724:>ID=gene-LOC110983006.2 29725-MGSNQSNTTKVIG sed -i 
                '29723d' Aplanci_genes.fasta.faa
            #P. miniata
                #remove duplicate line
                grep -n -A 1 "LOC119730449.6" Pminiata_genes.fasta.faa 20547:>ID=gene-LOC119730449.6 20548:>ID=gene-LOC119730449.6 
                20549-MLLSSKKPHVCETSSKAFTEKSSPRIHDRV sed -i '20547d' Pminiata_genes.fasta.faa sed -i '29479d' Pminiata_genes.fasta.faa
                #two repeat headers
            #S. kowalevskii
            sed -i 's/\s.*$//' GCF_000003605.2_Skow_1.1_genomic.fasta grep -n -A 1 "LOC110983006.2" GCF_000003605.2_Skow_1.1_genomic.fasta
            #replace / in name
            sed -i 's/\//-/' Skowalevskii_genes.fasta.faa
            #C. intestinalis
            sed -i 's/\s.*$//' GCF_000224145.3_KH_genomic.fasta sed -i 's/\//-/' Cintestinalis_genes.fasta.faa sed -i 's/\s.*$//' 
            GCF_013122585.1_ASM1312258v2_genomic.fasta
            #B. florida
            sed -i 's/\s.*$//' GCF_000003815.2_Bfl_VNyyK_genomic.fasta
                #remove duplicate line
                grep -n -A 1 "gene-LOC118415711.2" Bflorida_genes.fasta.faa sed -i '15243d' Bflorida_genes.fasta.faa
            #S. purpuratus (5.0)
            sed -i 's/\s.*$//' sp5_0_GCF_genomic.fa
            #remove "/" in headers
            sed -i 's/\//-/' genes.fasta.faa
            #L variegatus
            sed -i 's/\s.*$//' GCF_018143015.1_Lvar_3.0_genomic.fna ```
        
        b. run gFACS with unique flag only _input:_ genome file, gff file for each species all species have their only folder in this location: 
            /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes _output:_ summary statistics, log file, filtered protein file, gene table in each of 
            the species folders /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes _script:_ gFACs_uniquesOnly.sh in each of the species folders 
            located here: /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes
        c. run busco on each filtered file (see excel sheet: Species_for_gain_loss_8Oct2021.xlsx) _input:_ filtered protein file in each of the species 
            folders located here: /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes _output:_ summary file in each of the species folders located 
            here: /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes _script:_ busco_v5.sh in each of the species folders located here: 
            /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes
        _NOTES:_ filtering with gFACs barely adjusted the completeness which is good but reduced the completeness. I think this is the best method as it only 
        picks uniques that overlap genomic space.
List of files for each species after filtering for uniques: /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Aplanci/Aplanci_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Arubens/Arubens_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Bflorida/Bflorida_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Cintestinalis/Cintestinalis_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Lpictus/lytpic2.0.all.maker.proteins.LPI.fasta 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Lvariegatus3.0/Lvariegatus_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Pminiata/Pminiata_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Sclava/Sclava_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Skowalevskii/Skowalevskii_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Spurpuratus5.0/Spurpuratus5.0_genes.fasta.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponicus/GCA_002754855.1_Ajaponicus_seacucumber_ASM275485v1_protein.faa 
/data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica_uniques/Ajaponica_uniques_genes.fasta.faa
