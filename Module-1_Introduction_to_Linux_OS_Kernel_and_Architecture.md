**Module 1 Assessment - Introduction to Linux OS Kernel and Architecture**

1) Create a file and add executable permission to all users (user, group and others)

Commands:
```bash
touch 1_1
chmod a+x 1_1

Output:
```bash
ls -l 1_1
-rwxrwxr-x 1 shaun shaun 0 Feb  4 19:39 1_1

2) Create a file and remove write permission for group user alone.

Commands:
```bash
touch 1_2
chmod g-w 1_2

Output:
```bash
ls -l 1_2
-rw-r--r-- 1 shaun shaun 0 Feb  4 19:41 1_2


3) Create a file and add a softlink to the file in different directory (Eg : Create a file in dir1/dir2/file and create a softlink for file inside dir1)

Commands:
```bash
mkdir -p dir1/dir2
touch dir1/dir2/1_3
ln -s dir1/dir2/1_3 dir1/1_3_link


Output:
```bash
ls -l dir1
total 4
lrwxrwxrwx 1 shaun shaun   13 Feb  4 19:47 1_3_link -> dir1/dir2/1_3
drwxrwxr-x 2 shaun shaun 4096 Feb  4 19:46 dir2


4) Use ps command with options to display all active process running on the system

Command:
```bash
ps -ef


5) Create 3 files in a dir1 and re-direct the output of list command with sorted by timestamp of the files to a file

Commands:
```bash
mkdir dir1_q5
cd dir1_q5
touch file_1 file_2 file_3
ls -lt > output.txt

Output:
```bash
cat output.txt
total 0
-rw-rw-r-- 1 shaun shaun 0 Feb  4 19:52 output.txt
-rw-rw-r-- 1 shaun shaun 0 Feb  4 19:52 file_3
-rw-rw-r-- 1 shaun shaun 0 Feb  4 19:52 file_1
-rw-rw-r-- 1 shaun shaun 0 Feb  4 19:52 file_2

