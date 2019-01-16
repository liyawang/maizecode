#!/bin/bash

#set -x
ctrlDir="${ctrlDir}"
# marksDir="marksDir"
marksDir="${marksDir}"

echo "${ctrlDir}"
echo "${marksDir}"

# if [ -d "$marksDir" -a "$ctrlDir" == "$marksDir" ]; then
# 	inp_name=$(ls $marksDir | grep ctrl)
# 	mv $marksDir/$inp_name .
# 	ctrlDir=$inp_name
# 	inp_name2=$(ls $marksDir)
# 	mv $marksDir/$inp_name2 .
# 	marksDir=$inp_name2
# fi


# if [ -d "$marksDir" -a "$ctrlDir" = "" ]; then
# 	inp_name=$(ls $marksDir)
# 	mv $marksDir/$inp_name .
# 	marksDir=$inp_name
# fi

# smpId=${marksDir%_*}
if [[ "$marksDir" =~ homerTagDir_* ]]; then
	smpId=${marksDir#homerTagDir_}
    smpId=${smpId%%.*}
else
	smpId=${marksDir%%.*}
fi

output_id1="homerPeaks1"
output_id2="homerPeaks2"



# region=1
# style=""
# size=1000
# minDist=2500
# gsize=7e8

# rep=2


region="${region}"
style="${style}"
size="${size}"
minDist="${minDist}"
gsize="${gsize}"

#rep="${rep}"
runthis=''


################




if [ -n "${ctrlDir}" ]; then runthis="$runthis -i $ctrlDir"; fi
if [ -n "${style}" ]; then runthis="$runthis -style $style"; fi
if [ -n "${size}" ]; then runthis="$runthis -size $size"; fi
if [ -n "${minDist}" ]; then runthis="$runthis -minDist $minDist"; fi
if [ -n "${gsize}" ]; then runthis="$runthis -gsize $gsize"; fi


if [ ${region} = 1 ]; then
	runthis="$runthis -region"
fi

# homerOut="homerPeaksOut.txt"
# homerBedOut="homerPeaksOut.bed"

echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img findPeaks $marksDir $runthis -o ${output_id1}_${smpId}.txt"
singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img findPeaks $marksDir $runthis -o ${output_id1}_${smpId}.txt

grep -v '#' ${output_id1}_${smpId}.txt | cut -f 1-6 | awk -v OFS='\t' '{print $2,$3-1,$4,$1,$6,$5}' > ${output_id2}_${smpId}.bed


# mkdir homerPeaksOut
# mv $smpId.txt homerPeaksOut
# mv $smpId.bed homerPeaksOut

ls | grep -v homerPeaks | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf

trap "ls | grep -v homerPeaks | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit




######################################









