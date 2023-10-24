# Advanced Repeat Annotation of long-lived Red Sea Urchin Genome </br>
*Analysis completed by Kate Castellano - November 8,2021 </br>
Purpose: A majority of the repeats identified with RepeatModeler are unkown. To better identify diverged and species specific repeats a combined approach with RepeatModeler, TransposonPSI and LTRharvest will be used.
Summary: Repeat analysis was conducted on the newly assembled M. franciscancus genome, S. purpuratus genome (version 5.0, https://www.echinobase.org), L. variegatus genome (version 3.0, https://www.echinobase.org) and L. pictus genome (version 2.0, NCBI). The details are shown for M. franciscanus below but the same method was used for the other sea urchin species. Repeats were annotated with RepeatMasker (v 4.1.0) using a de novo repeat library. The de novo library was made using a combination of RepeatModeler (v 2.0.2), Transposon PSI (v 1.0.0) (https://transposonpsi.sourceforge.net/), and LTRharvest (v1.6.2) to better identify diverged and species-specific repeats. Each program was run individually before combining and clustering (Usearch v 11.0.667), with a minimum sequence match of 80%, to remove redundant sequences that may have been identified in multiple programs.

# Run Repeat Classification Programs
<html>
<head>
</head>

<body>
<ol type="A">
<li><b> Transposon PSI </b></li>
    <ol type="1">
        <li><b> Run Transposon PSI (version: TransposonPSI_08222010.tgz) </b></li>
        <ul style="list-style-type:none;">
        <il>input: red sea urchin genome (unmasked): Mfran_genome_final.fa </li> </br>
        <il>output: Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.gff3 *other files are output but this is the most important one* </li></br>
        <il>script: 01_TransposonPSI.sh </li></br>
        </ul>
        <li><b> Pull out fasta sequences </b></li>
        <il>software:_ Bedtools 2 </li></br>
        <il>input: genome file: Mfran_genome_final.fa; gff from Transposon PSI (step A): Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.gff3 </li></br>
        <il>output: Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.fasta </li></br>
        <il>script: 02_bedtools_getfasta.sh </li></br>
        </ul>
        <li><b> Edit headers </b></li>
        </ul>
        Must remove (-) and (+) from headers because they have meaning in regex and cause problems downstream with repeatMasker
<pre>
    <code>
#remove (-) and replace with nothing, print to a new file
sed 's/(-)//' Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.fasta > Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader.fasta

#remove (+) and replace with nothing, -i means to edit this file
sed -i 's/(+)//' Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.fasta
  </code>
</pre>
</ul>
        <li><b> Remove sequences < 50 bp </b></li>
        <il>input:_ Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader.fasta</li></br>
        <il>output:_ Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader_filter.fasta</li></br>
        <il>script: 03_filterFasta.sh</li></br>
        </ul>
        </ul>
        </ol>
            
<li><b> LTR harvest & Digest </b></li>
    <ol type="1">
        <li><b> create the genome enhanced suffix array </b></li>
        We invoke gt suffixerator with options -tis, -suf,-lcp, -des, -ssp and -sds since LTRharvest needs the corresponding tables
        specify -dna, as we process DNA-sequences
        <ul style="list-style-type:none;">
        <il>input: unmasked genome file: Mfran_genome_final.fa </li></br>
        <il>output: index files: Mfran_genome_final.des, .esq, .lcp, .llv, .md5, .prj, .sds, .ssp, .suf </li></br>
        <il>script: 01_LTRharvest_mk_db.sh </li> </br>
        </ul>
        <li><b> Run LTR harvest </b></li>
        <ul style="list-style-type:none;">
        <il>input: index files: Mfran_genome_final.des, .esq, .lcp, .llv, .md5, .prj, .sds, .ssp, .suf </li></br>
        <il>output: fasta file: Mfran_genome_LTRharvest.fasta; gff3 file: Mfran_genome_LTRharvest.gff3; log file: LTRharvest.log </li></br>
        <il>script: 02_LTRharvest.sh </li> </br>
        </ul>
        <li><b> Run LTR digest to remove false positive hits and LTRs without domain hits </b></li>
            <ol type="a">
                <li><b> Download Pfam retrotransposon files (http://pfam.xfam.org/) </b></li>
            this only needs to be done once when you make the database</br>
            keyword search "Retrotransposon"</br>
            Download 21 with pfam entries and convert it to HMMER2 format (which ltrdigest needs)
            </ul>
<pre>
    <code>
wget http://pfam.xfam.org/family/PF03732/hmm #Retrotrans_gag (PF03732)
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF03732.hmm
rm hmm

wget http://pfam.xfam.org/family/PF14529/hmm	#Exo_endo_phos_2	Endonuclease-reverse transcriptase	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF14529.hmm
rm hmm

wget http://pfam.xfam.org/family/PF00077/hmm	#RVP	Retroviral aspartyl protease	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF00077.hmm
rm hmm

wget http://pfam.xfam.org/family/PF00078/hmm	#RVT_1	Reverse transcriptase (RNA-dependent DNA polymerase
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF00078.hmm
rm hmm

wget http://pfam.xfam.org/family/PF03078/hmm	#ATHILA	ATHILA ORF-1 family		
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF03078.hmm
rm hmm

wget http://pfam.xfam.org/family/PF03732/hmm	#Retrotrans_gag	Retrotransposon gag protein	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF03732.hmm
rm hmm

wget http://pfam.xfam.org/family/PF05380/hmm	#Peptidase_A17	Pao retrotransposon peptidase
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF05380.hmm
rm hmm

wget http://pfam.xfam.org/family/PF07727/hmm	#RVT_2	Reverse transcriptase (RNA-dependent DNA polymerase)
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF07727.hmm
rm hmm

wget http://pfam.xfam.org/family/PF07999/hmm	#RHSP	Retrotransposon hot spot protein
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF07999.hmm
rm hmm		

wget http://pfam.xfam.org/family/PF14244/hmm	#Retrotran_gag_3	gag-polypeptide of LTR copia-type
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF14244.hmm
rm hmm

wget http://pfam.xfam.org/family/PF00026/hmm	#Asp	Eukaryotic aspartyl protease		
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF00026.hmm
rm hmm	

wget http://pfam.xfam.org/family/PF08284/hmm	#RVP_2	Retroviral aspartyl protease
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF08284.hmm
rm hmm

wget http://pfam.xfam.org/family/PF13456/hmm	#RVT_3	Reverse transcriptase-like		
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF13456.hmm
rm hmm

wget http://pfam.xfam.org/family/PF14223/hmm	#Retrotran_gag_2	gag-polypeptide of LTR copia-type	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF14223.hmm
rm hmm	

wget http://pfam.xfam.org/family/PF18701/hmm	#DUF5641	Family of unknown function (DUF5641)	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF18701.hmm
rm hmm	

wget http://pfam.xfam.org/family/PF03716/hmm	#WCCH	WCCH motif
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF03716.hmm
rm hmm

wget http://pfam.xfam.org/family/PF08333/hmm	#DUF1725	Protein of unknown function (DUF1725)	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF08333.hmm
rm hmm	

wget http://pfam.xfam.org/family/PF12382/hmm	#Peptidase_A2E	Retrotransposon peptidase	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF12382.hmm
rm hmm

wget http://pfam.xfam.org/family/PF18162/hmm	#Arc_C	Arc C-lobe	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF18162.hmm
rm hmm

wget http://pfam.xfam.org/family/PF18769/hmm	#APOBEC1	APOBEC1	
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF18769.hmm
rm hmm

wget http://pfam.xfam.org/family/PF19687/hmm   #MARF1 LOTUS domain
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF19687.hmm
rm hmm

wget http://pfam.xfam.org/family/PF17241/hmm   #Retrotran_gag_4	Ty5 Gag N-terminal region
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF17241.hmm
rm hmm

wget http://pfam.xfam.org/family/PF00077/hmm	#Retroviral aspartyl protease
/data/app/hmmer-3.3/bin/hmmconvert -2 hmm > PF00077.hmm
rm hmm
  </code>
</pre>

<li><b>  Download GyDB HMM files (http://gydb.org/index.php/Collection_HMM) </b></li>
this only needs to be done once when you make the database </br>
file to download: https://gydb.org/extensions/Collection/collection/db/GyDB_collection.zip </br>
</ul>
<pre>
    <code>
unzip GyDB_collection.zip
#move .hmm files to be in the same location as pfam files
mv GyDB_collection/profiles/*.hmm .
#keep folder which contains the protein sequences and alignments
  </code>
</pre>

<li><b> sort gff from LTRharvest </b></li>
<pre>
    <code>
/data/app/genometools-1.6.2/bin/gt gff3 -sort Mfran_genome_LTRharvest.gff3 > Mfran_genome_LTRharvest_sort.gff3
  </code>
</pre>

<li><b> Run LTRdigest </b></li>
<ul style="list-style-type:none;">
<il></il>input: hmm protein files (step b): ~/*.hmm, gff3 from LTRharvest (Step 2): Mfran_genome_LTRharvest_sort.gff3 </il> </br>
<il>output: Mfran_genome_LTRharvestDigest_tabout.csv, Mfran_genome_LTRharvestDigest.gff3, Mfran_genome_LTRharvestDigest_complete.fas (and many other files but those are the main ones) </il> </br>
<il>script: 03_LTRdigest.sh </il>
</ul>

</ul>
</il>
</ol>
</ol>


<li><b> Combine all repeat runs and cluster </b></li>
<pre>
    <code>
#LTR harvest output
cat Mfran_genome_LTRharvestDigest_complete.fas > Mfran_RepeatLibCombined.fa
#TransposonPSI output
cat Mfran_genome_final.fa.TPSI.allHits.chains.bestPerLocus.editHeader_filter.fasta >> Mfran_RepeatLibCombined.fa
#RepeatModeler output (run by Jen Polinski)
cat mfran-families.fa >>  Mfran_RepeatLibCombined.fa
  </code>
</pre>

<ol type="1">
        <li><b> cluster with usearch (version v11.0.667)  </b></li>
                <ul style="list-style-type:none;">
        <li>input: combined repeat file: Mfran_RepeatLibCombined.fa</li> </br>
        <li>output: Mfran_RepeatLibCombined_clustered.fa</li></br>
        <li>script: 01_usearch.sh</li>
        </ul>
                
<pre>
    <code>
            #Output statistics:
            Seqs  41913 (41.9k)
            Clusters  24242 (24.2k)
            Max size  171
            Avg size  1.8
            Min size  1
            Singletons  20915 (20.9k), 49.9% of seqs, 86.3% of clusters
            Max mem  449Mb
                Time  05:20
            Throughput  131.0 seqs/sec.
  </code>
</pre>

<li><b> Classify de novo repeat library using RepeatModeler's RepeatClassifier function (RepeatModeler v 2.0.2a) </b></li>
                <ul style="list-style-type:none;">
        <li>input: combined repeat library: Mfran_RepeatLibCombined_clustered.fa </li> </br>
        <li>output:_ Mfran_RepeatLibCombined_clustered.fa.classified</li> </br>
        <il>script: 02_RepeatClassifier.sh</li> </br>
        </ul>
</ol>

</body>
</html>

</ol>

# Repeat mask the *M. franciscanus* genome
<html>
<head>
</head>

<body>
<ol type="A">
<li><b> RepeatMasker (version 4.1.2-p1) </b></li>
    <ul style="list-style-type:none;">       
<li>input: unmasked genome, combined, clustered and classified repeat library: Mfran_RepeatLibCombined_clustered.fa.classified </li>
<li>output:
        masked genome: Mfran_genome_final.fa.masked </br>
        summary table: Mfran_genome_final.fa.tbl  </br>
        gff file: Mfran_genome_final.fa.out.gff  </br> </li>
<li>script: RepeatMasker.sh </li>
    </ul>
</ol>

</body>
</html>

</ol>
