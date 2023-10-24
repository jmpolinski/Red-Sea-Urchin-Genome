#!/bin/bash
#Run pairwise synteny with MCscan
#Kate Castellano

python3 -m jcvi.compara.catalog ortholog Mfranciscanus Lvariegatus --no_strip_names 2>&1 | tee -a 1_MCscan_synteny_MfranvsLvar.log
