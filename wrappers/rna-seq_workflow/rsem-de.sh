# Assuming no more than three replicates. If more, could be provided as multiple entries separated by ;? If so, whats the input variable name?
# This app is for the encode workflow only, assuming inputs are prepared in a folder
#----
# Performing differential analysis on gene level using RSEM 
#----
#set -x
# Example usage: https://github.com/bli25ucb/RSEM_tutorial
#singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
#genes
# rsem-generate-data-matrix LPS_6h.genes.results LPS_6h_2.genes.results LPS_6h_3.genes.results ... > GeneMat.txt
# rsem-run-ebseq GeneMat.txt 3,3 GeneMat.results
# rsem-control-fdr GeneMat.results 0.05 GeneMat.de.txt
#isoforms
# rsem-generate-ngvector ../ref/mouse_ref.transcripts.fa mouse_ref
# rsem-generate-data-matrix LPS_6h.isoforms.results LPS_6h_2.isoforms.results ... > IsoMat.txt
# rsem-run-ebseq --ngvector mouse_ref.ngvec IsoMat.txt 3,3 IsoMat.results
# rsem-control-fdr IsoMat.results 0.05 IsoMat.de.txt

data_a1=${sample1rep1}
data_a2=${sample1rep2}
data_a3=${sample1rep3}
data_b1=${sample2rep1}
data_b2=${sample2rep2}
data_b3=${sample2rep3}

# arguments
nr="${numReplicatesPerSample}"
nm="${listNames}"
fdr=${FDR}

# Get read files if preprocessed 
if [ -d "$data_a1" -a "$data_a1" == "$data_a2" ]; then
	inp_name="$(ls $data_a1)"
       	mv $data_a1/* .
	if [ -z "${nm}" ]; then nm="${inp_name}"; fi
else
	if [ -z "${nm}" ]; then
		nm="$data_a1"
		if [ -n "$data_a2" ]; then nm="$nm $data_a2"; fi
       		if [ -n "$data_a3" ]; then nm="$nm $data_a3"; fi
		nm="$nm $data_b1"
		if [ -n "$data_b2" ]; then nm="$nm $data_b2"; fi
        	if [ -n "$data_b3" ]; then nm="$nm $data_b3"; fi 
	fi
fi

if [ -z "${nr}" ]; then
	nr1=1
	nr2=1
	if [ -n "${data_a3}" ]; then nr1=$((nr1+1)); fi
	if [ -n "${data_a2}" ]; then nr1=$((nr1+1)); fi
        if [ -n "${data_b3}" ]; then nr2=$((nr2+1)); fi
        if [ -n "${data_b2}" ]; then nr2=$((nr2+1)); fi
	nr="$nr1,$nr2"
fi

# differential expression
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-generate-data-matrix ${nm} > GeneMat.txt
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-run-ebseq GeneMat.txt ${nr} GeneMat.results
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-control-fdr GeneMat.results ${fdr} GeneMat.de.txt

# Remove temporary and input files upon exit
trap "ls | grep -v GeneMat.txt | grep -v GeneMat.results | grep -v GeneMat.de.txt | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit
