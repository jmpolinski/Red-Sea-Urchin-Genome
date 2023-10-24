#!/bin/bash
#visualize macrosynteny - make simple file
#K Castellano

python3 -m jcvi.compara.synteny screen --minspan=30 --simple Lvariegatus.Lpictus.anchors Lvariegatus.Lpictus.anchors.new 2>&1 | tee -a 3_MCscan_mkSimpleFile_LvarvsLpictus.log
