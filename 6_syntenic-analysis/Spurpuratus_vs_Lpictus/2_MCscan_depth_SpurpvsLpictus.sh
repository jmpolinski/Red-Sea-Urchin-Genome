#!/bin/bash
#visualize synteny - calculate depth
#K Castellano

export PATH=$PATH:/data/app/last/bin/
python3 -m jcvi.compara.synteny depth --histogram Spurp.Lpictus.anchors 2>&1 | tee -a 2_MCscan_depth_MfranvsSpurpvsLvar.log
