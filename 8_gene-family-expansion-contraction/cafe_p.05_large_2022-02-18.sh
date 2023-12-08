#!/usr/local/bin/cafe
date
version

#specify data file, p-value threshold, # of threads to use, and log file
load -i large_filtered_cafe_input_2022-02.txt -p 0.05 -t 10 -l cafe-log_large_2022-02-18_p.05.txt

#the phylogenetic tree structure with branch lengths
tree (Bflorida-lancelet:97.7195,(Ajaponica-crinoid:81.4329,((Arubens-star:32.5732,Aplanci-star:32.5732):32.5732,(Ajaponicus-cucumber:48.8597,((Lpictus-urchin:16.2866,Lvariegatus-urchin:16.2866):16.2866,(Mfranciscanus-urchin:16.2866,Spurpuratus-urchin:16.2866):16.2866):16.2866):16.2866):16.2866):16.2866);

#search for 2 parameter model
lambda -s -t (1,(2,((2,2)2,(2,((2,2)2,(2,2)2)2)2)2)1)

# generate a report
report CAFE-report_p.05_large_2022-02-18.txt

