#!/bin/bash

#tar -xzvf bedtools-2.26.0.tar.gz
#cd bedtools2
#make
#export PATH=$PATH:"$PWD/bin"
#cd ../

#echo $PWD

#set -x
#aInput="G1_P_K27me3_H3_rep1_homer.bed"
aInput="${aInput}"
#abam=""
abam="${abam}"
#bInput="G1_P_K27me3_H3_rep2_homer.bed"
bInput="${bInput}"




if [ -d "$aInput" ]; then
    folderItems=$(ls $aInput | grep -i '\.bed')
    folderItemsArray=(${folderItems////})
    inp_name=${folderItemsArray[0]}
    mv $aInput/$inp_name .
    aInput=${inp_name}
fi


if [ -d "$bInput" ]; then
    folderItems=$(ls $bInput | grep -i '\.bed')
    folderItemsArray=(${folderItems////})
    inp_name=${folderItemsArray[0]}
    mv $bInput/$inp_name .
    bInput=${inp_name}
fi

echo "aInput", ${aInput}, $aInput
echo "bInput", ${bInput}, $bInput


#When using BAM input (-abam), the format of output, "-ubam" and "-bed". Default writes compressed BAM.
#bamInpOutFormat=""
bamInpOutFormat="${bamInpOutFormat}"


#Write the original entry in A for each overlap.
#wa="false"
wa="${wa}"


#Write the original entry in B for each overlap.
#wb="false"
wb="${wb}"


#Write the original A and B entries plus the number of base
#pairs of overlap between the two features.
#wo="false"
wo="${wo}"


#Write the original A and B entries plus the number of base
#pairs of overlap between the two features. However, A features
#w/o overlap are also reported with a NULL B feature and overlap = 0
#wao="false"
wao="${wao}"


#Write the original A entry _once_ if _any_ overlaps found in B.
#u="1"
u="${u}"


#For each entry in A, report the number of overlaps with B.
#c="false"
c="${c}"


#Only report those entries in A that have _no overlaps_ with B.
#v="false"
v="${v}"



#Minimum overlap required as a fraction of A.
#f="0.5"
f="${f}"

#Minimum overlap required as a fraction of B.
#F=""
Fb="${Fb}"

#Require that the fraction overlap be reciprocal for A and B.
#r="false"
r="${r}"


#Require strandedness. By default, overlaps are reported without respect to strand.
# -s: require same strandedness. -S: require different strandednes.
#strand=""
strand="${strand}"

runthis=''

echo wa $wa, wb $wb, u $u, v $v, c $c

################


if [ -n "${abam}" ]; then
    if [ -n "${bamInpOutFormat}" ]; then
        runthis="$runthis -${bamInpOutFormat}";
    fi
fi

if [ "$wa" = 1 ]; then runthis="$runthis -wa"; fi

if [ "$wb" = 1 ]; then runthis="$runthis -wb"; fi


if [ "$wo" = 1 ]; then runthis="$runthis -wo"; fi

if [ "$wao" = 1 ]; then runthis="$runthis -wao"; fi

if [ "$u" = 1 ]; then runthis="$runthis -u"; fi


if [ "$c" = 1 ]; then runthis="$runthis -c"; fi


if [[ "$v" = 1 ]]; then runthis="$runthis -v"; fi


if [ -n "${f}" ]; then runthis="$runthis -f ${f}"; fi
if [ -n "${Fb}" ]; then runthis="$runthis -F ${Fb}"; fi



if [ "$r" = 1 ]; then runthis="$runthis -r"; fi


if [ -n "${strand}" ]; then runthis="$runthis -${strand}"; fi


if [ -n "$aInput" ]; then runthis="$runthis -a $aInput"; fi

if [ -n "${abam}" ]; then runthis="$runthis -abam ${abam}"; fi

if [ -n "$bInput" ]; then runthis="$runthis -b $bInput"; fi




# Usage: bedtools intersect [OPTIONS] -a <bed/gff/vcf>|-abam <bam> -b <bed/gff/vcf>

#if [ -n "${aInput}" ]; then InputRep1=$(basename ${aInput}); fi
#if [ -n "${abam}" ]; then InputRep1=$(basename ${abam}); fi

#InputRep2=$(basename ${bInput});

#outputFolder=${outputFolder}
mkdir commonPeaks

smpId=${aInput%.*}_${bInput%.*}


#if [ -n "${aInput}" ]; then intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpName}_interSect.bed; fi

if [ -n "${aInput}" ]; then
    echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bed"
    singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bed
fi


if [ -n "${abam}" ]; then
    if [[ "${bamInpOutFormat}" == "bed" ]]; then
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bed"
        singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bed

    else
        echo "singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bam"
        singularity exec -B /scratch:/scratch /scratch/tacc/images/bedtools_2.26.0gx--0.img intersectBed $runthis | sort -k1,1n -k2,2n > commonPeaks/${smpId}.bam
    fi
fi

ls | grep -v commonPeaks | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf

trap "ls | grep -v commonPeaks | grep -v "\.err" | grep -v "\.out" | grep -v ipcexe | xargs rm -rf" exit



####




