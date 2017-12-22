#Assumption is that annotation file must be provided
#----
# Creates index files for STAR and bundles everything up
#----
#set -x
# Example usage:
# singularity exec -B /scratch:/scratch /scratch/tacc/images/star_2.5.3a--0.img STAR --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles ../Sbicolor_Sorbi1.31.fa --sjdbGTFfile ../Sbicolor_Sorbi1.34.gtf --runThreadN 12

ref=${referenceFasta}
anno=${annotationGTF}

# is input compressed? if so, uncompress and update with new filename
# assumption is that it is gzipped only
ref_ext="${ref##*.}"
if [ ${ref_ext} = "gz" ]; then gunzip ${ref}; ref=${ref%.*}; fi
anno_ext="${anno##*.}"
if [ ${anno_ext} = "gz" ]; then gunzip ${anno}; anno=${anno%.*}; fi

# create folder to hold index
rb="${ref%%.*}" # reference basename
mkdir ${rb}

# index
singularity exec -B /scratch:/scratch /scratch/tacc/images/star_2.5.3a--0.img \
	STAR --runMode genomeGenerate \
	--genomeDir ${rb} \
	--genomeFastaFiles ${ref} \
	--sjdbGTFfile ${anno} \
	--runThreadN 8

# Compress and move into the output folder
tar -czf ${rb}.tgz ${rb}
output_id1="star_index"
mkdir ${output_id1}
mv ${rb}.tgz ${output_id1}/.

# Remove temporary and input files upon exit
trap "rm -rf ${ref} ${rb} ${anno} *.template *.sh" exit

