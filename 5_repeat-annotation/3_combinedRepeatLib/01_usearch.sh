#!/bin/bash
#cluster combined repeat library to remove redundant repeats picked up in multiple programs
#November 9, 2021 -  Kate Castellano

/data/app/usearch_free/usearch11.0.667 -cluster_fast Mfran_RepeatLibCombined.fa -id 0.8 -centroids Mfran_RepeatLibCombined_clustered.fa
