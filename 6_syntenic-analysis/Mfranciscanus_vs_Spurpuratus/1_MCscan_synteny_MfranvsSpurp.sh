#!/bin/bash
#run MCscan
#K Castellano

module load last/1170

python -m jcvi.compara.catalog ortholog Mfranciscanus Spurp --no_strip_names 2>&1 | tee -a 1_MCscan_synteny_MfranvsSpurp.log
