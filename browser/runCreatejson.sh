#!/bin/sh
# create trackList.json

# put header in
cat header.json > trackList.json

# put workflow ids line by line in a file and read into a bash array: arr1
IFS=$'\r\n' GLOBIGNORE='*' command eval  'arr1=($(cat workflows.txt))'

for i in "${arr1[@]}"
  do
     ./createjson.sh $i trackList.json
  done

# put community tracks in
cat community.json >> trackList.json
