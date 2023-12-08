#!/bin/bash
#gFACs to filter duplicates in NCBI genomes for gene family contraction and expansion
#Oct 25, 2021

/data/app/gFACs/gFACs.pl \
	-f refseq_gff \
	-p Ajaponica_uniques \
	--statistics \
	--statistics-at-every-step \
	--unique-genes-only \
	--create-gff3 \
--fasta /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica/GCF_011630105.1_ASM1163010v1_genomic.fasta \
	--get-protein-fasta /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica_uniques/ \
-O /data/usr/kcastellano/redSeaUrchin_OrthoFinder_otherGenomes/Ajaponica_uniques/ \
GCF_011630105.1_ASM1163010v1_genomic.gff

