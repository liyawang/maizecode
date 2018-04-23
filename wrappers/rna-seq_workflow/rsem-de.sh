#----
# Performing differential analysis on gene level using RSEM 
#----

sImagePath="-B /scratch:/scratch /scratch/tacc/images"
data_a="${sample1}"
arr=($(echo ${data_a} | tr " " "\n"))
nr1=${#arr[@]}

data_b="${sample2}"
arr=($(echo ${data_b} | tr " " "\n"))
nr2=${#arr[@]}

# arguments
fdr=${FDR}

# differential expression on gene level
singularity exec ${sImagePath}/rsem_1.3.0--boost1.61_0.img \
		rsem-generate-data-matrix ${data_a} ${data_b} > GeneMat.txt
singularity exec ${sImagePath}/rsem_1.3.0--boost1.61_0.img \
		rsem-run-ebseq GeneMat.txt ${nr1},${nr2} GeneMat.results
singularity exec ${sImagePath}/rsem_1.3.0--boost1.61_0.img \
		rsem-control-fdr GeneMat.results ${fdr} GeneMat.de.txt
mv GeneMat.de.txt deg_GeneMat.de.txt

# Remove temporary and input files upon exit
trap "ls | grep -v GeneMat.txt | grep -v IsoMat.txt | grep -v GeneMat.results | grep -v IsoMat.results | grep -v deg_GeneMat.de.txt | grep -v deiso_IsoMat.de.txt | grep -v "\.err" | grep -v "\.out" | grep -v "\.ngvec" | grep -v ipcexe |xargs rm -rf" exit
