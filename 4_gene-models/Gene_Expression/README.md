# TPM Gene Expression Analysis
SRA data from BioProjects PRJNA531463 (*M. franciscanus* early developmental transcriptome) and PRJNA562282 (Age-related gene expression in tissues of the long-lived red sea urchin) were used in this analysis.

**PRJNA531463 - combine files for same stage and trim with Trimmomatic:**
```
cat SRR8866330_1.fastq SRR8866329_1.fastq SRR8866327_1.fastq >> 8-16cells_R1.fastq && rm SRR8866330_1.fastq SRR8866329_1.fastq SRR8866327_1.fastq && \
cat SRR8866330_2.fastq SRR8866329_2.fastq SRR8866327_2.fastq >> 8-16cells_R2.fastq && rm SRR8866330_2.fastq SRR8866329_2.fastq SRR8866327_2.fastq && \
cat SRR8866333_1.fastq SRR8866320_1.fastq SRR8866319_1.fastq >> blastula_R1.fastq && rm SRR8866333_1.fastq SRR8866320_1.fastq SRR8866319_1.fastq && \
cat SRR8866333_2.fastq SRR8866320_2.fastq SRR8866319_2.fastq >> blastula_R2.fastq && rm SRR8866333_2.fastq SRR8866320_2.fastq SRR8866319_2.fastq && \
cat SRR8866328_1.fastq SRR8866326_1.fastq SRR8866325_1.fastq >> eggs_R1.fastq && rm SRR8866328_1.fastq SRR8866326_1.fastq SRR8866325_1.fastq && \
cat SRR8866328_2.fastq SRR8866326_2.fastq SRR8866325_2.fastq >> eggs_R2.fastq && rm SRR8866328_2.fastq SRR8866326_2.fastq SRR8866325_2.fastq && \
cat SRR8866324_1.fastq SRR8866318_1.fastq SRR8866317_1.fastq >> gastrula_R1.fastq && rm SRR8866324_1.fastq SRR8866318_1.fastq SRR8866317_1.fastq && \
cat SRR8866324_2.fastq SRR8866318_2.fastq SRR8866317_2.fastq >> gastrula_R2.fastq && rm SRR8866324_2.fastq SRR8866318_2.fastq SRR8866317_2.fastq && \
cat SRR8866334_1.fastq SRR8866332_1.fastq SRR8866331_1.fastq >> morula_R1.fastq && rm SRR8866334_1.fastq SRR8866332_1.fastq SRR8866331_1.fastq && \
cat SRR8866334_2.fastq SRR8866332_2.fastq SRR8866331_2.fastq >> morula_R2.fastq && rm SRR8866334_2.fastq SRR8866332_2.fastq SRR8866331_2.fastq && \
cat SRR8866335_1.fastq SRR8866316_1.fastq SRR8866315_1.fastq >> pluteus_R1.fastq && rm SRR8866335_1.fastq SRR8866316_1.fastq SRR8866315_1.fastq && \
cat SRR8866335_2.fastq SRR8866316_2.fastq SRR8866315_2.fastq >> pluteus_R2.fastq && rm SRR8866335_2.fastq SRR8866316_2.fastq SRR8866315_2.fastq && \
cat SRR8866323_1.fastq SRR8866322_1.fastq SRR8866321_1.fastq >> prism_R1.fastq && rm SRR8866323_1.fastq SRR8866322_1.fastq SRR8866321_1.fastq && \
cat SRR8866323_2.fastq SRR8866322_2.fastq SRR8866321_2.fastq >> prism_R2.fastq && rm SRR8866323_2.fastq SRR8866322_2.fastq SRR8866321_2.fastq 

ls *R1* > files

for i in `cat files`; do java -jar /data/app/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 12 -phred33 ${i}_R1.fastq ${i}_R2.fastq ${i}_R1-qc.fastq ${i}_R1-unpaired.fq ${i}_R2-qc.fastq ${i}_R2-unpaired.fq ILLUMINACLIP:/data/app/Trimmomatic-0.38/adapters/TruSeq3-PE-2.fa:3:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:50; done
```
  
**PRJNA562282  - combine files for same stage (previously trimmed):**
```
# alm - young
cat OtA0807_R1_paired.fq.gz OtA0809_R1_paired.fq.gz OtA0811_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/ALM-young_R1.fastq.gz && \
cat OtA0807_R2_paired.fq.gz OtA0809_R2_paired.fq.gz OtA0811_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/ALM-young_R2.fastq.gz
# alm - old
cat OtA0808_R1_paired.fq.gz OtA0810_R1_paired.fq.gz OtA0812_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/ALM-old_R1.fastq.gz && \
cat OtA0808_R2_paired.fq.gz OtA0810_R2_paired.fq.gz OtA0812_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/ALM-old_R2.fastq.gz
# esophagus - young
cat OtA0813_R1_paired.fq.gz OtA0815_R1_paired.fq.gz OtA0817_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/Esophagus-young_R1.fastq.gz && \
cat OtA0813_R2_paired.fq.gz OtA0815_R2_paired.fq.gz OtA0817_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/Esophagus-young_R2.fastq.gz
# esophagus - old
cat OtA0814_R1_paired.fq.gz OtA0816_R1_paired.fq.gz OtA0818_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/Esophagus-old_R1.fastq.gz && \
cat OtA0814_R2_paired.fq.gz OtA0816_R2_paired.fq.gz OtA0818_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/Esophagus-old_R2.fastq.gz
# radial nerve - young
cat Ot7679_R1_paired.fq.gz Ot7681_R1_paired.fq.gz OtA0819_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/RadialNerve-young_R1.fastq.gz && \
cat Ot7679_R2_paired.fq.gz Ot7681_R2_paired.fq.gz OtA0819_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/RadialNerve-young_R2.fastq.gz
# radial nerve - old
cat OtA2889_R1_paired.fq.gz OtA2890_R1_paired.fq.gz OtA2888_R1_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/RadialNerve-old_R1.fastq.gz && \
cat OtA2889_R2_paired.fq.gz OtA2890_R2_paired.fq.gz OtA2888_R2_paired.fq.gz > ../../red-urchin-genome/TPM_gene-expression/RadialNerve-old_R2.fastq.gz

cd ../../red-urchin-genome/TPM_gene-expression/
gunzip *gz
```

**Prepare CDS GFF files for STAR mapping:**
```
grep "CDS" ../MFR_braker_v3-sorted.gtf > Mfran-CDS_v3.gff
```

**Create STAR genome index**
```
/data/app/STAR/bin/Linux_x86_64/STAR --runMode genomeGenerate --genomeDir ./genome-2023-03_STAR --genomeFastaFiles MFR_genome_v2-renamed.fa --sjdbGTFfile Mfran-CDS_v3.gff --sjdbOverhang 100 --runThreadN 12 --sjdbGTFfeatureExon CDS --limitGenomeGenerateRAM 37000000000
```

**Map reads to genome with STAR**
```
ls *R1.fastq > fastqs
sed -i -e 's/_R1.fastq//g' fastqs

for i in `cat fastqs`; do \
/data/app/STAR/bin/Linux_x86_64/STAR --runThreadN 12 --genomeDir ./genome-2023-03_STAR --outSAMtype BAM SortedByCoordinate --readFilesIn ${i}_R1.fastq ${i}_R2.fastq && \
mv Aligned.sortedByCoord.out.bam ${i}_Aligned.sortedByCoord.out.bam; done
```

**Generate feature counts and convert to TPMs**  
R scripts below are located in this directory  
```
R
source("/data/prj/urchin/red-urchin-genome/TPM_gene-expression/bam-to-TPM_paired.R")
```
