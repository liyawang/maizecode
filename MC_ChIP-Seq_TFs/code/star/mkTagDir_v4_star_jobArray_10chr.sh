


cd /sonas-hs/ware/hpc_norepl/data/xwang/maizeCode/DJ/062819_data/star


ARRAYFILE=$(awk -v line=$SGE_TASK_ID '{if (NR == line) { print $1; };}' ./smp_names.dat)


# makeTagDirectory ../homer_v4_star/${ARRAYFILE}_tagDir -tbp 1 -single ${ARRAYFILE}_markdup.Processed.out.bam

makeTagDirectory ../homer_v4_star_0.85/${ARRAYFILE}_tagDir -tbp 1 -single ${ARRAYFILE}_Aligned.sortedByCoord.out.bam
