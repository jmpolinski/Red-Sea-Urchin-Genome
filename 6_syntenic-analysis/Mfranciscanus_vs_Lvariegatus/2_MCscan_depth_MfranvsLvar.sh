#!/bin/bash
#visualize synteny - calculate depth
#K Castellano

python3 -m jcvi.compara.synteny depth --histogram Mfranciscanus.Lvariegatus.anchors 2>&1 | tee -a 2_MCscan_depth_MfranvsLvar.log
