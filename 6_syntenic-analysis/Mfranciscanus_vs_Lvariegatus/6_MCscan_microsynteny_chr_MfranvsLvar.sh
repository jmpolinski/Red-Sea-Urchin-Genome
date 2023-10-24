#!/bin/bash
#microsynteny chr 12 M fran
#Kate Castellano

#hox block
python3 -m jcvi.graphics.synteny Mfran_hox.blocks Mfranciscanus_Lvariegatus.bed hoxblock.layout --glyphcolor=orthogroup --genelabelsize 6
