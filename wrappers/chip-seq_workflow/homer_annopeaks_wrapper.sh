#!/bin/bash
#perl ./configureHomer.pl -install
#export PATH=$PATH:./bin
#
#
##echo $PWD
#set -x

peakFile="${peakFile}"

# if [ -d "$peakFile" -a $(ls $peakFile | wc -l) == 1 ]; then
# 	inp_name=$(ls $peakFile)
# 	mv $peakFile/$inp_name .
# 	# rm -rf $read1
# 	peakFile=${inp_name}
# fi

# smpId=${peakFile%.*}
if [[ "$peakFile" =~ homerPeaks_* ]]; then
	smpId=${peakFile#homerPeaks_}
	smpId=${smpId%%.*}
else
	smpId=${peakFile%%.*}
fi

output_id1="homerPeaksAnno"


custom_Anno="${custom_Anno}"

# if [ -n "${custom_Anno}" ]; then
# customAnnoFile=$(basename ${custom_Anno})
# fi

#gff3="${gff3}"
#gtf="{gtf}"
#gff="{gff}"
genomeVer="${genomeVer}"

# reference="${reference}"
reference="${reference}"
# if [ -n "${reference}" ]; then
# referenceItem=$(basename ${reference})
# fi


runthis=''


################


# INPUT_Ref=$(basename ${reference});
if [ -n "${genomeVer}" ]; then runthis="$runthis $genomeVer"; fi
if [ -n "${reference}" ]; then runthis="$runthis $reference"; fi

if [ -n "${custom_Anno}" ]; then
	if [[ ${custom_Anno} =~ .*\.gff3 ]]; then
		runthis="$runthis -gff3 ${custom_Anno}"
		echo $runthis
	elif [[ ${custom_Anno} =~ .*\.gff ]]; then
		runthis="$runthis -gff ${custom_Anno}"
	elif [[ ${custom_Anno} =~ .*\.gtf ]]; then
		runthis="$runthis -gff ${custom_Anno}"
	fi
fi

# mkdir homerAnnoOut


#echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img /home/user1/homer/bin/annotatePeaks.pl $peakDirItem $runthis > $homerOut"
#singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img /home/user1/homer/bin/annotatePeaks.pl $peakDirItem $runthis > $homerOut


echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img annotatePeaks.pl $peakFile $runthis > ${output_id1}_${smpId}.txt"
singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img annotatePeaks.pl $peakFile $runthis > ${output_id1}_${smpId}.txt



ls | grep -v homerPeaksAnno | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf
trap "ls | grep -v homerPeaksAnno | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit




