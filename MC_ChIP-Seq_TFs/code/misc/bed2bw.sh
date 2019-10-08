#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N bedTobw.DJ
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=2G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out



cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/homer_peaks_v4_q20_r2_10chr

# ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $1; };}' ./smp_names.dat)
# ARRAYFILE2=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $2; };}' ./smp_names.dat)


bedtools genomecov -bg -i RA1_rep1_peaks.bed > ../bigwig/RA1_rep1_peaks.bdg

sort -k1,1 -k2,2n ../bigwig/RA1_rep1_peaks.bdg > ../bigwig/RA1_rep1_peaks.sorted.bdg

/sonas-hs/ware/hpc/home/xwang/software/bg2bigwig/bedGraphToBigWig ../bigwig/RA1_rep1_peaks.sorted.bdg /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.10chr.sizes ../bigwig/RA1_rep1_peaks.bw


bedtools genomecov -bg -i RA1_rep2_peaks.bed > ../bigwig/RA1_rep2_peaks.bdg

sort -k1,1 -k2,2n ../bigwig/RA1_rep2_peaks.bdg > ../bigwig/RA1_rep2_peaks.sorted.bdg

/sonas-hs/ware/hpc/home/xwang/software/bg2bigwig/bedGraphToBigWig ../bigwig/RA1_rep2_peaks.sorted.bdg /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.10chr.sizes ../bigwig/RA1_rep2_peaks.bw


bedtools genomecov -bg -i CT_RA1_rep1_peaks.bed > ../bigwig/CT_RA1_rep1_peaks.bdg

sort -k1,1 -k2,2n ../bigwig/CT_RA1_rep1_peaks.bdg > ../bigwig/CT_RA1_rep1_peaks.sorted.bdg

/sonas-hs/ware/hpc/home/xwang/software/bg2bigwig/bedGraphToBigWig ../bigwig/CT_RA1_rep1_peaks.sorted.bdg /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.10chr.sizes ../bigwig/CT_RA1_rep1_peaks.bw


bedtools genomecov -bg -i CT_RA1_rep2_peaks.bed > ../bigwig/CT_RA1_rep2_peaks.bdg

sort -k1,1 -k2,2n ../bigwig/CT_RA1_rep2_peaks.bdg > ../bigwig/CT_RA1_rep2_peaks.sorted.bdg

/sonas-hs/ware/hpc/home/xwang/software/bg2bigwig/bedGraphToBigWig ../bigwig/CT_RA1_rep2_peaks.sorted.bdg /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.10chr.sizes ../bigwig/CT_RA1_rep2_peaks.bw
