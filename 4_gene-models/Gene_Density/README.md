# Prepare files to make a gene density karyotype image for M franciscanus
Analysis Completed by Kate Castellano
Purpose: Look at genome wide gene density

<html>
<head>
</head>

<body>
<ol type="A">
<li><b>Split the genome into 550kb windows and count the number of genes in each window </li> </b>
Multiple window sizes were tried (10 kb, 50kb, 100kb) but a window size of 550kb was picked to match P. lividus paper Figure 1B https://www.cell.com/cell-genomics/pdf/S2666-979X(23)00061-7.pdf)
<ol type="1">
<li><b>Get the length of each chromosome (done previously for synteny - see detailed notes) </b> </li>
    <ul style="list-style-type:none;">
    <li>python script: 1_countSequenceLength.py (do not edit or run this script - I created it as a function that can be easily used. See script to run below)</li>
    <li>command to run:  python3 2_run_countSequenceLength.py (This is the file you will edit with you input and output file names)</li>
    <li>input: genome file: Mfran_genome_FINAL.fa</li>
    <li>output: text file with Scaffold name and length: Mfran_chr_length.txt</li>
    </ul>

<li><b>Edit file for bedtools</b> </li>
    </ul>
<pre>
    <code>
#remove ">" symbol before scaffold names
sed -i 's/>//g' Mfran_chr_length.txt       
#Add a column with "0" value and then reorder columns with awk
sed "s/$/\t0/" Mfran_chr_length.txt | awk -v OFS="\t" '{print $1,$3,$2}' > Mfran_chr_length_forBedtools.txt
#Final output should look like this with Scaffold ID, and then the range (I always do 0 - whatever the length of the chrom is)
HiC_scaffold_1  0       46325628
  </code>
</pre>

<li><b>convert gene annotation file to bed format (using awk) and sort with bedtools</li> </b>
    <ul style="list-style-type:none;">
    <li>input: annotation file: Mfran_braker-FINAL.gtf </li>
    <li>output: Mfran_braker_transcriptsSort.bed</li>
    <li>script: 3_convertAnnotationFile.sh</li>
    </ul>
    
<li><b>Make windows with bedtools make windows, sort with bedtools and count the number of genes within those windows (bedtools map)</li> </b>
    <ul style="list-style-type:none;">
    <li>input: gene annotation file (from Step 3): Mfran_chr_length_sort.txt </li>
    <li>output: sorted windows file: Mfran_genome_FINAL_550kb.windowsSort.bed and Number of genes in each window: Mfran_genecount_550kb.bed </li>
    <li>script: 4_makeWindows_geneDensity.sh </li>
    </ul>

</ul>

<li><b>Map onto chromosomes using RIdeogram </li> </b>
Tutorial: https://cran.r-project.org/web/packages/RIdeogram/vignettes/RIdeogram.html#:~:text=RIdeogram%20is%20a%20R%20package,genome%2Dwide%20data%20on%20idiograms. </br>
    <ul style="list-style-type:none;">
    <li>I do this on my Rstudio so I transfer Mfran_genecount_10kb.bed and Mfran_chr_length_forBedtools_sort.txt to my computer</il>
    <li>See R markdown: MfranciscanusRIdeogram_Gene Density.rmd</il>
    </ul>

</ol>

</body>
</html>

</ol>
