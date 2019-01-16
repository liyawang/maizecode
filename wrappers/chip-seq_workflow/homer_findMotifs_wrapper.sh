#!/bin/bash
#perl ./configureHomer.pl -install
#export PATH=$PATH:./bin
#
#
##echo $PWD
#set -x

peakFile="${peakFile}"


# if [ -d "$peakFile" -a $(ls $peakFile | wc -l) == 1 ]; then
# inp_name=$(ls $peakFile)
# mv $peakFile/$inp_name .
# # rm -rf $read1
# peakFile=${inp_name}
# fi

# smpId=${peakFile%.*}
if [[ "$peakFile" =~ homerPeaks_* ]]; then
	smpId=${peakFile#homerPeaks_}
	smpId=${smpId%%.*}
else
	smpId=${peakFile%%.*}
fi

output_id1="homerMotif"

genome="${genome}"
genomeVer="${genomeVer}"

mask="${mask}"

len="${len}"

size="${size}"


norevopp="${norevopp}"
nomotif="${nomotif}"

dumpFasta="${dumpFasta}"


runthis=''


################


if [ "$mask" = 1 ]; then
runthis="$runthis -mask"
else
runthis=$runthis
fi

if [ -n "${len}" ]; then runthis="$runthis -len $len"; fi
if [ -n "${size}" ]; then runthis="$runthis -size $size"; fi

if [ "$norevopp" = 1 ]; then
runthis="$runthis -norevopp"
else
runthis=$runthis
fi

if [ "$nomotif" = 1 ]; then
runthis="$runthis -nomotif"
else
runthis=$runthis
fi

if [ "$dumpFasta" = 1 ]; then
runthis="$runthis -dumpFasta"
else
runthis=$runthis
fi

# mkdir homerMotifsOut

echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img findMotifsGenome.pl $peakFile $genome ${output_id1}_${smpId} $runthis"
singularity exec -B /scratch:/scratch /scratch/tacc/images/homer_4.9.1--pl5.22.0_5.img findMotifsGenome.pl $peakFile $genome ${output_id1}_${smpId} $runthis


#echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img findMotifsGenome.pl $peakFile $genome $genomeVer homerMotifsOut $runthis"
#singularity exec -B /scratch:/scratch /scratch/tacc/images/homer-2015-11-10-4604b6dca295.img findMotifsGenome.pl $peakFile $genome $genomeVer homerMotifsOut $runthis

ls | grep -v homerMotif | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf
trap "ls | grep -v homerMotif | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit





