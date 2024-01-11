#!/bin/bash

module load AGAT/v1.2.0

agat_sp_keep_longest_isoform.pl -gff GCF_018143015.1_Lvar_3.0_genomic.gff \
-out Lvariegatus_AGATfilt.gff 2>&1 | tee -a Lvariegatus_AGAT.log

