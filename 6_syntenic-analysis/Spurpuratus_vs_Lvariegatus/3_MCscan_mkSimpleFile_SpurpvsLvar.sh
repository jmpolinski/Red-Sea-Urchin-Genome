#!/bin/bash
#visualize macrosynteny - make simple file
#K Castellano

python3 -m jcvi.compara.synteny screen --minspan=30 --simple Spurp.Lvar.anchors Spurp.Lvar.anchors.new 2>&1 | tee -a 3_MCscan_mkSimpleFile_SpurpvsLvar.log
