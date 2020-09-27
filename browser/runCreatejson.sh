#!/bin/sh

if [ -z "$1" ]; then
  echo -e "\nPlease provide input file to run this script"
  exit 1
else
  input="$1"
fi
# create trackList.json
# put header in
cat header.json > trackList.json

# put workflow ids line by line in a file and read into a bash array: arr1
IFS=$'\r\n' GLOBIGNORE='*' command eval  'arr1=($(cat $input))'

for i in "${arr1[@]}"
  do
     ./createjson.sh $i trackList.json
  done

# put community tracks in
cat community.json >> trackList.json
