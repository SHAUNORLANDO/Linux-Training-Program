**Module-3 Assessment: Linux Distributions and Scripting Languages**
**Scenario:**
Automating file backup and Reporting to the system. Create a shell script called "backup_manager.sh" that performs the following tasks incorporating the concepts suggested.

Requirements:
**1. Command-line Arguments and Quoting:** <br>
   The script must accept three arguments:<br>
   Source directory: A directory containing files to back up.<br>
   Backup directory: The destination where files will be backed up.<br>
   File extension: A specific file extension to filter (e.g., .txt).<br>
   Example:  ./backup_manager.sh "/home/user/source" "/backup" ".txt"<br>
**2. Globbing:** <br>
The script should use globbing to find all files in the source directory matching the provided file extension.<br>
**3. Export Statements:** <br>
Use export to set an environment variable BACKUP_COUNT, which tracks the total number of files backed up during the script execution.<br>
**4. Array Operations:** <br>
Store the list of files to be backed up in an array. Print the names of these files along with their sizes before performing the backup.<br>
**5. Conditional Execution:** <br>
If the backup directory does not exist, create it. If creation fails, exit with an error.<br>
If the source directory is empty or contains no files matching the extension, exit with a message.<br>
If a file already exists in the backup directory with the same name, only overwrite it if it is older than the source file (compare timestamps).<br>
**6. Output Report:** <br>
After the backup, generate a summary report displaying:<br>
Total files processed.<br>
Total size of files backed up.<br>
The path to the backup directory.<br>
The report should be saved in the backup directory as backup_report.log.<br>

**backup_manager.sh:**
```bash
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
```

**Commands:**
```bash
gedit backup_manager.sh
chmod +x backup_manager.sh
./backup_manager.sh "source" "backup" ".txt"
```
**Output:**
file_1.txt - 6 bytes
file_2.txt - 4 bytes

**Backup Report:**
cat backup/backup_report.log
  Backup Report
  Total files processed : 2
  Total files backed up : 2
  Total size of files backed up : 10 bytes
  Path to backup directory : backup
```

