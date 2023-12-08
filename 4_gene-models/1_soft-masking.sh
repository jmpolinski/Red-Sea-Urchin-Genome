#!/bin/bash

### Soft masking M. franciscanus genome for gene model prediction

# 1. Create a database for RepeatModeler:
/data/app/RepeatModeler-2.0.2a/BuildDatabase -name mfran Mfran_genome_final.fa

# 2. Run RepeatModeler:
/data/app/RepeatModeler-2.0.2a/RepeatModeler -database mfran -pa 20 -LTRStruct

# 3. Run RepeatMasker:
/data/app/RepeatMasker/RepeatMasker -pa 10 -lib mfran-families.fa -xsmall -gff Mfran_genome_final.fa
