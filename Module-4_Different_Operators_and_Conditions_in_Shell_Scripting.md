For the attached file, write a bash script which should take the file as input and have to go through it line by line and need to generate an output file (say output.txt) with listings of following parameters fetched from the input file.

Params expected to be fetched from input.txt file : "frame.time", "wlan.fc.type", "wlan.fc.subtype"

**Bash Script (module_4.sh):**
```bash
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
```
Output is stored in output.txt




