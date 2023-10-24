
# Preliminary assembly of Red Sea Urchin Genome

## Testing assemblers

As there are many genome assembly algorithms available and we were unsure which would perform the best for our data, multiple were tested. Assembly statistics for all tested programs are shown below:  

| Assembler                   | MaSurCA (4.0.3) | CANU (2.1.1)  | Shasta (0.7.0) | HASLR (0.8a1) | Wengan (0.2)  |
| --------------------------- |:---------------:|:-------------:|:--------------:|:-------------:|:-------------:|
| # Scaffolds                 | 14450           | 12202         |9074            | 10796         | 9920          |
| # Contigs                   | 14508           | 12202         | 9074           | 10796         | 9920          |
| Scaffold total (Mbp)        | 993.168         | 1374.350      | 344.408        | 569.982       | 302.378       |
| Contig total (Mbp)          | 993.162         | 1374.350      | 344.408        | 569.982       | 302.378       |
| Percent gaps                | 0.001%          | 0.000%        | 0.000%         | 0.000%        | 0.000%        |
| Scaffold N/L50              | 1692/153.6 KB   | 1638/227.4 KB | 1206/83.9 KB   | 977/160.7 KB  | 1832/49.2 KB  |
| Contig N/L50                | 1705/151.9 KB   | 1638/227.4 KB | 1206/83.7 KB   | 977/160.7 KB  | 1832/49.2 KB  |
| Scaffold N/L90              | 6876/36.6 KB    | 6547/50.7 KB  | 4208/21.8 KB   | 4305/26.6 KB  | 6344/13.4 KB  |
| Contig N/L90                | 6919/36.5 KB    | 6547/50.7 KB  | 4208/21.8 KB   | 4305/26.6 KB  | 6344/13.4 KB  |
| Max scaffold length         | 2.142 MB        | 1.688 MB      | 644.401 KB     | 1.115 MB      | 408.615 KB    |
| Max contig length           | 2.142 MB        | 1.688 MB      | 644.401 KB     | 1.115 MB      | 408.615 KB    |
| Scaffold >50 Kbp            | 5735            | 6595          | 2319           | 2908          | 1797          |
|% genome in scaffolds >50Kbp | 85.05%          | 90.18%        | 71.11%         | 81.01%        | 49.43%        |
| BUSCO (% complete/% single) | 93.6% / 53.1%   | 97.6% / 22.9% | 24.9% / 24.7%  | 79.1% / 78.9% | 32.0% / 30.2% |
  
The CANU assembler was chosen because it had the highest BUSCO score. Only scripts for the CANU assembly are included here, as the other assemblies were discarded.  

## CANU assembly QC

CANU is a long-read only assembler. To correct for errors in ONT long reads that affected the preliminary assembly, POLCA (distributed with MaSurCA v4.0.3) was used. POLCA corrected the following:  
Substitution Errors: 485433  
Insertion/Deletion Errors: 9092765  
Assembly Size: 1366074531  
Consensus Quality: 99.2989  
  
Additionally, the preliminary CANU assembly was much larger than the anticipated genome size of 800 Mbp and the high percentage of duplicate complete BUSCO genes suggested the assembly contained duplicated sequence/haplotigs. A modified version of the [Purge_Dups](https://github.com/dfguan/purge_dups) pipeline was used to remove duplicated regions of the assembly.  

## Post-QC CANU assembly stats:

| Assembler                   | Post-QC CANU assembly |
| --------------------------- |:---------------------:|
| # Scaffolds                 | 4043                  |
| # Contigs                   | 4201                  |
| Scaffold total (Mbp)        | 773.004               |
| Contig total (Mbp)          | 773.000               |
| Percent gaps                | >0.0001%              |
| Scaffold N/L50              | 656/361.978 KB        |
| Contig N/L50                | 659/358.057 KB        |
| Scaffold N/L90              | 2181/95.061 KB        |
| Contig N/L90                | 2237/89.313 KB        |
| Max scaffold length         | 1.688 MB              |
| Max contig length           | 1.688 MB              |
| Scaffold >50 Kbp            | 2811                  |
|% genome in scaffolds >50Kbp | 95.69%                |
| BUSCO (% complete/% single) | 96.6% / 93.9%         |

## Removal of mitochondrial genome:

The *M. franciscanus* mitochondrial genome (NCBI Reference Sequence: [NC_024177.1](https://www.ncbi.nlm.nih.gov/nuccore/NC_024177.1/)) was downloaded and a blastn search was used to idenify the contig within the scaffold that represented the mitochondrial genome. The mitochondrial genome was assembled as a single, full contig which was removed from the assembly.  
The final preliminary genome for Hi-C scaffolding saved to ```/data/prj/urchin/red-urchin-genome/Mfran_genome-v1_no-mt.fa```.  
  
*All assemblies and QC done by Jennifer Polinski.* 
