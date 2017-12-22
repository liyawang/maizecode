#----
# Quantification using RSEM with provided index 
#----
#set -x
# Example usage:
#singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img rsem-calculate-expression --bam --no-bam-output -p 12 --paired-end --forward-prob 1 Aligned.toTranscriptome.out.bam RSEMprep Quant

data_a=${alignedToTrans}
data_b=${RSEMprep}  

# Get input file if preprocessed? 
if [ -d "$data_a" -a $(ls $data_a | wc -l) == 1 ]; then
        inp_name=$(ls $data_a)
        mv $data_a/$inp_name .
        rm -rf $data_a
        data_a=${inp_name}
fi
if [ -d "$data_b" -a $(ls $data_b | wc -l) == 1 ]; then
        inp_name=$(ls $data_b)
        mv $data_b/$inp_name .
        rm -rf $data_b
        data_b=${inp_name}
fi

# is input compressed? if so, uncompress and update with new filename
data_b_ext="${data_b##*.}"
if [ ${data_b_ext} = "tgz" ]; then tar -xzf ${data_b}; data_b=${data_b%.*}; fi
if [ ${data_b_ext} = "tar" ]; then tar -xf ${data_b}; data_b=${data_b%.*}; fi

rb="${data_a%%.*}" # get basename

# arguments
paired=${isPaired}
forpro=${forwardProb}
ARGS=""
if [ ${paired} -eq 1 ]; then
	ARGS="--paired-end"
fi
ARGS="$ARGS --forward-prob $forpro"

# quantification
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-calculate-expression --bam --no-bam-output \
	-p 8 ${ARGS} \
	$data_a $data_b ${rb}

# move output to output_id folder
output_id1="geneResults"
output_id2="isoformResults"
mkdir ${output_id1} ${output_id2}
mv ${rb}.genes.results ${output_id1}/.
mv ${rb}.isoforms.results ${output_id2}/.

# Remove temporary and input files upon exit
trap "ls | grep -v geneResults | grep -v isoformResults | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit
