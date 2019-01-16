#!/bin/bash


# Input can be either a file or a folder.
# now input is a file rather than a folder
seqFile="${seqFile}"

#output folder name, fixed

#options/parameters
extract="${extract}"

#adapters="${adapters}"

#adaptersFile=$(basename ${adapters})


runthis=''

## PRE-PROCESSING INPUTS,


# move out the file from INPUT if INPUT is a folder

# if [ -d "$seqFile" -a $(ls $seqFile | wc -l) == 1 ]; then
# inp_name=$(ls $seqFile)
# mv $seqFile/$inp_name .
# #rm -rf $seqFile
# seqFile=${inp_name}
# fi

#echo $seqFile

# gunzip input files if needed, but it is not necessary for fastqc because it can take gzipped files
#data_ext="${seqFile##*.}"
#if [ ${data_ext} = "gz" ]; then gunzip $seqFile; seqFile=${seqFile%.*}; fi

smpId=${seqFile%%.*}

################
if [ "$extract" = 1 ]; then
runthis="$runthis --extract"
else
runthis="$runthis --noextract"

fi

#if [ -n "$fastqcOut" ]; then
#mkdir $fastqcOut
#runthis="$runthis --outdir $fastqcOut"
#fi


output_id1="fastqcOut"
output_id2="fastqcZip"


echo $runthis

#if [ -d "$seqFile" ]; then
#	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc -t 4 ${runthis} $seqFile/*"
#	singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc -t 4 ${runthis} $seqFile/*
#else
#	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc -t 4 ${runthis} $seqFile"
#	singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc -t 4 ${runthis} $seqFile
#fi

echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc ${runthis} $seqFile"
singularity exec -B /scratch:/scratch /scratch/tacc/images/fastqc-2016-08-01-1fa01d83b22a.img fastqc ${runthis} $seqFile

mv *.html ${output_id1}_${smpId}.html
mv *.zip ${output_id2}_${smpId}.zip


ls | grep -v fastqcOut | grep -v fastqc | grep -v "\.err" | grep -v "\.out" | xargs rm -rf
trap "ls | grep -v fastqcOut | grep -v fastqc | grep -v "\.err" | grep -v "\.out" | xargs rm -rf" exit









