#!/bin/bash


#set -x

# Input can be either a file or a folder.
seq1="${seq1}"
seq2="${seq2}"

echo $seq1
echo $seq2
output_id1="ss1"
output_id2="ss2"


#If the inputs are folder, then the file in the folder should be moved out
# if [ -d "$seq1" -a $(ls $seq1 | wc -l) == 1 ]; then
# inp_name=$(ls $seq1)
# mv $seq1/$inp_name .
# seq1=${inp_name}
# fi


# if [ -d "$seq2" -a $(ls $seq2 | wc -l) == 1 ]; then
# inp_name=$(ls $seq2)
# mv $seq2/$inp_name .
# seq2=${inp_name}
# fi

# if [ -d "$seq1" ]; then
#     folderItems=$(ls $seq1)
#     folderItemsArray=(${folderItems////})
#     inp_name=${folderItemsArray[0]}
#     mv $seq1/$inp_name .
#     seq1=${inp_name}
# fi


# if [ -d "$seq2" ]; then
#     folderItems=$(ls $seq2)
#     folderItemsArray=(${folderItems////})
#     inp_name=${folderItemsArray[0]}
#     mv $seq2/$inp_name .
#     seq2=${inp_name}
# fi

# echo $seq1
# echo $seq2

# gunzip input files if needed, but it is not necessary for sickle because it can take gzipped files
#data_ext="${seq1##*.}"
#if [ ${data_ext} = "gz" ]; then gunzip $seq1; seq1=${seq1%.*}; fi
#data_ext="${seq2##*.}"
#if [ ${data_ext} = "gz" ]; then gunzip $seq2; seq2=${seq2%.*}; fi



type="${type}"
length="${length}"
quality="${quality}"

# gzip=1

runthis=''




################

if [ -n "${type}" ]; then runthis="$runthis -t ${type}"; fi
if [ -n "${length}" ]; then runthis="$runthis -l ${length}"; fi
if [ -n "${quality}" ]; then runthis="$runthis -q ${quality}"; fi
if [ -n "$seq1" ]; then runthis="$runthis -f $seq1"; fi




if [ -n "$seq2" ]; then
    runthis="$runthis -r $seq2"

    if [[ "$seq1" =~ .*\.gz$ ]] && [[ "$seq2" =~ .*\.gz$ ]]; then
    	seq1=$(basename $seq1 .gz)
    	seq2=$(basename $seq2 .gz)
    	# echo "sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id1}_$seq2 -s ${output_id1}_single.fq"
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id2}_$seq2 -s ss_single.fq"
        # sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id1}_$seq2 -s ${output_id1}_single.fq
        singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id2}_$seq2 -s ss_single.fq
	else
        if [[ "$seq1" =~ .*\.gz$ ]] || [[ "$seq2" =~ .*\.gz$ ]]; then
            echo "Both inputs should be gzipped or not."
        else
            # echo "sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id1}_$seq2 -s ${output_id1}_single.fq"
            echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id2}_$seq2 -s ss_single.fq"
            # sickle pe $runthis -o "ss_"$seq1 -p "ss_"$seq2 -s "ss_single.fq"
            singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle pe $runthis -o ${output_id1}_$seq1 -p ${output_id2}_$seq2 -s ss_single.fq
        fi
    fi

else
	if [[ "$seq1" =~ .*\.gz$ ]]; then
    	seq1=$(basename $seq1 .gz)
        echo "sickle se $runthis -o ${output_id1}_$seq1"
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o ${output_id1}_$seq1"
        # sickle se $runthis -o ${output_id1}_$seq1
        singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o ${output_id1}_$seq1
    else
        echo "sickle se $runthis -o ${output_id1}_$seq1"
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o ${output_id1}_$seq1"
        # sickle se $runthis -o ${output_id1}_$seq1
        singularity exec -B /scratch:/scratch /scratch/tacc/images/scythe-2017-09-18-c7268f0a8cd0.img sickle se $runthis -o ${output_id1}_$seq1
	fi

fi

#gzip ss1_*
#gzip ss2_*

gzip ss*

# mk sickleOutR1
# mv "ss_"$seq1.gz sickleOutR1

# mk sickleOutR2

# if [ -n "$seq2" ]; then
#     rm -rf ss_single.fq.gz
#     mv "ss_"$seq2.gz sickleOutR2
# fi





#ls | grep -v "ss1_"  | grep -v "ss2_" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf
#trap "ls | grep -v "ss1_" | grep -v "ss2_" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit


ls | grep -v "ss" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf
trap "ls | grep -v "ss" | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe |xargs rm -rf" exit



















