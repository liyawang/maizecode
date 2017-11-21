#!/bin/bash


#set -x

# Input can be either a file or a folder.
seqDir1="${seqDir1}"
seqDir2="${seqDir2}"

echo $seqDir1
echo $seqDir2

#If the inputs are folder, then the file in the folder should be moved out
# if [ -d "$seqDir1" -a $(ls $seqDir1 | wc -l) == 1 ]; then
# inp_name=$(ls $seqDir1)
# mv $seqDir1/$inp_name .
# seqDir1=${inp_name}
# fi


# if [ -d "$seqDir2" -a $(ls $seqDir2 | wc -l) == 1 ]; then
# inp_name=$(ls $seqDir2)
# mv $seqDir2/$inp_name .
# seqDir2=${inp_name}
# fi

if [ -d "$seqDir1" ]; then
    folderItems=$(ls $seqDir1)
    folderItemsArray=(${folderItems////})
    inp_name=${folderItemsArray[0]}
    mv $seqDir1/$inp_name .
    seqDir1=${inp_name}
fi


if [ -d "$seqDir2" ]; then
    folderItems=$(ls $seqDir2)
    folderItemsArray=(${folderItems////})
    inp_name=${folderItemsArray[0]}
    mv $seqDir2/$inp_name .
    seqDir2=${inp_name}
fi

echo $seqDir1
echo $seqDir2

# gunzip input files if needed, but it is not necessary for sickle because it can take gzipped files
#data_ext="${seqDir1##*.}"
#if [ ${data_ext} = "gz" ]; then gunzip $seqDir1; seqDir1=${seqDir1%.*}; fi
#data_ext="${seqDir2##*.}"
#if [ ${data_ext} = "gz" ]; then gunzip $seqDir2; seqDir2=${seqDir2%.*}; fi



type="${type}"
length="${length}"
quality="${quality}"

# gzip=1

runthis=''




################

if [ -n "${type}" ]; then runthis="$runthis -t ${type}"; fi
if [ -n "${length}" ]; then runthis="$runthis -l ${length}"; fi
if [ -n "${quality}" ]; then runthis="$runthis -q ${quality}"; fi
if [ -n "$seqDir1" ]; then runthis="$runthis -f $seqDir1"; fi




if [ -n "$seqDir2" ]; then
    runthis="$runthis -r $seqDir2"

    if [[ "$seqDir1" =~ .*\.gz$ ]] && [[ "$seqDir2" =~ .*\.gz$ ]]; then
    	seqDir1=$(basename $seqDir1 .gz)
    	seqDir2=$(basename $seqDir2 .gz)
    	echo "sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir2 -s "ss_single.fq""
    	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir1 -s "ss_single.fq""
        # sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir2 -s "ss_single.fq
        singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir1 -s "ss_single.fq"
	else
        if [[ "$seqDir1" =~ .*\.gz$ ]] || [[ "$seqDir2" =~ .*\.gz$ ]]; then
            echo "Both inputs should be gzipped or not."
        else
            echo "sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir2 -s "ss_single.fq""
            echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir1 -s "ss_single.fq""
            # sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir2 -s "ss_single.fq"
            singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o "ss_"$seqDir1 -p "ss_"$seqDir1 -s "ss_single.fq"
        fi
    fi

else
	if [[ "$seqDir1" =~ .*\.gz$ ]]; then
    	seqDir1=$(basename $seqDir1 .gz)
    	echo "sickle se $runthis -o "ss_"$seqDir1"
    	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o "ss_"$seqDir1"
    	# sickle se $runthis -o "ss_"$seqDir1
    	singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o "ss_"$seqDir1
    else
    	echo "sickle se $runthis -o "ss_"$seqDir1"
    	echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o "ss_"$seqDir1"
        # sickle se $runthis -o "ss_"$seqDir1
        singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o "ss_"$seqDir1
	fi

fi

gzip ss_*

#
mkdir sickleOut
#
mv ss_* sickleOut





ls | grep -v sickleOut | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf
trap "ls | grep -v sickleOut | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit
















