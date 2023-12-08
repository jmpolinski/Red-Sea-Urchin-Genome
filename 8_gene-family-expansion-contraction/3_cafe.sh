#!/bin/bash
################ CAFE gene family expansion/contraction analysis ################

# Prepare data:
## convert Orthofinder ouput to format needed for CAFE
awk '{$NF=""; print $0}' ../OrthoFinder/Results_Jan24/Orthogroups/Orthogroups.GeneCount.tsv > orthofinder_counts.txt
###[Manually corrected formatting so headers would start with "Desc  Family ID" and then species, which do not contain underscores, and saved as orthofinder_4cafe.txt]
python /data/app/CAFE/python_scripts/clade_size_filter.py -i orthofinder_4cafe.txt -o filtered_cafe_input_2022-01.txt -s


# Set up CAFE shell script (see cafe_p.05_2022-02-18.sh)
cp /data/app/CAFE/example/cafe_script2.sh cafe_p.05_2022-02-18.sh
nano cafe_p.05_2022-02-18.sh

# Run CAFE
./cafe_p.05_2022-02-18.sh
./cafe_p.05_large_2022-02-18.sh

# Get CAFE report
python /data/app/CAFE/python_scripts/report_analysis.py -i CAFE-report_2022-02-18.txt.cafe -l CAFE-report_large_2022-02-18.txt.cafe -o CAFE-results_2022-02-22 -r 0

# Draw trees
python3 /data/app/CAFE/python_scripts/cafe_draw_tree.py -i CAFE-results_2022-02-22_node.txt  -t '(Bflorida-lancelet:9.56714,((((Spurpuratus-urchin:1.91343,Mfranciscanus-urchin:1.91343):1.91343,(Lvariegatus-urchin:1.91343,Lpictus-urchin:1.91343):1.91343):1.91343,(Aplanci-star:2.87014,Arubens-star:2.87014):2.87014):1.91343,Ajaponica-crinoid:7.65371):1.91343);' -d '(Bflorida-lancelet<0>,(Ajaponica-crinoid<2>,((Arubens-star<4>,Aplanci-star<6>)<5>,(Ajaponicus-cucumber<8>,((Lpictus-urchin<10>,Lvariegatus-urchin<12>)<11>,(Mfranciscanus-urchin<14>,Spurpuratus-urchin<16>)<15>)<13>)<9>)<7>)<3>)<1>' -o cafe_2022-02-22_tree-EXPANSIONS.png -y Expansions
python3 /data/app/CAFE/python_scripts/cafe_draw_tree.py -i CAFE-results_2022-02-22_node.txt  -t '(Bflorida-lancelet:9.56714,((((Spurpuratus-urchin:1.91343,Mfranciscanus-urchin:1.91343):1.91343,(Lvariegatus-urchin:1.91343,Lpictus-urchin:1.91343):1.91343):1.91343,(Aplanci-star:2.87014,Arubens-star:2.87014):2.87014):1.91343,Ajaponica-crinoid:7.65371):1.91343);' -d '(Bflorida-lancelet<0>,(Ajaponica-crinoid<2>,((Arubens-star<4>,Aplanci-star<6>)<5>,(Ajaponicus-cucumber<8>,((Lpictus-urchin<10>,Lvariegatus-urchin<12>)<11>,(Mfranciscanus-urchin<14>,Spurpuratus-urchin<16>)<15>)<13>)<9>)<7>)<3>)<1>' -o cafe_2022-02-22_tree-CONTRACTIONs.png -y Contractions
python3 /data/app/CAFE/python_scripts/cafe_draw_tree.py -i CAFE-results_2022-02-22_node.txt  -t '(Bflorida-lancelet:9.56714,((((Spurpuratus-urchin:1.91343,Mfranciscanus-urchin:1.91343):1.91343,(Lvariegatus-urchin:1.91343,Lpictus-urchin:1.91343):1.91343):1.91343,(Aplanci-star:2.87014,Arubens-star:2.87014):2.87014):1.91343,Ajaponica-crinoid:7.65371):1.91343);' -d '(Bflorida-lancelet<0>,(Ajaponica-crinoid<2>,((Arubens-star<4>,Aplanci-star<6>)<5>,(Ajaponicus-cucumber<8>,((Lpictus-urchin<10>,Lvariegatus-urchin<12>)<11>,(Mfranciscanus-urchin<14>,Spurpuratus-urchin<16>)<15>)<13>)<9>)<7>)<3>)<1>' -o cafe_2022-02-22_tree-RAPID.png -y Rapid
