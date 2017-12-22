# Assumption is that input files (also assume two read files) are gzipped and index is tarred
#----
# STAR alignment with provided index 
#----
#set -x
# Example usage:
#singularity exec -B /scratch:/scratch /scratch/tacc/images/star_2.5.3a--0.img STAR --genomeDir ./star --readFilesIn ../P/rnaseq/G3AHR1_R1.gz ../P/rnaseq/G3AHR1_R2.gz --readFilesCommand zcat --outSAMunmapped Within --outFilterType BySJout --outSAMattributes NH HI AS NM MD nM jM jI --outFilterMultimapNmax 20 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 --alignIntronMax 300000 --alignMatesGapMax 300000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 --runThreadN 12 --limitBAMsortRAM 10000000000 --outSAMtype BAM SortedByCoordinate --quantMode TranscriptomeSAM GeneCounts

data_a=${inputSequence1}
data_b=${inputSequence2}  
reference_bundle=${referenceBundle}

# Get read file if preprocessed separately
if [ -d "$data_a" -a "$data_a" == "$data_b" ]; then
        inp_name=$(ls $data_a)
       	mv $data_a/* .
       	rm -rf $data_a
	inp_array=(${inp_name////})
       	data_a=${inp_array[0]}
	data_b=${inp_array[1]}
fi 
# Get read file if preprocessed together
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

# get input name for references
if [ -d ${reference_bundle} -a $(ls $reference_bundle | wc -l) == 1 ]; then
	inp_name=$(ls ${reference_bundle})
        mv ${reference_bundle}/${inp_name} .
        rm -rf ${reference_bundle}
        reference_bundle=${inp_name}
fi
ref_ext="${reference_bundle##*.}"
if [ ${ref_ext} = "tgz" ]; then tar -xzf ${reference_bundle}; ref=${reference_bundle%.*}; fi
if [ ${ref_ext} = "tar" ]; then tar -xf ${reference_bundle}; ref=${reference_bundle%.*}; fi

# parameters
rb="${data_a%%.*}" # read1 basename
ARGS="--outFileNamePrefix ${rb}. ${outFilterType} ${outFilterMultimapNmax} ${alignSJoverhangMin} ${alignSJDBoverhangMin} ${outFilterMismatchNmax} ${outFilterMismatchNoverReadLmax} ${alignIntronMin} ${alignIntronMax} ${alignMatesGapMax} ${outSAMunmapped} ${sjdbScore}"

# align
singularity exec -B /scratch:/scratch /scratch/tacc/images/star_2.5.3a--0.img \
	STAR $ARGS --genomeDir $ref \
	--readFilesIn $data_a $data_b \
	--readFilesCommand zcat \
	--runThreadN 8 \
	--outSAMattributes NH HI AS NM MD nM jM jI --limitBAMsortRAM 10000000000 --outSAMtype BAM SortedByCoordinate --quantMode TranscriptomeSAM GeneCounts

# move output to output_id folder
output_id1="alignedToGenome"
output_id2="alignedToTranscriptome"
mkdir ${output_id1} ${output_id2}
mv ${rb}.Aligned.sortedByCoord.out.bam ${output_id1}/.
mv ${rb}.Aligned.toTranscriptome.out.bam ${output_id2}/.

# Remove temporary and input files upon exit
trap "ls | grep -v alignedToGenome | grep -v alignedToTranscriptome | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit

