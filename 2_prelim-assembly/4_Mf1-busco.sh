#!/bin/bash

# export needed paths
export PATH=$PATH:/data/app/augustus-3.4.0/:/data/app/augustus-3.4.0/scripts/:/data/app/augustus-3.4.0/bin/
export AUGUSTUS_CONFIG_PATH=/data/app/augustus-3.4.0/config/

# run busco
busco -i canu_purged-all.fa -o purge-all_busco -l /data/app/busco-5.1.2/lineages/metazoa_odb10/ --mode genome --long -c 8

