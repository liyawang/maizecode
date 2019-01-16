#!/bin/bash


# set -x
#
bamInput="${bamInput}"
# smpId="${smpId}"

# if [ -d "$bamInput" ]; then
# # inp_name=$(basename $(ls $bamInput/*.bam))
# # this regular express is broader than sam bam Bed ect, like bem or sed, which don't need
# inp_name=$(basename $(ls $bamInput/*\.[bBsS][aAeE][mMdD]))
# mv $bamInput/* .
# # rm -rf $bamInput
# bamInput=${inp_name}
# fi

# smpId=${bamInput%.*}
if [[ "$bamInput" =~ picard1_* ]]; then
	smpId=${bamInput#picard1_}
	smpId=${smpId%%.*}
else
	smpId=${bamInput%%.*}
fi

# ctrlIndicator="${ctrlIndicator}"
# if [ ${ctrlIndicator} = 1 ]; then
# 	smpId+="_ctrl"
# fi

tbp="${tbp}"
format="${format}"

single="${single}"
runthis=''




################

if [ -n "${tbp}" ]; then runthis="$runthis -tbp $tbp"; fi
if [ -n "${format}" ]; then runthis="$runthis -format $format"; fi

if [ ${single} = 1 ]; then
runthis="$runthis -single"
else
runthis=$runthis
fi



# mkdir homerTagDir
output_id1="homerTagDir"



echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img /home/user1/homer/bin/makeTagDirectory ${output_id1}_${smpId} $runthis $bamInput"
singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img /home/user1/homer/bin/makeTagDirectory ${output_id1}_${smpId} $runthis $bamInput

#singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img /home/user1/homer/bin/getDifferentialPeaksReplicates.pl -h



#rm -rf "$Input1"

ls | grep -v homerTagDir | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf
trap "ls | grep -v homerTagDir | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit





######################################









