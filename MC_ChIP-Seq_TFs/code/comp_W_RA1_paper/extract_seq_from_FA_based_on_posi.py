#!/usr/bin/env python 
# Created by: Xiaofei Wang
# Descript: Extract sequence from *.fa based on position info.
# Inputs: a TXT file with scaffold/chr and start_end info.
# Out: a fasta file containing the extracted sequence (Note: the seq is in one line not multiple lines).

# Usage: python ******.py input.txt output.fa
# Example: python ******.py fragment_start_end.txt output.fa
#----------------------------------------------------------------------------------------
#===========================================================================================================
#Imports:

import sys
import os
import pyfasta
#===========================================================================================================
# Functions:


posInput = open(sys.argv[1], 'rU')
# scaffoldFa = open(sys.argv[2], 'rU')
scaffoldFa = 'Zea_mays.AGPv4.35.chr.fa'
outFa = open(sys.argv[2], 'w')

attrList = []
seqList = []

# fastaSeq = pyfasta.Fasta(scaffoldFa, key_fn=lambda key: key.split()[0])
fastaSeq = pyfasta.Fasta(scaffoldFa)

print fastaSeq.keys()

# print fastaSeq.keys()[0]
# print 'The length of the sequence is', len(str(fastaSeq[fastaSeq.keys()[0]]))

for idx, row in enumerate(posInput):
	line = row.replace('\n', '').split('\t')
	# seqKey = line[0].split('_')[0]
	# seqKey = line[0].split('chr')[1]
	seqKey = line[0]
	# print seqKey
	if seqKey in fastaSeq.keys():
		# start = int(line[1])
		# end = int(line[2])
		start = int(line[1]) - 2000
		end = int(line[2]) + 2000
		attributes = [line[0]]
		# print attributes
		attributes.append('%s-%s' %(start, end)) 
		attrList.append(attributes)
		# print attributes
		# print attrList
		seq = fastaSeq.sequence({'chr':seqKey, 'start':start, 'stop':end})
		seqList.append(seq)
# print attrList
print len(seqList)
# print seqList


for header, item in zip(attrList, seqList):
	# itemSeq = fastaSeq[fastaSeq.keys()[0]][item[0]:item[1]]
	#print itemSeq
	outFa.write('>' + '_'.join(header) + '\n')
	outFa.write(item + '\n')

print 'Done!!!'
