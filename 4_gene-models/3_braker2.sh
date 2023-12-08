#!/bin/bash

############ Ab initio gene prediction with BRAKER2 (v2.1.6) ############

# Prepare working directory 
ln -s /data/prj/urchin/red-urchin-genome/repeat-analysis/Mfran_genome_final.fa.masked Mfran_genome_softmasked.fa 
ln -s /data/prj/urchin/red-urchin-genome/transcriptome/mfran_all-rnaseq.bam .

# set up environment
export PATH=/data/app/BRAKER-2.1.6/scripts/:/data/app/BRAKER-2.1.6:/data/app/augustus-3.4.0/bin/:/data/app/augustus-3.4.0/scripts/:$PATH && \
export GENEMARK_PATH=/data/app/geneMark-ES/ && \
export AUGUSTUS_CONFIG_PATH=/data/app/augustus-3.4.0/config/  && \
export AUGUSTUS_SCRIPTS_PATH=/data/app/augustus-3.4.0/scripts/ && \
export AUGUSTUS_BIN_PATH=/data/app/augustus-3.4.0/bin/ && \
export BAMTOOLS_PATH=/data/app/bamtools/bin/ && \
export PYTHON3_PATH=/usr/bin/ && \
export DIAMOND_PATH=/data/app/Diamond/ && \
export PROTHINT_PATH=/data/app/ProtHint/bin && \
export CDBTOOLS_PATH=/data/app/cdbfasta && \
export GUSHR_PATH=/data/app/GUSHR/

# Run BRAKER (preliminary run)
braker.pl --genome=Mfran-genome_softmasked.fa --bam=mfran_all-rnaseq.bam --etmode --softmasking --cores=16 \
--species=Mfranciscanus_braker-rna--workingdir=braker_rna.bam-hints

# Iterative BRAKER run with hints files
braker.pl --genome=Mfran-genome_softmasked.fa --hints=hintsfile-rna.gff --softmasking --cores=32 \
--species=Mfranciscanus --useexisting --workingdir=_braker-rna-FINAL 

# Rename genes in GTFs:
/data/app/BRAKER-2.1.6/TSEBRA/bin/rename_gtf.py --gtf braker.gtf --prefix Mfran --out Mfran_braker-rna-FINAL.gtf

#Extract unique genes only (no isoforms/splice variants) with gFACs
mkdir gfacs-unique && \
/data/app/gFACs/gFACs.pl -f braker_2.0_gtf --fasta ../Mfran-genome_softmasked.fa --statistics-at-every-step \
--unique-genes-only --get-fasta -O ./gfacs-unique Mfran_braker-rna-FINAL.gtf

# check completeness with busco
export PATH=$PATH:/data/app/hmmer-3.3/bin/ && \
busco -i ./genes.fasta -o BUSCO -l /data/app/busco-5.1.2/lineages/metazoa_odb10 --mode transcriptome -c 12
