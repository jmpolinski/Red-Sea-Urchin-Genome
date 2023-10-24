# Read QC prior to genome assembly

## ONT long-read data

NanoFilt was used to fitler ONT data based on quality and read length. A quality filter of 10 and trimming the first 50 bp was done.  

Pre-filtering read stats:
```
file                format  type    num_seqs         sum_len  min_len  avg_len  max_len
Mf1_minion-1.fastq  FASTQ   DNA    7,362,630  19,126,088,070        6  2,597.7  199,916
Mf1_minion-2.fastq  FASTQ   DNA   12,217,469  23,027,201,378        2  1,884.8  336,028
Mf1_minion-3.fastq  FASTQ   DNA    9,013,169  18,058,471,525        1  2,003.6  192,037
Mf1_minion-4.fastq  FASTQ   DNA   12,634,853  25,656,766,985        2  2,030.6  165,673
```

Post-filtering read stats:
```
file                format  type   num_seqs         sum_len  min_len  avg_len  max_len
Mf1_minion-1_qc.fq  FASTQ   DNA   3,856,097  13,292,045,211    1,000    3,447  195,470
Mf1_minion-2_qc.fq  FASTQ   DNA   5,308,522  15,393,020,463    1,000  2,899.7  162,811
Mf1_minion-3_qc.fq  FASTQ   DNA   3,978,033  12,254,047,311    1,000  3,080.4  191,987
Mf1_minion-4_qc.fq  FASTQ   DNA   2,944,197   9,233,365,295    1,000  3,136.1  165,623
```

A total of 16,086,849 reads totaling 50.17 Gbp passed filtering and proceeded to assembly.  

## Illumina short-read data

Data quality was checked using FastQC (output can be found in folder FastQC).  
Trimmomatic was used to quality trim and filter reads (see Illumina_trimmomatic.sh).  
A total of 543.3M read pairs totaling 157.66 Gbp passed quality filtering and proceeded to assembly. 

