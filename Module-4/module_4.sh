#!/bin/bash

input_file="$1"
output_file="output.txt"

> "$output_file"

while read line
do
	if [[ "$line" == *"frame.time"* ]] || \
	   [[ "$line" == *"wlan.fc.type"* ]] || \
	   [[ "$line" == *"wlan.fc.subtype"* ]]; then
		echo "$line" >> "$output_file"
	fi

done < "$input_file"

	
