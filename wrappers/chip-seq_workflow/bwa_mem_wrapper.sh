#!/bin/bash

#set -x
read1="${read1}" # have to keep {}
read2="${read2}"

echo $read1
echo $read2

output_id1="bwa_mem"

# echo $read1
# echo $read2
## PRE-PROCESSING INPUTS, move out read fastq files if inputs are folders.

# if [ -d "$read1" -a $(ls $read1 | wc -l) == 1 ]; then
# 	inp_name=$(ls $read1)
# 	mv $read1/$inp_name .
# 	# rm -rf $read1
# 	read1=${inp_name}
# fi

# # if [ -d "$read2" -a $(ls $read2 | wc -l) == 1 ]; then
# if [ -d "$read2" ]; then
#     inp_name=$(ls $read2)
#     if [ $(ls $read2 | wc -l) != 0 ]; then
#     	mv $read2/$inp_name .
#     fi
# 	# rm -rf $read2
# 	read2=${inp_name}
# fi

# if [ -d "$read1" ]; then
#     folderItems=$(ls $read1 | grep -v single)
#     folderItemsArray=(${folderItems////})
#     inp_name=${folderItemsArray[0]}
#     mv $read1/$inp_name .
#     read1=${inp_name}
# fi


# if [ -d "$read2" ]; then
#     folderItems=$(ls $read2 | grep -v single)
#     folderItemsArray=(${folderItems////})
#     inp_name=${folderItemsArray[0]}
#     mv $read2/$inp_name .
#     read2=${inp_name}
# fi

# echo $read1
# echo $read2

# gunzip input files if needed
data_ext="${read1##*.}"
if [ ${data_ext} = "gz" ]; then gunzip $read1; read1=${read1%.*}; fi # can't use ${read1} for $read1, as long as rename a variable

if [ -n "$read2" ]; then	
	data_ext="${read2##*.}"
	if [ ${data_ext} = "gz" ]; then 
		gunzip $read2
		read2=${read2%.*}
	fi
fi
# echo $read1

# smpId=${read1%.*}

