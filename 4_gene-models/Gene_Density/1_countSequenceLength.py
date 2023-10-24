#!/usr/bin/python3

from Bio import SeqIO

seqcount = []
def countSequenceLength(inputFileName, outputFileName):
    for seqrecord in SeqIO.parse(inputFileName, "fasta"):
        id = seqrecord.id
        length = len(seqrecord.seq)
        seqcount.append(">" + str(id)+ "\t" + str(length) + "\n")
    file = open(outputFileName, 'w')
    file.writelines(seqcount)
