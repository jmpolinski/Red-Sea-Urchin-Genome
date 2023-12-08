#!/bin/python

from ete2 import Tree 
t = Tree('(Branchiostoma-florida_lancelet:0.290683,((((Strongylocentrotus-purpuratus_urchin:0.0493749,Mesocentrotus-franciscanus_urchin:0.078464)0.715165:0.0637877,(Lytechinus-variegatus_urchin:0.0354754,Lytechinus-pictus_urchin:0.227243)0.703414:0.0855829)0.954253:0.290169,(Acanthaster-planci_star:0.200427,Asteria-rubens_star:0.197774)0.979855:0.192706)0.604924:0.0630358,Anneissia-japonica_crinoid:0.44835)1:0.290683);')

t.convert_to_ultrametric()
print('Ultrametric tree:')
print(t.write())