if [[ "$read1" =~ ss1_sc1_* ]]; then
	smpId=${read1#ss1_sc1_}
	smpId=${smpId%.*}
else
	smpId=${read1%.*}
fi


if [[ "$smpId" =~ .*_R1* ||  "$smpId" =~ .*_r1* || "$smpId" =~ .*-R1* || "$smpId" =~ .*-r1* ]]; then
	smpId=${smpId/_R1/}
	smpId=${smpId/_r1/}
	smpId=${smpId/-R1/}
	smpId=${smpId/-r1/}
fi
# echo $read2

# processing reference
tarIdxRefBundle="${tarIdxRefBundle}"

# if [ -d ${tarIdxRefBundle} -a $(ls $tarIdxRefBundle | wc -l) == 1 ]; then
# 	inp_name=$(ls ${tarIdxRefBundle})
#         mv ${tarIdxRefBundle}/${inp_name} .
#         # rm -rf ${tarIdxRefBundle}
#         tarIdxRefBundle=${inp_name}
# fi

# uncompress reference bundle old

# if [[ "$tarIdxRefBundle" =~ .*\.tar\.gz$ ]]; then 
# 	tar -xzvf $tarIdxRefBundle
# 	IdxRefFolderNm=$(basename $tarIdxRefBundle .tar.gz)
# 	idxbase="$(ls $IdxRefFolderNm/*.fa)"
# 	# idxDic="$(ls $IdxRefFolderNm/*.dict)"
# 	mv ${IdxRefFolderNm}/* ./
# else
# 	if [[ "$tarIdxRefBundle" =~ .*\.tgz$ ]]; then
# 		tar -xzvf $tarIdxRefBundle
# 		IdxRefFolderNm=$(basename $tarIdxRefBundle .tgz)
# 		if [ -d "$IdxRefFolderNm" ]; then
# 			idxbase="$(ls $IdxRefFolderNm/*.fa)"
# 			# idxDic="$(ls $IdxRefFolderNm/*.dict)"
# 			mv ${IdxRefFolderNm}/* ./
# 		else
# 			idxbase="$(ls ./*.fa)"
# 			# idxDic="$(ls ./*.dict)"
# 		fi

# 	fi

# fi

# uncompress reference bundle new

if [[ "$tarIdxRefBundle" =~ .*\.tar\.gz$ || "$tarIdxRefBundle" =~ .*\.tgz$ ]]; then 
	tar -xzvf $tarIdxRefBundle
	idxbase="$(ls ./*.fa)"
fi

# echo $IdxRefFolderNm
echo $idxbase

########


# Do not output alignment with score lower than INT. This option only affects output.
# min_score=30
# read_type=""

min_score="${min_score}"
read_type="${read_type}"

# mark shorter split hits as secondary
# M=1
M="${M}"

# miniMapQual=30
# requiredAlignment=2

miniMapQual="${miniMapQual}"
requiredAlignment="${requiredAlignment}"


# sort_type=""
sort_type="${sort_type}"

# Output="bwa.sorted.bam"
# smpId="${smpId}"

runthis=''
runthis2=''
runthis3=''


################

if [ -n "${min_score}" ]; then runthis="$runthis -T $min_score"; fi
if [ -n "${read_type}" ]; then runthis="$runthis -x ${read_type}"; fi



if [ "$M" = 1 ]; then
runthis="$runthis -M"
else
runthis=$runthis
fi
# if [ -n "${maxMismatch}" ]; then runthis="$runthis -m $maxMismatch"; fi
# if [ -n "${adapterStrip}" ]; then runthis="$runthis -a $adapterStrip"; fi


# Usage: bwa mem [options] <idxbase> <in1.fq> [in2.fq]

# echo "read1, read2:  $read1, $read2"
# echo "read1_brace, read2_brace: ${read1} ${read2}"


if [ -n "$read2" ]; then
singularity exec -B /scratch:/scratch /scratch/tacc/images/bwa_0.7.13--1.img bwa mem -t 8 "${idxbase}" $runthis "$read1" "$read2" > ${output_id1}_${smpId}".sam"
echo "bwa mem -t 8 "${idxbase}" $runthis "$read1" "$read2" > ${output_id1}_${smpId}".sam""
else
singularity exec -B /scratch:/scratch /scratch/tacc/images/bwa_0.7.13--1.img bwa mem -t 8 "${idxbase}" $runthis "$read1" > ${output_id1}_${smpId}".sam"
echo "bwa mem -t 8 "${idxbase}" $runthis "$read1" > ${output_id1}_${smpId}".sam""
fi



#################################

if [ -n "${miniMapQual}" ]; then runthis2="$runthis2 -q ${miniMapQual}"; fi
if [ -n "${requiredAlignment}" ]; then runthis2="$runthis2 -f ${requiredAlignment}"; fi



if [ -n "${sort_type}" ]; then runthis3="$runthis3 -n"; fi

echo "samtools view -bS $runthis2 -o ${output_id1}_${smpId}".bam" ${output_id1}_${smpId}".sam""
singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools view -bS $runthis2 -o ${output_id1}_${smpId}".bam" ${output_id1}_${smpId}".sam"

# echo "samtools sort $runthis3 "bwa.bam" ${Output}"
#samtools sort $runthis3 "bwa.bam" $"Output"
singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools sort $runthis3 -o ${output_id1}_${smpId}".sorted.bam" -T ${output_id1}_${smpId}".sorted" ${output_id1}_${smpId}".bam"

echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools sort $runthis3 -o ${output_id1}_${smpId}".sorted.bam" -T ${output_id1}_${smpId}".sorted" ${output_id1}_${smpId}".bam""

singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools index ${output_id1}_${smpId}".sorted.bam"

# mkdir bwa_mem_out
# mv *sorted* bwa_mem_out

ls | grep -v "sorted.bam" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf

trap "ls | grep -v "sorted.bam" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit
#






