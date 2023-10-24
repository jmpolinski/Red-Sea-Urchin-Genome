# Synteny analysis of long- vs short-lived sea urchins
Analysis completed by Kate Castellano
Purpose: Look for chromosomal rearrangments in the long- versus short-lived sea urchins to identify novel rearrangments associated with longevity/negligible senescence
Summary: Pairwise synteny comparisons were inferred between M. franciscancus and S. purpuratus, M. franciscancus and L. variegatus, M. franciscancus and L. pictus, and L. variegatus and L. pictus using MCscan. S. purpuratus version 5.0 gene annotations were obtained from Echinobase (https://www.echinobase.org), version 3.0 of the L. variegatus gene annotations obtained from Echinobase and version 2.0 of the L. pictus gene annotations obtained from NCBI. LAST (v 1445) was used for genome wide alignments of coding regions, and filtering of tandem duplications and weak hits. Linkage clustering into syntenic blocks and visualization was performed with the MCscan python workflow (https://github.com/tanghaibao/jcvi/wiki/MCscan-(Python-version)). Microsynteny visualization of the Hox cluster was also completed through MCscan modules.

# *Mesocentrotus franciscanus* versus *Lytechinus variegatus*
<b>MCscan (python version)</b> </br>
program to download: https://github.com/tanghaibao/jcvi </br>
MCscan manual/workflow: https://github.com/tanghaibao/jcvi/wiki/MCscan-%28Python-version%29#dependencies </br>

## Reformat files for MCscan
<html>
<head>
</head>

<body>
<ol type="A">
<li><b>L variegatus</b> (https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/018/143/015/GCF_018143015.1_Lvar_3.0/) </li>
    <ol type="1">
        <li><b>reformat gff file with MCscan </b> </li>
               input: GCF_018143015.1_Lvar_3.0_genomic.gff </br>
               output: Lvariegatus.bed </br>
               script: convert_gff2bed_MCscan.sh </br>
        <li><b>reformat CDS file with MCscan</b></li>
                input: GCF_018143015.1_Lvar_3.0_rna_from_genomic.fna </br>
                output: Lvariegatus.cds </br>
                script: reformatCDS_MCscan.sh </br>
        <li><b>edit headers of the CDS file to match the column 4 of the bed file (otherwise you will get errors when you run MCscan) </b> </li> </br>
    </ol>
<pre>
    <code>
##Manually Remove noncoding, miscRNA and rRNA sequences
awk '/^>/ {P=index($0,"ncRNA")==0} {if(P) print} ' Lvariegatus.cds > Lvariegatus_test.cds
awk '/^>/ {P=index($0,"miscrna")==0} {if(P) print} ' Lvariegatus_test.cds > Lvariegatus_test2.cds
awk '/^>/ {P=index($0,"rRNA")==0} {if(P) print} ' Lvariegatus_test2.cds > Lvariegatus_test3.cds
rm Lvariegatus.cds
mv Lvariegatus_test3.cds Lvariegatus.cds
rm Lvariegatus_test.cds
rm Lvariegatus_test2.cds
rmLvariegatus_test3.cds
<br>
##edit header to contain only the transcript ID
    #remove everything from the beginning of the header up to transcript_id=; add the ">" back
        sed -i 's/.*transcript_id=/>/g' Lvariegatus.cds
    #remove everything after "]"
        sed -i 's/].*//g' Lvariegatus.cds
  </code>
</pre>

<li><b>M. franciscanus </b> </li>
    <ol type="1">
        <li><b>convert gtf to gff file </b> </li>
            input: Mfran_braker-CORRECTED.gtf </br>
            output: Mfran_braker-CORRECTED.gff and gff2gtf.log </br>
            script: gff2gtf.sh </br>
        <li><b>reformat gff file with MCscan  </b> </li>
            input: Mfran_braker-CORRECTED.gtf </br>
            output: Mfranciscanus.gff </br>
            script: convert_gff2bed_MCscan.sh </br>
        <li><b>reformat CDS file with MCscan  </b> </li>
            input: Mfran_braker-transcripts_FINAL.fa </br>
            output: Mfranciscanus.cds </br>
            script: reformatCDS_MCscan.sh </br>

</ol>

</body>
</html>

</ol>

## Run MCscan pairewise synteny analysis and visualize - *M. franciscanus* vs *L. variegatus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.cds, Mfranciscanus.bed, Lvariegatus.cds, Lvariegatus.bed </li>
<li>output: </br> </li>
        Lvariegatus datbases: Lvariegatus.des, Lvariegatus.sds, Lvariegatus.suf, Lvariegatus.bck, Lvariegatus.cds, Lvariegatus.prj, Lvariegatus.ssp, Lvariegatus.tis </br> 
        final output: Mfranciscanus.Lvariegatus.last, Mfranciscanus.Lvariegatus.lifted.anchors, Mfranciscanus.Lvariegatus.anchors, Mfranciscanus.Lvariegatus.last.filtered, Mfranciscanus.Lvariegatus.pdf </br>
        log file: 1_MCscan_synteny_MfranvsLvar.log </br>
<li>script:_ 1_MCscan_synteny_MfranvsLvar.sh </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.Lvariegatus.anchors </li>
<li>output: 2_MCscan_depth_MfranvsLvar.log </li>
<pre>
    <code>
Genome Mfranciscanus depths:
Depth 0: 3,148 of 22,306 (14.1%)
Depth 1: 15,494 of 22,306 (69.5%)
Depth 2: 3,367 of 22,306 (15.1%)
Depth 3: 247 of 22,306 (1.1%)
Depth 4: 46 of 22,306 (0.2%)
Depth 5: 4 of 22,306 (0.0%)
Genome Lvariegatus depths:
Depth 0: 5,355 of 33,669 (15.9%)
Depth 1: 27,330 of 33,669 (81.2%)
Depth 2: 971 of 33,669 (2.9%)
Depth 3: 13 of 33,669 (0.0%)
Mfranciscanus vs Lvariegatus syntenic depths
1:2 pattern
  </code>
</pre>
    
<li>script: 2_MCscan_depth_MfranvsLvar.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
            <ol type="a">
                <li>count length of M. franciscanus chromosomes and order largest to smallest </li>
                    <ul style="list-style-type:none;">
                        <li>input: Mfran_genome_final.fa </li>
                        <li>output: Mfran_chr_length.txt </li>
                        <li>script: countSequenceLength.py and run_countSequenceLength.py </li>
                    </ul>
               <li>sort and remove ">" charater </li>
<pre>
    <code>
sort -n Mfran_chr_length.txt | sed 's/>//g' > Mfran_chr_length_sort.txt
rm Mfran_chr_length.txt
  </code>
</pre>
                <li>add ordered IDs to seqid file </li>
                </ol>
<pre>
    <code>
awk '{print $1}' Mfran_chr_length_sort.txt | uniq | paste -d, -s >> seqids
awk '{print $1}' Lvariegatus.bed | uniq | paste -d, -s >> seqids
  </code>
</pre>

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Mfranciscanus.Lvariegatus.anchors </li>
        <li>output: Mfranciscanus.Lvariegatus.anchors.simple and Mfranciscanus.Lvariegatus.anchors.new </li>
        <li>script: MCscan_mkSimpleFile_MfranvsLvar.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Mfranciscanus, top, Mfranciscanus.bed
.4,     .1,    .8,       0, #4dac26, Lvariegatus, top, Lvariegatus.bed
# edges
 e, 0, 1, Mfranciscanus.Lvariegatus.anchors.simple
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: MfranvsLvar_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_MfranvsLvar.sh </li>
    </ul>    
    
</ol>

</body>
</html>

</ol>

## Hox Clusters - *M. franciscanus* vs *L. variegatus*
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Get blocks for the hox cluster </b>
    <ul style="list-style-type:none;">
        <li>get the line numbers for the first and last hox gene
<pre>
    <code>
#get the line numbers for the first and last hox gene
grep -n "Mfran_g4479" Mfranciscanus.Lvariegatus.i1.blocks
10306:Mfran_g4479       XM_041602940.1
grep -n "Mfran_g4498" Mfranciscanus.Lvariegatus.i1.blocks
10315:Mfran_g4498       XM_041604911.1
    </br>
#pull out the lines of the hox cluster (+ 2 genes on either end)
sed -n '10304,10317p' Mfranciscanus.Lvariegatus.i1.blocks > Mfran_hox.blocks
  </code>
</pre>

<li>Edit layout file</li>
        hoxblock.layout
        
<li>Run microsynteny analysis </li>
        <ul style="list-style-type:none;">
            <li>input: Mfran_hox.blocks, hoxblock.layout, Mfranciscanus_Lvariegatus.bed </li>
            <li>output: Mfran_hox.pdf </li>
            <li>script: 6_MCscan_microsynteny_chr_MfranvsLvar.sh </li> 
        </ul>

</ol>

</body>
</html>
</ol>

# *Mesocentrotus franciscanus* versus *Lytechinus pictus*
*M.franciscanus* files are the same files edited above

## Reformat *L. pictus* files for MCscan
<html>
<head>
</head>

<body>
<ol type="A">
<li><b>L pictus</b> https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/018/143/015/GCF_018143015.1_Lpictus_3.0/  </li>
    <ol type="1">
        <li><b>reformat gff file with MCscan </b> </li>
               input:  </br>
               output: Lpictus.bed </br>
               script: convert_gff2bed_MCscan.sh </br>
        <li><b>reformat CDS file with MCscan</b></li>
                input: lytpic2.0.all.maker.transcripts.LPI.fasta </br>
                output: Lpictus.cds </br>
                script: reformatCDS_MCscan.sh </br>
        <li><b>edit headers of the CDS file to match the column 4 of the bed file (otherwise you will get errors when you run MCscan) </b> </li> </br>
    </ol>
<pre>
    <code>
##Manually edit header - remove everything from the beginning of the header up to transcript_id=; add the ">" back
    sed -i 's/.*transcript_id=/>/g' Lpictus.cds
  </code>
</pre>

</ol>

</body>
</html>

</ol>

## Run MCscan pairewise synteny analysis and visualize - *M. franciscanus* vs *L. pictus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.cds, Mfranciscanus.bed, Lpictus.cds, Lpictus.bed </li>
<li>output: </br> </li>
        Lpictus datbases: Lpictus.des, Lpictus.sds, Lpictus.suf, Lpictus.bck, Lpictus.cds, Lpictus.prj, Lpictus.ssp, Lpictus.tis </br> 
        final output: Mfranciscanus.Lpictus.last, Mfranciscanus.Lpictus.lifted.anchors, Mfranciscanus.Lpictus.anchors, Mfranciscanus.Lpictus.last.filtered, Mfranciscanus.Lpictus.pdf </br>
        log file: 1_MCscan_synteny_MfranvsLpictus.log </br>
<li>script: 1_MCscan_synteny_MfranvsLpictus.sh </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.Lpictus.anchors </li>
<li>output: 2_MCscan_depth_MfranvsLpictus.log </li>
<pre>
    <code>
Genome Mfranciscanus depths:
Depth 0: 3,515 of 22,306 (15.8%)
Depth 1: 17,828 of 22,306 (79.9%)
Depth 2: 930 of 22,306 (4.2%)
Depth 3: 33 of 22,306 (0.1%)
        Genome Lpictus depths:
Depth 0: 5,737 of 28,631 (20.0%)
Depth 1: 21,633 of 28,631 (75.6%)
Depth 2: 1,227 of 28,631 (4.3%)
Depth 3: 34 of 28,631 (0.1%)
Mfranciscanus vs Lpictus syntenic depths
1:1 pattern
  </code>
</pre>
    
<li>script: 2_MCscan_depth_MfranvsLpictus.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
            <ol type="a">
                <li>count length of L. pictus chromosomes and order largest to smallest </li>
                    <ul style="list-style-type:none;">
                        <li>input: GCA_015342785.1_UCSD_Lpic_2.0_genomic_CHRONLY_editHeader.fna </li>
                        <li>output: Lpictus_chr_length.txt </li>
                        <li>script: countSequenceLength.py and run_countSequenceLength.py </li>
                    </ul>
               <li>sort and remove ">" charater </li>
<pre>
    <code>
sort -k 2 -nr Lpictus_chr_length.txt | sed 's/>//g' > Lpictus_chr_length_sort.txt
rm Lpictus_chr_length.txt
  </code>
</pre>
                <li>add ordered IDs to seqid file </li>
                </ol>
<pre>
    <code>
awk '{print $1}' Mfran_chr_length_sort.txt | uniq | paste -d, -s > seqids
awk '{print $1}' Lpictus_chr_length_sort.txt | uniq | paste -d, -s >> seqids
  </code>
</pre>

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Mfranciscanus.Lpictus.anchors </li>
        <li>output: Mfranciscanus.Lpictus.anchors.simple and Mfranciscanus.Lpictus.anchors.new </li>
        <li>script: MCscan_mkSimpleFile_MfranvsLpictus.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Mfranciscanus, top, Mfranciscanus.bed
.4,     .1,    .8,       0, #4dac26, Lpictus, top, Lpictus.bed
# edges
 e, 0, 1, Mfranciscanus.Lpictus.anchors.simple
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: MfranvsLpictus_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_MfranvsLpictus.sh </li>
    </ul>    
    
</ol>

</body>
</html>

</ol>

# *Mesocentrotus franciscanus* versus *Strongylocentrotus purpuratus*
*M.franciscanus* files are the same files edited above

## Reformat *S. purpuratus* files for MCscan
<html>
<head>
</head>

<body>
<ol type="A">
<li><b>S. purpuratus</b>  </li>
    <ol type="1">
        <li><b>reformat gff file with MCscan </b> </li>
               input:  sp5_0_GCF_top21chr.gff3 </br>
               output: Spurp.bed </br>
               script: convert_gff2bed_MCscan.sh </br>
        <li><b>reformat CDS file with MCscan</b></li>
                input:  sp5_0_GCF_CDS.fa </br>
                output: Spurp.cds </br>
                script: reformatCDS_MCscan.sh </br>
        <li><b>edit headers of the CDS file to match the column 4 of the bed file (otherwise you will get errors when you run MCscan) </b> </li> </br>
    </ol>
<pre>
    <code>
##Manually edit header - remove everything from the beginning of the header up to transcript_id=; add the ">" back
    sed -i 's/.*transcript_id=/>/g' Spurp.cds
  </code>
</pre>

</ol>

</body>
</html>

</ol>

## Run MCscan pairewise synteny analysis and visualize - *M. franciscanus* vs *s. Purpuratus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.cds, Mfranciscanus.bed, Spurp.cds, Spurp.bed </li>
<li>output: </br> </li>
        Spurp datbases: Mfranciscanus.des, Mfranciscanus.sds, Mfranciscanus.suf, Mfranciscanus.bck, Mfranciscanus.cds, Mfranciscanus.prj, Mfranciscanus.ssp, Mfranciscanus.tis </br> 
        final output: Mfranciscanus.Spurp.last, Mfranciscanus.Spurp.lifted.anchors, Mfranciscanus.Spurp.anchors, Mfranciscanus.Spurp.last.filtered, Mfranciscanus.Spurp.pdf </br>
        log file: 1_MCscan_synteny_MfranvsSpurp.log </br>
<li>script: 1_MCscan_synteny_MfranvsSpurp.sh </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Mfranciscanus.Spurp.anchors </li>
<li>output: 2_MCscan_depth_MfranvsSpurp.log </li>
<pre>
    <code>
Genome Mfranciscanus depths:
Death 0: 747 of 22,306 (3.3%)
Death 1: 20,811 of 22,306 (93.3%)
Death 2: 737 of 22,306 (3.3%)
Death 3: 11 of 22,306 (0.0%)
Genome Spurp depths:
Death 0: 2,015 of 29,585 (6.8%)
Death 1: 27,486 of 29,585 (92.9%)
Death 2: 84 of 29,585 (0.3%)
Mfranciscanus vs Spurp syntenic depths
1:1 pattern        
  </code>
</pre>
    
<li>script: 2_MCscan_depth_MfranvsSpurp.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
            <ol type="a">
                <li>count length of S. purp chromosomes and order largest to smallest </li>
                    <ul style="list-style-type:none;">
                        <li>input:  </li>
                        <li>output: Spurp_chr_length.txt </li>
                        <li>script: countSequenceLength.py and run_countSequenceLength.py </li>
                    </ul>
               <li>sort and remove ">" charater </li>
<pre>
    <code>
sort -k 2 -nr Spurp_chr_length.txt | sed 's/>//g' > Spurp_chr_length_sort.txt
rm Spurp_chr_length.txt
  </code>
</pre>
                <li>add ordered IDs to seqid file </li>
                </ol>
<pre>
    <code>
awk '{print $1}' Mfran_chr_length_sort.txt | uniq | paste -d, -s > seqids
awk '{print $1}' Spurp_chr_length_sort.txt | uniq | paste -d, -s >> seqids
  </code>
</pre>

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Mfranciscanus.Spurp.anchors </li>
        <li>output: Mfranciscanus.Spurp.anchors.simple and Mfranciscanus.Spurp.anchors.new </li>
        <li>script: MCscan_mkSimpleFile_MfranvsSpurp.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Mfranciscanus, top, Mfranciscanus.bed
.4,     .1,    .8,       0, #4dac26, Spurp, top, Spurp.bed
# edges
 e, 0, 1, Mfranciscanus.Spurp.anchors.simple
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: MfranvsSpurp_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_MfranvsSpurp.sh </li>
    </ul>    
    
</ol>

</body>
</html>

</ol>

# *Lytechinus pictus* versus *Lytechinus variegatus*
No reformating is required since this has been completed for both species above

## Run MCscan pairewise synteny analysis and visualize - *L. variegatus* vs *L. pictus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Lvariegatus.cds, Lvariegatus.bed, Lpictus.cds, Lpictus.bed </li>
<li>output: </br> </li>
        Lpictus datbases: Lpictus.des, Lpictus.sds, Lpictus.suf, Lpictus.bck, Lpictus.cds, Lpictus.prj, Lpictus.ssp, Lpictus.tis </br>
        final output: Lvariegatus.Lpictus.last, Lvariegatus.Lpictus.lifted.anchors, Lvariegatus.Lpictus.anchors, Mfranciscanus.Lpictus.last.filtered, Mfranciscanus.Lpictus.pdf </br>
        log file: 1_MCscan_synteny_LvarvsLpictus.log</br>
<li>script: 1_MCscan_synteny_LvarvsLpictus.log </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Lvariegatus.Lpictus.anchors </li>
<li>output: 2_MCscan_depth_LvarvsLpictus.log </li>
<pre>
    <code>
Genome Lvariegatus depths:
Depth 0: 1,577 of 33,669 (4.7%)
Depth 1: 31,863 of 33,669 (94.6%)
Depth 2: 209 of 33,669 (0.6%)
Depth 3: 20 of 33,669 (0.1%)
Genome Lpictus depths:
Depth 0: 1,809 of 28,631 (6.3%)
Depth 1: 23,516 of 28,631 (82.1%)
Depth 2: 3,267 of 28,631 (11.4%)
Depth 3: 39 of 28,631 (0.1%)
Lvariegatus vs Lpictus syntenic depths
2:1 pattern
  </code>
</pre>
    
<li>script: 2_MCscan_depth_LvarvsLpictus.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
        already made in previous comparisons so copied from previous analyses

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Lvariegatus.Lpictus.anchors </li>
        <li>output: Lvariegatus.Lpictus.anchors.simple and Lvariegatus.Lpictus.anchors.new </li>
        <li>script: 3_MCscan_mkSimpleFile_MfranvsLpictus.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Lvariegatus, top, Lvariegatus.bed
.4,     .1,    .8,       0, #4dac26, Lpictus, top, Lpictus.bed
# edges
e, 0, 1, Lvariegatus.Lpictus.anchors.simple
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: LvarvsLpictus_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_LvarvsLpictus.sh </li>
    </ul>    
    
</ol>

</body>
</html>

</ol>

# *Strongylocentrotus purpuratus* versus *Lytechinus variegatus*
No reformating is required since this has been completed for both species above

## Run MCscan pairewise synteny analysis and visualize - *S. purpuratus* vs *L. variegatus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Lvariegatus.cds, Lvariegatus.bed, Spurp.cds, Spurp.bed </li>
<li>output: </br> </li>
        Lvariegatus datbases: Lvariegatus.des, Lvariegatus.sds, Lvariegatus.suf, Lvariegatus.bck, Lvariegatus.cds, Lvariegatus.prj, Lvariegatus.ssp, Lvariegatus.tis </br>
        final output: Spurp.Lvariegatus.last, Spurp.Lvariegatus.lifted.anchors, Spurp.Lvariegatus.anchors, Spurp.Lvariegatus.last.filtered, Spurp.Lvariegatus.pdf </br>
        log file: 1_MCscan_synteny_SpurpvsLvar.log </br>
<li>script: 1_MCscan_synteny_SpurpvsLvar.sh </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Spurp.Lvariegatus.anchors </li>
<li>output: 2_MCscan_depth_SpurpvsLvar.log </li>
<pre>
    <code>
Genome Spurp depths:
Depth 0: 5,186 of 29,585 (17.5%)
Depth 1: 19,627 of 29,585 (66.3%)
Depth 2: 4,384 of 29,585 (14.8%)
Depth 3: 308 of 29,585 (1.0%)
Depth 4: 80 of 29,585 (0.3%)
Genome Lvariegatus depths:
Depth 0: 5,037 of 33,669 (15.0%)
Depth 1: 26,363 of 33,669 (78.3%)
Depth 2: 2,120 of 33,669 (6.3%)
Depth 3: 149 of 33,669 (0.4%)
Spurp vs Lvariegatus syntenic depths
1:2 pattern
        
  </code>
</pre>
    
<li>script: 2_MCscan_depth_SpurpvsLvar.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
        already made in previous comparisons so copied from previous analyses

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Spurp.Lvariegatus.anchors </li>
        <li>output: Spurp.Lvariegatus.anchors.simple and Spurp.Lvariegatus.anchors.new </li>
        <li>script: 3_MCscan_mkSimpleFile_SpurpvsLVar.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Spurpuratus, top, Spurp.bed
.4,     .1,    .8,       0, #4dac26, Lvariegatus, bottom, Lvariegatus.bed
# edges
e, 0, 1, Spurp.Lvariegatus.anchors.simp
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: SpurpvsLvar_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_SpurpvsLvar.sh </li>
    </ul>    
    
</ol>

</body>
</html>

</ol>

# *Strongylocentrotus purpuratus* versus *Lytechinus pictus*
No reformating is required since this has been completed for both species above

## Run MCscan pairewise synteny analysis and visualize - *S. purpuratus* vs *L. pictus* </b></li>
<html>
<head>
</head>
    
<body>
<ol type="A">
<li><b>Run MCscan </b> </br>
This calls LAST to do the comparison, filter the LAST output to remove tandem duplications and weak hits. </br>
A single linkage clustering is performed on the LAST output to cluster anchors into synteny blocks. </br>
At the end of the run, you'll see the summary statistics of the synteny blocks.</br>
</br>
<ul style="list-style-type:none;">
<li>input: Lpictus.cds, Lpictus.bed, Spurp.cds, Spurp.bed </li>
<li>output: </br> </li>
        Lpictus datbases: Lpictus.des, Lpictus.sds, Lpictus.suf, Lpictus.bck, Lpictus.cds, Lpictus.prj, Lpictus.ssp, Lpictus.tis </br>
        final output: Spurp.Lpictus.last, Spurp.Lpictus.lifted.anchors, Spurp.Lpictus.anchors, Spurp.Lpictus.last.filtered, Spurp.Lpictus.pdf </br>
        log file: 1_MCscan_synteny_SpurpvsLvar.log </br>
<li>script: 1_MCscan_synteny_SpurpvsLvar.sh </br> </li>
</ul>

<li><b>Analyze if synteny is 1:1 </b> </br>
<ul style="list-style-type:none;">
<li>input: Spurp.Lpictus.anchors </li>
<li>output:  Spurp.Lpictus.anchors </li>
<pre>
    <code>
Genome Spurp depths:
Depth 0: 5,186 of 29,585 (17.5%)
Depth 1: 19,627 of 29,585 (66.3%)
Depth 2: 4,384 of 29,585 (14.8%)
Depth 3: 308 of 29,585 (1.0%)
Depth 4: 80 of 29,585 (0.3%)
Genome Lpictus depths:
Depth 0: 5,037 of 33,669 (15.0%)
Depth 1: 26,363 of 33,669 (78.3%)
Depth 2: 2,120 of 33,669 (6.3%)
Depth 3: 149 of 33,669 (0.4%)
Spurp vs Lpictus syntenic depths
1:2 pattern
        
  </code>
</pre>
    
<li>script: 2_MCscan_depth_SpurpvsLvar.sh </li>
</ul>

<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
        already made in previous comparisons so copied from previous analyses

<li><b> Create the simple file </b> </br>
    <ul style="list-style-type:none;">
        <li>input: Spurp.Lpictus.anchors </li>
        <li>output: Spurp.Lpictus.anchors.simple and Spurp.Lpictus.anchors.new </li>
        <li>script: 3_MCscan_mkSimpleFile_SpurpvsLVar.sh </li>
    </ul>
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.6,     .1,    .8,       0, #f1b6da, Spurpuratus, top, Spurp.bed
.4,     .1,    .8,       0, #4dac26, Lpictus, bottom, Lpictus.bed
# edges
e, 0, 1, Spurp.Lpictus.anchors.simp
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
    <ul style="list-style-type:none;">
        <li>input: seqids, layout </li>
        <li>output: SpurpvsLvar_karyotype.pdf </li>
        <li>script: 4_MCscan_macrosynteny_SpurpvsLvar.sh </li>
    </ul>    

</ol>

</body>
</html>

</ol>

# Create karyotype image containg all four species, *Strongylocentrotus purpuratus*, *Mesocentrotus franciscanus*, *Lytechinus pictus*, and *Lytechinus variegatus*

This is still only a pairwise comparison but the goal is to visualize all four species together.
The files from each of the following comparisons were used and came from analyses described above:
<ul style="list-style-type:none;">
    <li> <i>Strongylocentrotus purpuratus</i> versus <i>Mesocentrotus franciscanus</i> </li>
    <li> <i>Mesocentrotus franciscanus</i> versus <i>Lytechinus pictus</i> </li>
    <li> <i>Lytechinus pictus</i> versus <i>Lytechinus variegatus</i> </li>
</ul>

## Run MCscan pairewise synteny analysis and visualize - *S. purpuratus* vs *L. pictus* </b></li>
<html>
<head>
</head>

<body>
<ol type="A">
<li><b>Visualize Macrosynteny </b> </br> </li>
    <ol type="1">
        <li><b> create the seqID file </b> </li>
        this file should have a list separated by columns of chromosome IDs with each species on their own line
        already made in previous comparisons so copied from previous analyses
        
<li><b> Create the simple file </b> </br> </il>
These files were already created:
<ul style="list-style-type:none;">
    <li>Mfranciscanus.Spurp.anchors.simple</li>
    <li>Mfranciscanus.Lpictus.anchors.simple</li>
    <li>Lvariegatus.Lpictus.anchors.simple</li>
</ul>
          
<li><b> create the layout file (see below) </b> </br>
<pre>
    <code>
# y, xstart, xend, rotation, color, label, va,  bed
.7,     .1,     .8,     0,      , Spurp, top, Spurp.bed
.5,     .1,     .8,     0,      , Mfran, top, Mfranciscanus.bed
.3,     .1,     .8,     0,      , Lpictus, bottom, Lpictus.bed
.1,     .1,     .8,     0,      , Lvar, bottom, Lvariegatus.bed
# edges
e, 0, 1, Mfranciscanus.Spurp.anchors.simple
e, 1, 2, Mfranciscanus.Lpictus.anchors.simple
e, 2, 3, Lvariegatus.Lpictus.anchors.simple
    </code>
</pre>

<li><b> Run macrosynteny analysis  </b> </br>
<ul style="list-style-type:none;">
    <li>input: seqids, layout </li>
    <li>output: Spurp_Mfran_Lpictus_Lvar_karyotype </li>
    <li>script: 4_MCscan_macrosynteny_Spurp_Mfran_Lpictus_Lvar </li>
</ul>    
      
</ol>
      
</body>
</html>
      
</ol>

      