#!/usr/bin/env python 
# Created by: Xiaofei Wang
# Date: 05/03/2017
# Descript: This code is to extract the expressed info. from cuffdiff_out (modified) based on gene ids.


# Inputs1: gene IDs
# Inputs2: anno_file

# Output: a txt file for the extracted anno_file ortholog info.

# Usage: python ******.py input1 input2 output
# Example: python extract_ortholog.py *.txt *.txt *.txt


import sys
import os

#===========================================================================================================
# Functions:

geneIds=open(sys.argv[1], 'rU')
anno_file=open(sys.argv[2], 'rU')

outOrtholog=open(sys.argv[3], 'w')

expDic={}
# outList=[["V3","V4","PFAM","Panther","KOG","KEGG_ec","KEGG_Orthology",\
# "GO_terms","best_TAIR1_hit_name","best_TAIR1_hit_symbol","best_TAIR1_hit_defline",\
# "best_rice_hit_name","best_rice_hit_symbol","best_rice_hit_defline"]]

outList=[["V3","V4"]]

emptyNo=0

for idx, row in enumerate(anno_file):
	# if idx!=0:
		line=row.replace('\n','').split('\t')
		# print line[1]
		geneExpId=line[0]
		if geneExpId not in expDic:
			expDic[geneExpId]=[]
		expDic[geneExpId].append(line[1])

print idx
print expDic["AC148152.3_FG001"]

for idx, row in enumerate(geneIds):
	if idx!=0:
		line=row.replace('\n','').split('\t')
		if line[0] in expDic:
			for i in range(len(expDic[line[0]])):
				outList.append([line[0],expDic[line[0]][i]])
				# outList.append(expDic[line[0]])
			# expDic[line[0]].insert(0,line[0])
			# expDic[line[0]].insert(1,line[1])
			# outList.append(expDic[line[0]])
		# elif line[0]=='NA':
		# 	print "%s does not have V3 gene Id." %(line[1],)
		# 	emptyNo+=1
		# 	naList=[line[0], line[1]]
		# 	naList.extend(['NA']*12)
		# 	outList.append(naList)

		else:
			print "%s (V3) is not in the anno file." %(line[0],)
			emptyNo+=1
			emptyList=[line[0]]
			emptyList.extend(['NA'])
			outList.append(emptyList)
# print expDic["Sb03g026970.1"]
# print outList
for item in outList:
	outOrtholog.write("\t".join(item)+'\n')

print "%s genes (V3) have no v4 id." %(emptyNo,)
print "Done!!!"


# G3_H3K27me3_H3_diff_nb_4Fold_sigFDR_sigPeak: 1424 sigSite have no ortholog.
# G3_H3K4me3_H3_diff_nb_4Fold_sigFDR_sigPeak: 39 sigSite have no ortholog.

# G1_H3K27me3_H3_diff_nb_4Fold_sigFDR_sigPeak: 948 sigSite have no ortholog.
 # G1_H3K4me3_H3_diff_nb_4Fold_sigFDR_sigPeak: 57 sigSite have no ortholog.

