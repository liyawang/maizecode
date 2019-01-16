#!/bin/bash
#perl ./configureHomer.pl -install
#export PATH=$PATH:./bin


#echo $PWD
#set -x

#module load foss/2017b
#module load Python/2.7.14

#cd /sonas-hs/ware/hpc_norepl/data/xwang/sorghum_encode/agave/deeptool

#bamFiles="G3_P_H3_rep1_chr8_R_rmDup.sorted.bam G3_P_H3_rep2_chr8_R_rmDup.sorted.bam"
bamFiles="${bamFiles}"

arr=($(echo ${bamFiles} | tr " " "\n"))

##########
#bamCoverage
normMe="${normMe}"
binSize1="${binSize1}" #coverage
effectiveGenSize="${effectiveGenSize}"



runthis1=''
#######



##########
#multiBigwigSummary and multiBamSummary
binSize2=${binSize2} #count binsize
labels="${labels}"

# 0 false
smartLabels="${smartLabels}"

#smpId=${peakFile%.*}
output_id1="readCount"
output_id2="plotCor"
output_id3="plotFingerPrint"


#outRawCounts=""

runthis2=''
##########

##########
#plotCorrelation and plotFingerprint
#corMethod="pearson"
#skipZeros=1
#removeOutliers=1
#plotTitle="test_plot"
#whatToPlot="scatterplot"
#plotNumbers=0


corMethod="${corMethod}"
skipZeros="${skipZeros}"
removeOutliers="${removeOutliers}"
plotTitle="${plotTitle}"
whatToPlot="${whatToPlot}"
plotNumbers="${plotNumbers}"
plotFileFormat0="${plotFileFormat0}"



runthis3=''


#plotFingerprint
#minMappingQuality=30
#ignoreDuplicates=0
##labels and smartLabels above
#binSize3=500 #fingerprint bin size
#plotFileFormat="pdf"
#plotTitleFinger=""

minMappingQuality="${minMappingQuality}"
ignoreDuplicates="${ignoreDuplicates}"
#labels and smartLabels above
binSize3="${binSize3}" #fingerprint bin size
plotFileFormat="${plotFileFormat}"
plotTitleFinger="${plotTitleFinger}"

runthis4=''

##########


##########
if [ -n "${binSize2}" ]; then runthis2="$runthis2 --binSize $binSize2"; fi
if [ -n "${labels}" ]; then runthis2="$runthis2 --labels $labels"; fi

if [ "$smartLabels" = 1 ]; then
runthis2="$runthis2 --smartLabels"
else
runthis2=$runthis2
fi
##########

##########
if [ -n "${normMe}" ]; then runthis1="$runthis1 --normalizeUsing $normMe"; fi
if [ -n "${binSize1}" ]; then runthis1="$runthis1 --binSize $binSize1"; fi
if [ -n "${effectiveGenSize}" ]; then runthis1="$runthis1 --effectiveGenomeSize $effectiveGenSize"; fi
##########


##########
if [ -n "${corMethod}" ]; then runthis3="$runthis3 --corMethod $corMethod"; fi

if [ "$skipZeros" = 1 ]; then
runthis3="$runthis3 --skipZeros"
else
runthis3=$runthis3
fi


if [ "$removeOutliers" = 1 ]; then
runthis3="$runthis3 --removeOutliers"
else
runthis3=$runthis3
fi

if [ "$plotNumbers" = 1 ]; then
runthis3="$runthis3 --plotNumbers"
else
runthis3=$runthis3
fi

if [ -n "${plotTitle}" ]; then runthis3="$runthis3 --plotTitle $plotTitle"; fi
if [ -n "${plotFileFormat0}" ]; then runthis4="$runthis4 --plotFileFormat $plotFileFormat0"; fi
if [ -n "${whatToPlot}" ]; then runthis3="$runthis3 --whatToPlot $whatToPlot"; fi
##########

###########
if [ -n "${minMappingQuality}" ]; then runthis4="$runthis4 --minMappingQuality $minMappingQuality"; fi

if [ "$ignoreDuplicates" = 1 ]; then
runthis4="$runthis4 --ignoreDuplicates"
else
runthis4=$runthis4
fi

if [ -n "${binSize3}" ]; then runthis4="$runthis4 --binSize $binSize3"; fi
if [ -n "${plotFileFormat}" ]; then runthis4="$runthis4 --plotFileFormat $plotFileFormat"; fi
if [ -n "${plotTitleFinger}" ]; then runthis4="$runthis4 --plotTitle $plotTitleFinger"; fi
if [ -n "${labels}" ]; then runthis4="$runthis4 --labels $labels"; fi

if [ "$smartLabels" = 1 ]; then
runthis4="$runthis4 --smartLabels"
else
runthis4=$runthis4
fi
########

for item in ${arr[*]}
do
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools index ${item}"
    singularity exec -B /scratch:/scratch /scratch/tacc/images/samtools_1.5--2.img samtools index ${item}
done


if [ -n "${normMe}" ]; then
    bigWigs=""
    for item in ${arr[*]}
    do
        smpId=${item%%.*}
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img bamCoverage -b $item $runthis1 -o ${smpId}.bw"
        singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img bamCoverage -b $item $runthis1 -o ${smpId}.bw
        #bigWigs=$bigWigs${smpId}.bw
        bigWigs+="${smpId}.bw "
    done
    #echo $bigWigs
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img multiBigwigSummary bins -b $bigWigs$runthis2 -out ${output_id1}_nor.npz --outRawCounts ${output_id1}_nor.tab"
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotCorrelation -in ${output_id1}_nor.npz $runthis3 -o ${output_id2}_nor.${plotFileFormat0} --outFileCorMatrix ${output_id2}_nor.tab"
    singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img multiBigwigSummary bins -b $bigWigs$runthis2 -out ${output_id1}_nor.npz --outRawCounts ${output_id1}_nor.tab
    singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotCorrelation -in ${output_id1}_nor.npz $runthis3 -o ${output_id2}_nor.${plotFileFormat0} --outFileCorMatrix ${output_id2}_nor.tab
else
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img multiBamSummary bins -b $bamFiles$runthis2 -out ${output_id1}.npz --outRawCounts ${output_id1}.tab"
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotCorrelation -in ${output_id1}.npz $runthis3 -o ${output_id2}.${plotFileFormat0} --outFileCorMatrix ${output_id2}.tab"
    singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img multiBamSummary bins -b $bamFiles$runthis2 -out ${output_id1}.npz --outRawCounts ${output_id1}.tab
    singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotCorrelation -in ${output_id1}.npz $runthis3 -o ${output_id2}.${plotFileFormat0} --outFileCorMatrix ${output_id2}.tab

fi


echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotFingerprint -b ./*bam $runthis4 --outQualityMetrics ${output_id3}.txt --plotFile ${output_id3}.${plotFileFormat} --outRawCounts ${output_id3}.tab"

singularity exec -B /scratch:/scratch /scratch/tacc/images/deeptools_3.1.2-2018-09-13-949882d538f5.img plotFingerprint -b ./*bam $runthis4 --outQualityMetrics ${output_id3}.txt --plotFile ${output_id3}.${plotFileFormat} --outRawCounts ${output_id3}.tab



#ls | grep -v readCount | grep -v plotCor | grep -v plotFingerPrint | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf
trap "ls | grep -v readCount | grep -v plotCor | grep -v plotFingerPrint | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit








