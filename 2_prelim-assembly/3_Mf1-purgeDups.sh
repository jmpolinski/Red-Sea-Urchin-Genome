#!/bin/bash

# begin working in /data/prj/urchin/red-urchin-genome/canu_04-2021/

# prepare working directory
mkdir purge_dups-corrected
cd purge_dups-corrected
ln -s ../polca-corrected/mfran.contigs.fasta.PolcaCorrected.fa assembly.fa

# 1. Run minimap2 to align ONT data and generate paf files, then calculate read depth histogram and base-level read depth

/data/app/minimap2/minimap2 -x map-ont -t 8 assembly.fa Mf1_minion_all.fastq | gzip -c - > mf1.paf.gz
/data/app/purge_dups/bin/pbcstat mf1.paf.gz
mv PB.stats ONT.stats 
# changed filename to reflect that working with ONT, not PacBio data
/data/app/purge_dups/bin/calcuts ONT.stat > cutoffs 2>calcults.log

# 2. Split an assembly and do a self-self alignment
/data/app/purge_dups/bin/split_fa assembly.fa > split.assembly.fa
/data/app/minimap2/minimap2 -x asm5 -t 16 -DP split.assembly.fa split.assembly.fa | gzip -c - > split.assembly.self.paf.gz

# 3. Purge haplotigs and overlap
/data/app/purge_dups/bin/purge_dups -2 -T cutoffs -c ONT.base.cov split.assembly.self.paf.gz > dups.bed 2> purge_dups.log

# 4. Get purged primary and haplotig sequences from draft assembly
/data/app/purge_dups/bin/get_seqs dups.bed assembly.fa
mv purged.fa canu_purged-all.fa

