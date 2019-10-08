#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N bamTobw.DJ
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=2G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -t 1-24
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out



# cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/sorted_bam_v4_q20_r2_10chr

cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/sorted_bam_v4_10chr_q40

ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $1; };}' ./smp_names.dat)
# ARRAYFILE2=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $2; };}' ./smp_names.dat)


bedtools genomecov -bg -ibam ${ARRAYFILE}.sorted.bam > ../bigwig_q40/${ARRAYFILE}.bdg

sort -k1,1 -k2,2n ../bigwig_q40/${ARRAYFILE}.bdg > ../bigwig_q40/${ARRAYFILE}.sorted.bdg

/sonas-hs/ware/hpc/home/xwang/software/bg2bigwig/bedGraphToBigWig ../bigwig_q40/${ARRAYFILE}.sorted.bdg /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.10chr.sizes ../bigwig_q40/${ARRAYFILE}.bw
