#!/bin/bash


# set -x

bamInput="${bamInput}"

# smpId="${smpId}"

output_id1="picard1"
output_id2="picard2"

## PROCESSING INPUTS if bam is in a folder

# if [ -d "$bamInput" ]; then
# 	inp_name=$(basename $(ls $bamInput/*.[bB][aA][mM]))
# 	mv $bamInput/* .
# 	# rm -rf $bamInput
# 	bamInput=${inp_name}
# fi

# smpId=${bamInput%%.*}
if [[ "$bamInput" =~ bwa_mem_* ]]; then
	smpId=${bamInput#bwa_mem_}
	smpId=${smpId%%.*}
else
	smpId=${bamInput%%.*}
fi

VALIDATION_STRINGENCY="${VALIDATION_STRINGENCY}"
REMOVE_DUPLICATES="${REMOVE_DUPLICATES}"

# VALIDATION_STRINGENCY="LENIENT"
# REMOVE_DUPLICATES=1


runthis=''

#JVM_ARGS="-Xmx16g"


################

if [ -n "${VALIDATION_STRINGENCY}" ]; then runthis="$runthis VALIDATION_STRINGENCY=${VALIDATION_STRINGENCY}"; fi
#if [ -n "${REMOVE_DUPLICATES}" ]; then runthis="$runthis REMOVE_DUPLICATES=$REMOVE_DUPLICATES"; fi

if [ "${REMOVE_DUPLICATES}" = 1 ]; then
runthis="$runthis REMOVE_DUPLICATES=true"
else
runthis="$runthis REMOVE_DUPLICATES=false"
fi



#echo "java $JVM_ARGS -jar $picardDir/picard.jar MarkDuplicates I=$Input1 O="picard_rmDup.bam" M="picard_rmDup_metrics.txt" $runthis"
#java $JVM_ARGS -jar $picardDir/picard.jar MarkDuplicates I=$Input1 O="picard_rmDup.bam" M="picard_rmDup_metrics.txt" $runthis
#samtools index picard_rmDup.bam

echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/picard_2.11.0--py27_0.img picard MarkDuplicates I=$bamInput O=${output_id1}_${smpId}".bam" M=${output_id2}_${smpId}"_metrics.txt" $runthis"

singularity exec -B /scratch:/scratch /scratch/tacc/images/picard_2.11.0--py27_0.img picard MarkDuplicates I=$bamInput O=${output_id1}_${smpId}".bam" M=${output_id2}_${smpId}"_metrics.txt" $runthis

singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools index ${output_id1}_${smpId}".bam"

# mkdir picardOut
# mv *picard_rmDup* picardOut


ls | grep -v picard | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf

trap "ls | grep -v picard | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit



