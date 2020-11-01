#!/bin/sh
# 04/03/2019 Modified to deal with changes: step id from number to string, inputSequence1 from [] enclosed to not
# This script takes a workflow id and generate tracks for forward and reverse strand signal of one replicate
#  archivePaths from workflow id (SciApps then Agave API: maizecode/sci_data/results/MCrna-0.0.1_3d1efd2d-423c-404c-9963-731fefe66d74)
#  replicate name from workflow id (inputSequence1:agave://data.iplantcollaborative.org/shared/maizecode/released/B73/Long_Rampage/ears_rep2/RNAseq/ears_rep2_R1.fq.gz)
#   Run as ./createjson.sh 19b9a6b1-1248-40a9-9538-4a8dd93b4490 trackList.json

echo $1

for STEPS in 1 2 3
do
  input1=$(curl -X GET --header "Accept: application/json" "https://www.sciapps.org/workflow/$1" | jq ".data.steps[] | select(.id==$STEPS or .id==\"$STEPS\") | .inputs.inputSequence1")
  # echo "input1: $input1"
  input2=$(echo "$input1" | sed 's/[][]//g')
  # echo "input2: $input2"
  input=$(echo $input2 | sed -e $'s/\r//g')
  # echo "input: $input"
  inputSequence1=$(eval echo \$$input)
  # echo "inputSequence1: $inputSequence1"
  jobid=$(curl -X GET --header "Accept: application/json" "https://www.sciapps.org/workflow/$1" | jq ".data.steps[] | select(.id==$STEPS or .id==\"$STEPS\") | .jobId")
  job_id=$(eval echo \$$jobid) # To get rid of double quotes
  #echo "job_id: $job_id"
  aPath=$(curl -X GET --header "Accept: application/json" "https://www.sciapps.org/job/$job_id" | jq '.data.archivePath')
  archivePath=$(eval echo \$$aPath)
  #echo "archivePath: $archivePath"

  x1=`basename $archivePath`

  fname=`basename $inputSequence1`
  x2="${fname%%.*}"

  x3="${x2%???}"
  # echo "x2: " + $x2
  # echo "x3: " + $x3

  case "$inputSequence1" in
    *RNAseq*) assy="RNAseq"
              clr="purple"
       ;;
    *RAMPAGE*) assy="RAMPAGE"
              clr="teal"
       ;;
    *) echo "Unknown assay"
       exit 1
       ;;
  esac

  # echo $inputSequence1

  case "$inputSequence1" in
    *B73*) genm="B73"
       ;;
    *NC350*) genm="NC350"
       ;;
    *W22*) genm="W22"
       ;;
    *Ti11*) genm="Ti11"
       ;;
    *BTx623*) genm="BTx623"
       ;;
    *) echo "Unknown genome"
       exit 1
       ;;
  esac

  cp my_sorghum.json t.json
  sed -i -e "s/XXX1/$x1/g" t.json
  sed -i -e "s/XXX2/$x2/g" t.json
  sed -i -e "s/XXX3/$x3/g" t.json
  sed -i -e "s/XXX4/$1/g" t.json
  sed -i -e "s/XXX5/$clr/g" t.json
  sed -i -e "s/XXX6/$genm/g" t.json
  sed -i -e "s/XXX7/$assy/g" t.json

  cat t.json >> $2

done

exit


     # {
     #    "style" : {
     #       "pos_color" : "XXX5",
     #       "height" : 50
     #    },
     #    "key" : "XXX3 forward",
     #    "autoscale" : "local",
     #    "urlTemplate" : "https://data.cyverse.org/dav-anon/iplant/home/maizecode/sci_data/results/XXX1/sig_f_XXX2.bw",
     #    "label" : "XXX3 forward",
     #    "type" : "JBrowse/View/Track/Wiggle/XYPlot",
     #    "category" : "MaizeCODE XXX6/XXX3/XXX7",
     #    "onClick"  : {
     #        "url": "https://www.sciapps.org/?wf_id=XXX4"
     #    }
     # },
#
