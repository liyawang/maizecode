#!/bin/sh
# 07/24/20
# Check and submit a new workflow if old workflow failed
# e.g., ./check.sh wf_id B73 endo Rampage B73v5

# Retrieve SciApps token for job submission
token=$(curl -sk -H 'user: YOUR_CyVerse_USERNAME' -H 'pass: YOUR_CyVerse_PASSWD' https://www.sciapps.org/user | jq '.data.token')
token=$(eval echo \$$token)
export SciApps_HDR="Authorization: Bearer $token"
#echo $SciApps_HDR

if [ -z "$5" ]; then
  echo -e "Please provide five inputs (e.g., ./check.sh wf_id B73 endo Rampage B73v5) to run this script"
  exit 1
fi

jobid=$(curl -s -X GET --header 'Accept: application/json' "https://www.sciapps.org/workflow/$1" | jq '.data.steps[] | select(.id=="1") | .jobId')

if [ -z "$jobid" ]; then
    echo "Workflow not found"
    exit 1
fi

id=$(eval echo \$$jobid)
status=$(curl -s -X GET --header 'Accept: application/json' "https://www.sciapps.org/job/$id" | jq '.data.status')
status=$(eval echo \$$status)
#echo "$status" 

if [[ "$status" != "FAILED" ]]; then
   jobid=$(curl -s -X GET --header 'Accept: application/json' "https://www.sciapps.org/workflow/$1" | jq '.data.steps[] | select(.id=="2") | .jobId')
   id=$(eval echo \$$jobid)
   status2=$(curl -s -X GET --header 'Accept: application/json' "https://www.sciapps.org/job/$id" | jq '.data.status')
   status2=$(eval echo \$$status2)
   #echo "$id $status2"
   if [[ "$status2" != "FAILED" ]]; then
     echo "Workflow is OK!"
     exit 0
   fi
fi
echo "Need to rerun the workflow"

# Prepare a new workflow
cp wf.json wf1.json
sed -i -e "s/wf_id/$1/" wf1.json
genome="$2"
tise="$3"
assy="$4"
gindex="$5"

case "${tise}" in
   "cn") tise2="CNs"
   ;;
   "endo") tise2="endosperm"
   ;;
   *) tise2="${tise}"
   ;;
esac

workflow_desc="${assy}%20of%20maize%3A%20${genome}%20${tise2}%20with%20two%20replicates%20%28aligned%20to%20${gindex}%29"
ARG="https://www.sciapps.org/workflowJob/new?runWorkflowJob=1&workflow_name=M_${genome}_${gindex}_${tise}_${assy}&workflow_desc=${workflow_desc}"

# Submit the workflow and retrieve the workflow id
id=$(curl -X POST -sk -H "user: maizecode" -H "$SciApps_HDR" "$ARG" -F "fileToUpload=@wf1.json" | jq '.data.workflow_id')

if [ -z "$id" ]; then
    echo "Workflow submission failed"
else
    id=$(eval echo \$$id) # To get rid of double quotes
    echo "${id} ${genome} ${tise} ${assy} ${gindex}"
    # Delete the failed workflow
    curl -s -X GET --header 'Accept: application/json' -H "user: maizecode" -H "$SciApps_HDR" "https://www.sciapps.org/workflow/$1/delete"
    echo -e "\n"
fi
