#!/bin/sh
# set -x
# This script is to summary the stats for processed data (submitted workflows)

# paste path for the file of workflow ids and your file should be white space delimited
# input="/Users/meijs/repositories/misc/Ivar/SB_wf_id_test.txt"
input="SciApps_B73v5_alignment_workflows1.txt"

while IFS=" " read -r  wfId wfName
do
  echo $wfId
  # wfId="a6d482b6-5f58-463c-a6e7-07dac4e5bea6"
  echo $wfName
  jobIds=$(curl -s -X GET --header 'Accept: application/json' "https://www.sciapps.org/workflow/$wfId" | jq '.data.steps[].jobId')
  echo $jobIds
  jobIds=$(eval echo \$$jobIds)

  for jobId in ${jobIds[@]}
  do
    echo $jobId
    # jobId="1014183682698767895-242ac116-0001-007"
    archivePath=$(curl -X GET --header 'Accept: application/json' "https://www.sciapps.org/job/$jobId" | jq '.data.archivePath')
    archivePath=$(eval echo \$$archivePath)
    echo $archivePath
    icd /iplant/home/$archivePath
    iget -f job-for-mcrna-0-0-1.err

    oriRds=$(grep "Input:" job-for-mcrna-0-0-1.err | cut -f 2 | cut -f 1 -d " ")
    percTrimRds=$(grep "Result:" job-for-mcrna-0-0-1.err | cut -f 2 | cut -f 2 -d "(" | cut -f 1 -d ")")

    ils > contents.txt
    rep=$(grep 'Log.final.out' contents.txt | cut -f 1,2 -d '_')
    alignRes=$(grep 'Log.final.out' contents.txt)
    iget -f $alignRes

    inpRds=$(grep "Number of input reads" $alignRes | cut -f 2)
    uniqRds=$(grep "Uniquely mapped reads %" $alignRes | cut -f 2)
    aveMappedLen=$(grep "Average mapped length" $alignRes | cut -f 2)
    misMatchRate=$(grep "Mismatch rate per base" $alignRes | cut -f 2)
    percMulMapper=$(grep "% of reads mapped to multiple loci" $alignRes | cut -f 2)
    percUnmapShort=$(grep "% of reads unmapped: too short" $alignRes | cut -f 2)
    percUnmapOther=$(grep "% of reads unmapped: other" $alignRes | cut -f 2)

    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' $wfId $wfName $jobId $rep $oriRds $percTrimRds $inpRds $uniqRds $aveMappedLen $misMatchRate $percMulMapper $percUnmapShort $percUnmapOther >> statsSummary.txt

  done

done < $input



#######
