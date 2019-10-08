

module load STAR/2.7.0d

cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/fq

ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $2; };}' ./smp_names.dat)
# ARRAYFILE2=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $2; };}' ./smp_names.dat)


#
date


# STAR --genomeDir /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref --readFilesIn ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq --outSAMunmapped Within \
#  --outSAMattributes NH HI AS NM MD    --outFilterMultimapNmax 10   --outFilterMismatchNmax 999   \
#  --outFilterMismatchNoverReadLmax 0.04   --alignIntronMin 20   --alignIntronMax 1000000   --alignMatesGapMax 1000000   \
#  --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outSAMtype BAM SortedByCoordinate  \
#  --outFilterScoreMinOverLread 0.85  --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outFileNamePrefix ${ARRAYFILE}_ \
#  --clip5pNbases 0 --seedSearchStartLmax 30 --runThreadN 8 --genomeLoad LoadAndKeep --limitBAMsortRAM 30000000000 --outSAMheaderCommentFile commentsENCODElong.txt --outSAMheaderHD @HD VN:1.4 SO:coordinate

# STAR --genomeDir /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref --readFilesIn ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq \
#  --outSAMattributes NH HI AS nM NM MD    --outFilterMultimapNmax 20   --outFilterMismatchNmax 999   \
#  --alignIntronMin 20 \
#  --alignSJDBoverhangMin 3 --outSAMtype BAM SortedByCoordinate  \
#  --outFilterScoreMinOverLread 0.85 --outFilterMatchNminOverLread 0.66 --outFileNamePrefix ${ARRAYFILE}_ \
#  --clip5pNbases 0 --seedSearchStartLmax 30 --runThreadN 8

# STAR --genomeDir /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref --readFilesIn ss.${ARRAYFILE}_R1.fq ss.${ARRAYFILE}_R2.fq --outSAMunmapped Within \
#  --outSAMattributes NH HI AS NM MD    --outFilterMultimapNmax 10   --outFilterMismatchNmax 10   \
#  --outFilterMismatchNoverReadLmax 1   --alignIntronMin 20   --alignIntronMax 1000000   --alignMatesGapMax 1000000   \
#  --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outSAMtype BAM SortedByCoordinate  \
#  --outFilterScoreMinOverLread 0.85  --outFilterMatchNminOverLread 0.85 --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outFileNamePrefix ${ARRAYFILE}_ \
#  --clip5pNbases 0 --seedSearchStartLmax 30 --runThreadN 8 --genomeLoad LoadAndKeep --limitBAMsortRAM 30000000000 --outSAMheaderCommentFile commentsENCODElong.txt --outSAMheaderHD @HD VN:1.4 SO:coordinate
# 
# 
# 
# STAR --inputBAMfile ${ARRAYFILE}_Aligned.sortedByCoord.out.bam --bamRemoveDuplicatesType UniqueIdentical --runThreadN 8 --runMode inputAlignmentsFromBAM \
# --outFileNamePrefix ${ARRAYFILE}_markdup.



STAR --genomeDir /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/ref --readFilesIn ${ARRAYFILE}_R1_001.fastq.gz ${ARRAYFILE}_R2_001.fastq.gz --outSAMunmapped Within \
 --outSAMattributes NH HI AS NM MD    --outFilterMultimapNmax 10   --outFilterMismatchNmax 10   \
 --outFilterMismatchNoverReadLmax 1   --readFilesCommand zcat --alignIntronMin 20   --alignIntronMax 1000000   --alignMatesGapMax 1000000   \
 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outSAMtype BAM SortedByCoordinate  \
 --outFilterIntronMotifs RemoveNoncanonicalUnannotated --outFileNamePrefix ${ARRAYFILE}_ \
 --clip5pNbases 0 --seedSearchStartLmax 30 --runThreadN 8 --genomeLoad LoadAndKeep --limitBAMsortRAM 30000000000 --outSAMheaderCommentFile commentsENCODElong.txt --outSAMheaderHD @HD VN:1.4 SO:coordinate



STAR --inputBAMfile ${ARRAYFILE}_Aligned.sortedByCoord.out.bam --bamRemoveDuplicatesType UniqueIdentical --runThreadN 8 --runMode inputAlignmentsFromBAM \
--outFileNamePrefix ${ARRAYFILE}_markdup.

date

