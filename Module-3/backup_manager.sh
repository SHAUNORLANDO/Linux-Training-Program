#!/bin/bash

if [ $# -ne 3 ]; then
	echo "Enter in format: $0 <source_dir> <backup_dir> <extension>"
	exit 1
fi

#1. Command-line arguments and Quoting
source_dir="$1"
backup_dir="$2"
ext="$3"

if [ ! -d "$source_dir" ]; then
	echo "Source directory does not exist"
	exit 1
fi

#2. Globbing
files=("$source_dir"/*"$ext")

#3. Export statements
export BACKUP_COUNT=0

#If source directory is empty or contains no files matching extension, exit with a message.
if [ "${#files[@]}" -eq 0 ]; then
	echo "No files found with extension $ext"
	exit 0
fi

#4. Array operations
total_size=0
for file in "${files[@]}"; do
	size=$(stat -c%s "$file")
	total_size=$((total_size + size))
	echo "$(basename "$file") - $size bytes"
done

#5. Conditional Execution
#If the backup directory does not exist, create it. If creation fails, exit with an error.
if [ ! -d "$backup_dir" ]; then
	mkdir "$backup_dir" || exit 1
fi

#If a file already exists in the backup directory with the same name, only overwrite it if it is older than the source file (compare timestamps).
for file in "${files[@]}"; do
	if [ -f "$backup_dir/$(basename "$file")" ]; then
		if [ "$file" -nt "$backup_dir/$(basename "$file")" ]; then
			cp "$file" "$backup_dir"
			((BACKUP_COUNT++))
		fi
	else
		cp "$file" "$backup_dir"
		((BACKUP_COUNT++))
	fi
done

#6. Output Report
report="$backup_dir/backup_report.log"

echo "Backup Report" > "$report"
echo "Total files processed : ${#files[@]}" >> "$report"
echo "Total files backed up : $BACKUP_COUNT" >> "$report"
echo "Total size of files backed up : $total_size bytes" >> "$report"
echo "Path to backup directory : $backup_dir" >> "$report"


