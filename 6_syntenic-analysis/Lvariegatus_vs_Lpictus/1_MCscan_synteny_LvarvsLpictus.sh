#!/bin/bash
#Run pairwise synteny with MCscan
#Kate Castellano

python3 -m jcvi.compara.catalog ortholog Lvariegatus Lpictus --no_strip_names 2>&1 | tee -a 1_MCscan_synteny_LvarvsLpictus.log
