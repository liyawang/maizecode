#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N align_v2PeaksTov4Peaks.DJ
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=8G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out



cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/andrea_ori_Peak

bwa index RA1_deduct_final.fa
bwa index RA1_rep1_peaks_midPoint_q40_F6L2LP_common_rep1.fa

bwa mem -t 8 RA1_deduct_final.fa RA1_common_ear_MACS_summits_HA_YFP_v2.fa | samtools view -ubS - | samtools sort - RA1_deduct_final_RA1_summitV2.sorted

samtools index RA1_deduct_final_RA1_summitV2.sorted.bam

bwa mem -t 8 RA1_rep1_peaks_midPoint_q40_F6L2LP_common_rep1.fa RA1_common_ear_MACS_summits_HA_YFP_v2.fa | samtools view -ubS - | samtools sort - RA1_rep1_peaks_midPoint_q40_F6L2LP_common_rep1_RA1_summitV2.sorted

samtools index RA1_rep1_peaks_midPoint_q40_F6L2LP_common_rep1_RA1_summitV2.sorted.bam