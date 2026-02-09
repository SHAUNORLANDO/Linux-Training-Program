**Module-5: Advance Topics in a Function**

Create a Bash script 'file_analyzer.sh', to demonstrate the following concepts: <br> 
1. Recursive functions - Write a recursive function to search for files in a directory and its subdirectories containing a specific keyword.<br> 
2. Redirection and error handling - Log errors (e.g., invalid arguments, missing files) to 'errors.log' and display them in the terminal.<br> 
3. Here document and here string<br> 
   - Use a here document to display a help menu when the '--help' option is passed.<br> 
   - Search for a keyword in a specified file using a here string<br> 
4. Special parameters - Use parameters like '$0', '$#', '$?' and '$@' to provide meaningful feedback.<br> 
5. Regular expressions - Validate inputs with regular expressions (Check if the file exists and the keyword is not empty and valid)<br> 
6. Command-line arguments using getopts<br> 
   - Use 'getopts' to handle:<br>
   '-d <directory>': Directory to search.<br>
   '-k <keyword>': Keyword to search.<br>
   '-f <file>': File to search directly.<br>
   '--help': Display the help menu.<br>

**file_analyzer.sh**
```bash
#!/bin/bash

#1. Recursive search function
search(){
	dir=$1
	key=$2
	for file in "$dir"/*
	do
		if [ -d "$file" ];then
			search "$file" "$key"
		elif [ -f "$file" ];then
			grep -q "$key" "$file"
			if [ $? -eq 0 ];then
				echo "Keyword $key found in file: $file"
			fi
		fi
	done
}

#2. Redirection and Error Handling
if [ $# -eq 0 ];then
	echo "ERROR: No arguments provided" >&2
	echo "ERROR: No arguments provided" >> errors.log
	exit 1
fi

#3. Here document and here string
#To display help menu
for arg in "$@"
do
	if [ "$arg" = "--help" ];then
		cat<<EOF
Help Menu: 

Input Format: $0 [OPTIONS]

-d <directory>:	Directory to search
-k <keyword>  : Keyword to search
-f <file>     : File to search directly
--help	      : Display the help menu

Example usage: 
To recursively search a directory for a keyword: 
./file_analyzer.sh -d logs -k error

To search for a keyword in a file: 
./file_analyzer.sh -f script.sh -k TODO  

To display the help menu: 
./file_analyzer.sh --help

EOF
exit 0
fi
done

#4. Special Parameters
echo "Script name		  : $0"
echo "Total arguments		  : $#"
echo "Arguments passed		  : $@"

#6. Command line arguments using getopts
while getopts "d:f:k:" option
do
	case $option in
		d) directory=$OPTARG ;;
		f) file=$OPTARG ;;
		k) keyword=$OPTARG ;;
		*) 
		echo "ERROR: Invalid Option" >&2
		echo "ERROR: Invalid Option" >> errors.log
		exit 1
		;;
	esac
done

#5. Regular expressions
# Check if Keyword is not empty
if [ -z "$keyword" ];then
	echo "ERROR: Keyword is empty" >&2
	echo "ERROR: Keyword is empty" >> errors.log
	exit 1
fi

#Check keyword format
if [[ ! "$keyword" =~ ^[a-zA-Z0-9_]+$ ]];then
	echo "ERROR: Invalid keyword" >&2
	echo "ERROR: Invalid keyword" >> errors.log
	exit 1
fi 

#Search for keyword in specific file using here string
if [ -n "$file" ];then
	if [ ! -f "$file" ];then
		echo "ERROR: File does not exist" >&2
		echo "ERROR: File does not exist" >> errors.log
		exit 1
	fi
	
	grep "$keyword" <<< "$(cat "$file")"
	exit 0
fi

#Directory search
if [ -n "$directory" ];then
	if [ ! -d "$directory" ];then
		echo "ERROR: Directory does not exist" >&2
		echo "ERROR: Directory does not exist" >> errors.log
		exit 1
	fi
	
	search "$directory" "$keyword"
	echo "Last command status: $?"
	exit 0
fi

```
