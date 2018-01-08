#!/bin/bash

# set -x 


read1="${read1}" # have to keep {}
read2="${read2}"

# echo $read1
# echo $read2

# echo ${read1}
# echo ${read2}

adapters="${adapters}"

# adaptersFile=$(basename ${adapters})

quality="${quality}"

runthis=''

read1Out=$read1


data_ext="${read1##*.}"
if [ ${data_ext} = "gz" ]; then 
	# gunzip $read1
	read1Out=${read1%.*}
else
	read1Out=$read1
fi # can't use ${read1} for $read1, as long as rename a variable

if [ -n "$read2" ]; then
	read2Out=$read2
	data_ext="${read2##*.}"
	if [ ${data_ext} = "gz" ]; then 
		# gunzip $read2
		read2Out=${read2%.*}
	else
		read2Out=$read2
		
	fi
fi

# echo $read1
# echo $read2

# echo $read1Out
# echo $read2Out




################


if [ -n "${adapters}" ]; then runthis="$runthis -a $adapters"; fi
if [ -n "${quality}" ]; then runthis="$runthis -q ${quality}"; fi


singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe --version


# scythe $runthis -o "sc_"$read1Out $read1
echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"$read1Out $read1"
singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"$read1Out $read1

if [ -n "$read2" ]; then	
	# scythe $runthis -o "sc_"$read2Out $read2
	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"$read2Out $read2"
	singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"$read2Out $read2

fi

# if [[ "$Input" =~ .*\.gz$ ]]; then
# #gunzip $Input
# Input=$(basename $Input .gz)
# #scythe $runthis -o "sc_"${Input} ${Input}".gz"
# echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"${Input} ${Input}".gz""
# singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"${Input} ${Input}".gz"

# else
# #scythe $runthis -o "sc_"${Input} ${Input}
# echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"${Input} ${Input}"
# singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img scythe $runthis -o "sc_"${Input} ${Input}

# fi



gzip sc_*


mkdir scytheOutR1

mv "sc_"$read1Out.gz scytheOutR1


mkdir scytheOutR2

if [ -n "$read2" ]; then
    mv "sc_"$read2Out.gz scytheOutR2
fi



#Input1=$(basename ${seqFolder});
#
#mkdir sc_$Input1
#
#for x in $Input1/*
#do
#    if [[ $x =~ .*\.fq$ || $x =~ .*\.fastq$ ]]; then
#    z=$(basename $x)
#    N=$(echo "$z" | sed 's/\..*$//');
#    echo N $N
#    echo scythe $runthis -o "sc_"${N}.fq $x
#    scythe $runthis -o "sc_"${N}.fq $x
#    mv "sc_"${N}.fq sc_$Input1
#    fi
#done



ls | grep -v scytheOut | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf
trap "ls | grep -v scytheOut | grep -v "\.err" | grep -v "\.out"  | grep -v ipcexe | xargs rm -rf" exit







