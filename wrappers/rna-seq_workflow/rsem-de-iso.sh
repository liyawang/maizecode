# Assuming no more than three replicates. If more, could be provided as multiple entries separated by ;? If so, whats the input variable name?
# This app is for the encode workflow only, assuming inputs are prepared in a folder
#----
# Performing differential analysis on isoform level using RSEM 
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

ref=${referenceFasta}
# get input name for references
if [ -d ${ref} -a $(ls $ref | wc -l) == 1 ]; then
        inp_name=$(ls ${ref})
        mv ${ref}/${inp_name} .
        rm -rf ${ref}
        ref=${inp_name}
fi
ref_ext="${ref##*.}"
if [ ${ref_ext} = "gz" ]; then gunzip ${ref}; ref=${ref%.*}; fi
rb="${ref%%.*}" #ref basename

data_a1=${sample1rep1}
data_a2=${sample1rep2}
data_a3=${sample1rep3}
data_b1=${sample2rep1}
data_b2=${sample2rep2}
data_b3=${sample2rep3}

# Get read files if preprocessed 
if [ -d "$data_a1" -a "$data_a1" == "$data_a2" ]; then
	inp_name="$(ls $data_a1)"
       	mv $data_a1/* .
fi

# arguments
nr="${numReplicatesPerSample}"
nm="${listNames}"
fdr=${FDR}
if [ -z "${nm}" ]; then
	nm="${inp_name}"
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
	rsem-generate-ngvector $ref $rb
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-generate-data-matrix ${nm} > IsoMat.txt
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-run-ebseq --ngvector $rb.ngvec IsoMat.txt ${nr} IsoMat.results
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-control-fdr IsoMat.results ${fdr} IsoMat.de.txt

# Remove temporary and input files upon exit
trap "ls | grep -v IsoMat.txt | grep -v IsoMat.results | grep -v IsoMat.de.txt | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit
