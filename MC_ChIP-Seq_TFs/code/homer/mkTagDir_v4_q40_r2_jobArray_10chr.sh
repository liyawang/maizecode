#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N homer_makeTagDir_v4_q40_r2_markDup_10chr.DJnew
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=2G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -t 1-24
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out


# cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/sorted_bam_v4_q30_r2_markDup_10chr
cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/sorted_bam_v4_10chr_q40


ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $1; };}' ./smp_names.dat)


# makeTagDirectory ../homer_v4_q30_r2_markDup_10chr/${ARRAYFILE}_tagDir -tbp 1 -single ${ARRAYFILE}_markDup.sorted.bam

makeTagDirectory ../homer_v4_q40_r2_markDup_10chr/${ARRAYFILE}_tagDir -tbp 1 -single ${ARRAYFILE}.sorted.bam
   
