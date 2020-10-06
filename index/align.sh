#!/bin/sh
# 07/20/20
# Processing MaizeCODE data via SciApps API
# This is for RNAseq/RAMPAGE only
# $1, (cn, ears, endo, pollen, root); $2, (B73, NC350, W22, Til11); $3, (B73v5, NC350v1, W22v2, Til11v1); $4, (RNAseq, RAMPAGE)
# and we are saving workflow as MC_B73_B73v5_root_RNAseq or MC_B73_B73v5_root_RAMPAGE
# e.g. ./align.sh cn B73 B73v5 RAMPAGE

# Retrieve SciApps token for job submission
token=$(curl -sk -H 'user: [YOUR_CyVerse_USERNAME]' -H 'pass: [YOUR_CyVerse_PASSWORD]' https://www.sciapps.org/user | jq '.data.token')
token=$(eval echo \$$token)
export SciApps_HDR="Authorization: Bearer $token"
#echo $SciApps_HDR

# Prepare workflow submission file
if [ -z "$1" ]; then
  echo -e "\nPlease provide tissue (cn, ears, endo, pollen, root) to run this script"
  exit 1
else
  tise="$1"
fi
if [ -z "$2" ]; then genome="B73"; else genome="$2"; fi
if [ -z "$3" ]; then gindex="B73v5"; else gindex="$3"; fi
if [ -z "$4" ]; then assy="RNAseq"; else assy="$4"; fi

# Define path for MaizeCODE raw data
rootP="/iplant/home/shared/maizecode/released/$genome/Long_Rampage"

cp $assy.json rnaseq1.json
sed -i -e "s/B73/${genome}/g" rnaseq1.json
sed -i -e "s/index/${gindex}/g" rnaseq1.json
sed -i -e "s/root_rep/${tise}_rep/g" rnaseq1.json

case "${tise}" in
   "cn") tise2="CNs"
   ;;
   "endo") tise2="endosperm"
   ;;
   *) tise2="${tise}"
   ;;
esac

workflow_desc="${assy}%20of%20maize%3A%20${genome}%20${tise2}%20with%20two%20replicates%20%28aligned%20to%20${gindex}%29"

# Submit the workflow and retrieve the workflow id
ARG="https://www.sciapps.org/workflowJob/new?runWorkflowJob=1&workflow_name=M_${genome}_${gindex}_${tise}_${assy}&workflow_desc=${workflow_desc}"
#echo $ARG
id=$(curl -X POST -sk -H "user: maizecode" -H "$SciApps_HDR" "$ARG" -F "fileToUpload=@rnaseq1.json" | jq '.data.workflow_id')
id=$(eval echo \$$id) # To get rid of double quotes
echo "${id} ${genome} ${tise} ${assy} ${gindex}"
sleep 2m
