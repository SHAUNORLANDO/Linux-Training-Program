  **Module 2 Assessment - The Linux Environment**

1) Use the appropriate command to list all files larger than 1 MB in the current directory and save the output to a file.

**Commands:**
```bash
touch file_1 file _2 file _3
truncate -s 500K file_1
truncate -s 2M file_2
truncate -s 3M file_3

find . -maxdepth 1 -type f -size +1M > 2_1.txt
```
**Output:**
```bash
cat 2_1.txt
  ./file_2.txt
  ./file_3.txt
```
2) Replace all occurrences of "localhost" with "127.0.0.1" in a configuration file named config.txt, and save the updated file as updated_config.txt.

**Commands:**
```bash
nano config.txt
cat config.txt
 server = localhost
 database_host=localhost
 port = 3306
 api_url=http://localhost:8080
 log_path = /var/log/localhost
 timeout = 30

sed 's/localhost/127.0.0.1/g' config.txt > updated_config.txt
```
**Output:**
```bash
cat updated_config.txt
 server = 127.0.0.1
 database_host=127.0.0.1
 port = 3306
 api_url=http://127.0.0.1:8080
 log_path = /var/log/127.0.0.1
 timeout = 30
```

3) Use the appropriate command to search for lines containing the word "ERROR" in a log file but exclude lines containing "DEBUG". Save the results to a file named filtered_log.txt.<br>
log:<br>
DEBUG: Starting the application initialization.<br>
ERROR: Unable to connect to the database.<br>
INFO: User 'admin' logged in successfully.<br>
DEBUG: Fetching configuration settings from the server.<br>
ERROR: DEBUG - Configuration settings could not be applied.<br>
INFO: Scheduled job 'backup' completed successfully.<br>
DEBUG: Connection to server timed out. Retrying...<br>
ERROR: Failed to fetch data from API endpoint '/users'.<br>
INFO: Maintenance mode activated.<br>
ERROR: DEBUG - Query execution failed due to a syntax error.<br>
DEBUG: Reloading application modules.<br>
ERROR: Missing required parameter in the request.<br>
INFO: Shutting down the system gracefully.<br>
DEBUG: Closing unused network connections.<br>
ERROR: DEBUG - Unexpected server response received.

**Commands:**
```bash
nano log.txt
grep "ERROR" log.txt | grep -v "DEBUG" > filtered_log.txt
```
**Output:**
```bash
cat filtered_log.txt
  ERROR: Unable to connect to the database.
  ERROR: Failed to fetch data from API endpoint '/users'.
  ERROR: Missing required parameter in the request.
```
4) Write a code to identify the process with the highest memory usage and then terminate it.
   
**Command:**
```bash
ps aux --sort=-%mem | awk 'NR==2 {print $2}'
```

**Output:**
```bash
9864
```

**Command:**
```bash
kill 9864
```
5) Use the networking tool command and print all the gateway available in a sorted manner

**Command:**
```bash
netstat -rn | awk 'NR>2 {print $2}' | sort -u
```
**Output:**
```bash
0.0.0.0
10.0.2.2
```
