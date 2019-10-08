#!/bin/bash
# specify BASH shell
#$ -S /bin/bash
#$ -N star_index_B73_10chr.DJ
# run job in the current working directory where qsub is executed from
#$ -cwd
# specify that the job requires 16GB of memory
#$ -l m_mem_free=4G
#$ -pe threads 8
# help scheduling if you know how long job will run (here: 2 hours, 30 min, zero secs)
#$ -e /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/err
#$ -o /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/out

# module load Python/2.7.11

cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/


STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ./ --genomeFastaFiles \
./Zea_mays.AGPv4.35.10chr.fa --sjdbGTFfile ./genes.gtf --sjdbOverhang 150
