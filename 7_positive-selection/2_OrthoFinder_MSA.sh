#!/bin/bash
#Run Orthofinder for Natural Selection Analysis
#Kate Castellano

#-f = path to fasta files for each species
python3 /data/app/OrthoFinder/orthofinder.py -M msa -f ~/positive-selection/protein-files-urchinsOnly/
