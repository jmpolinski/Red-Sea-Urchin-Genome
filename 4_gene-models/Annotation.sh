#!/bin/bash 

########### Gene model annotation #############

# Annotation with EnTap:
/data/app/EnTAP-0.10.8-beta/EnTAP --runP -i ./Mfran_braker-proteins_FINAL.faa \
-d /data/app/EnTAP-0.10.8-beta/bin/uniprot-sprot_2021-04.dmnd -d /data/app/EnTAP-0.10.8-beta/bin/refseq-complete.dmnd \
--ini /data/app/EnTAP-0.10.8-beta/entap_config.ini -t 8
