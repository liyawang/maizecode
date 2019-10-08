

cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/fq

ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $1; };}' ./smp_names.dat)
ARRAYFILE2=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $2; };}' ./smp_names.dat)

# mv ${ARRAYFILE2}_R1_001.fastq.gz ${ARRAYFILE}_R1.fastq.gz 
# mv ${ARRAYFILE2}_R2_001.fastq.gz ${ARRAYFILE}_R2.fastq.gz 


# fastqc -o ../fastqc_out ${ARRAYFILE}_R1.fastq.gz ${ARRAYFILE}_R2.fastq.gz 

# scythe -a ../illumina_adapters_all.fa -o sc.${ARRAYFILE}_R1.fq ${ARRAYFILE}_R1.fastq.gz
# scythe -a ../illumina_adapters_all.fa -o sc.${ARRAYFILE}_R2.fq ${ARRAYFILE}_R2.fastq.gz 
#
#
###sickle-1.33
# sickle pe -t sanger -l 50 -f sc.${ARRAYFILE}_R1.fq -r sc.${ARRAYFILE}_R2.fq -o ss.${ARRAYFILE}_R1.fq -p ss.${ARRAYFILE}_R2.fq -s ss.${ARRAYFILE}_single.fq
#
#
# fastqc -o ../fastqc_out ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq

# multiqc ../fastqc_out/${ARRAYFILE}_R1_fastqc.zip ../fastqc_out/${ARRAYFILE}_R2_fastqc.zip ../fastqc_out/ss.${ARRAYFILE}_R1_fastqc.zip ../fastqc_out/ss.${ARRAYFILE}_R2_fastqc.zip -n ${ARRAYFILE}_multiQC
#
#
## BWA: Version: 0.7.10-r789
## samtools: Version: 0.1.19-44428cd
## try to re-run with "-f 2 -q 30" (11.22.16)

date
# 
# bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq > ${ARRAYFILE}.sam
# 
# bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -f 2 -q 30 -ubS - | samtools sort - ../sorted_bam_v4_q30_r2_10chr/${ARRAYFILE}.sorted
# bwa mem -t 8 -k 30 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -f 2 -q 30 -ubS - | samtools sort - ../sorted_bam_v4_q30_r2_10chr/${ARRAYFILE}.sorted

# bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -f 2 -q 20 -ubS - | samtools sort - ../sorted_bam_v4_q20_r2_10chr/${ARRAYFILE}.sorted
# samtools index ../sorted_bam_v4_q20_r2_10chr/${ARRAYFILE}.sorted.bam
# 
# 
# bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -f 2 -ubS - | samtools sort - ../sorted_bam_v4_r2_10chr/${ARRAYFILE}.sorted
# samtools index ../sorted_bam_v4_r2_10chr/${ARRAYFILE}.sorted.bam
# 

# bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -ubS - | samtools sort - ../sorted_bam_v4_10chr/${ARRAYFILE}.sorted
# samtools index ../sorted_bam_v4_10chr/${ARRAYFILE}.sorted.bam

bwa mem -t 8 -M /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref/Zea_mays.AGPv4.35.10chr.fa ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq | samtools view -f 2 -q 40 -ubS - | samtools sort - ../sorted_bam_v4_10chr_q40/${ARRAYFILE}.sorted
samtools index ../sorted_bam_v4_10chr_q40/${ARRAYFILE}.sorted.bam

echo "time"
# 
date
# 
##If there are some errors about sorting, try add "AS=TURE"
#
# java -jar /sonas-hs/ware/hpc/home/xwang/software/Picard_2.7.0/picard.jar MarkDuplicates I=../sorted_bam_v4_q30_r2_10chr/${ARRAYFILE}.sorted.bam O=../sorted_bam_v4_q30_r2_markDup_10chr/${ARRAYFILE}_markDup.sorted.bam M=../sorted_bam_v4_q30_r2_markDup_metrics_10chr/${ARRAYFILE}_markDup_metrics.txt VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE
#
# samtools index ../sorted_bam_v4_q30_r2_markDup_10chr/${ARRAYFILE}_markDup.sorted.bam
#
