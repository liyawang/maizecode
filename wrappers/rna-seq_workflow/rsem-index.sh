#----
# Prepare references for RSEM and bundles everything up
#----
#set -x
# Example usage:
#singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img rsem-prepare-reference --gtf Sbicolor_Sorbi1.34.gtf Sbicolor_Sorbi1.31.fa RSEMpre

ref=${referenceFasta}
anno=${annotationGTF}

# is input compressed? if so, uncompress and update with new filename
# assumption is that it is gzipped only
ref_ext="${ref##*.}"
if [ ${ref_ext} = "gz" ]; then gunzip ${ref}; ref=${ref%.*}; fi
anno_ext="${anno##*.}"
if [ ${anno_ext} = "gz" ]; then gunzip ${anno}; anno=${anno%.*}; fi

rb="${ref%%.*}" # reference basename
# index
singularity exec -B /scratch:/scratch /scratch/tacc/images/rsem_1.3.0--boost1.61_0.img \
	rsem-prepare-reference \
	--gtf ${anno} ${ref} ${rb}

# Compress and put the tar ball inside designated output folder
tar -czf ${rb}.tgz ${rb}.*
mkdir RSEM_prep
mv ${rb}.tgz RSEM_prep/.

gzip ${rb}.transcripts.fa
mkdir RSEM_transcript
mv ${rb}.transcripts.fa.gz RSEM_transcript/.
 
# Remove temporary and input files upon exit
trap "ls | grep -v RSEM_prep | grep -v RSEM_transcript | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit
