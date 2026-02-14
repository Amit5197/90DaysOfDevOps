# Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide

## Task 1: Basics

1. Shebang (`#!/bin/bash`) — what it does and why it matters

```This is a shebang, first line on the script. It sets your interpreter to use `/bin/bash`.
    If it is not specified than `/bin/sh` the default interpreter will be used.
```

2. Running a script — `chmod +x`, `./script.sh`, `bash script.sh`

* `chmod+x` - Sets the execute permission on a file/script.
* `./script.sh` - Run the script by using the interpreter defined in script.
* `bash script.sh` - Run the script by explicitly invoking bash interprete.

3. Comments — single line (`#`) and inline

#this is comment
echo "hi"; #this is inline comment

4. Variables — declaring, using, and quoting (`$VAR`, `"$VAR"`, `'$VAR'`)

* name="Afroz" #declaring
* echo "$name" #using
* echo '$name' #single quote prints literally (Output: $name)

5. Reading user input — `read`

* read -p "Enter Name : " name #Take name as an input and save it in variable name

6. Command-line arguments — `$0`, `$1`, `$#`, `$@`, `$?`

* `$0` - Filename # check.sh
* `$1` - 1st argument passed by user # check.sh 6
* `$#` - Total number of arguments passed # 1
* `$@` - Prints all arguments
* `$?` - Last command's exit status

---

## Task 2: Operators and Conditionals

1. String comparisons — `=`, `!=`, `-z`, `-n`
```
a="Hello"
b="Hello"

#= Check if two strings are equal
if [[ $a = $b ]];then
	echo "Check ``=`` : True"
else
	echo "Check ``=`` : False"
fi

#!= Check if two strings are not equal
if [[ $a != $b ]];then
	echo "Check ``!=`` : True"
else
	echo "Check ``!=`` : False"
fi

#-z Check if string is empty
if [[ -z $b ]];then
	echo "Check ``-z`` Empty True : $?"
else
	echo "Check ``-z`` Empty False : $?"
fi


#-n Check if string is not empty
if [[ -n $b ]];then
	echo "Check ``-n`` Not Empty : $?"
else
	echo "Check ``-n`` Empty : $?"
fi


Output :
afroz@afroz:~/practice_sh$ ./try.sh 
a=Hello	b=Hello
Check = : True
Check != : False
Check -z Empty False : 1
Check -n Not Empty : 0

```
2. Integer comparisons — `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
```
a=3
b=4

echo -e "a=$a\tb=$b"

#-eq Check equals
if [ $a -eq $b ];then
	echo "-eq $? : Equals"
else
	echo "-eq $? : Not Equals"
fi	

#-ne Check Not Equals
if [ $a -ne $b ];then
        echo "-ne $? : Not equals"
else
        echo "-ne $? : Equals"
fi

#-lt Check Less Than
if [ $a -lt $b ];then
        echo "-lt $? : Less"
else
        echo "-lt $? : Not Less"
fi

#-gt Check Greater Than
if [ $a -gt $b ];then
        echo "-gt $? : Greater"
else
        echo "-gt $? : Not greater"
fi

#-le Check Less Than OR Equal To
if [ $a -le $b ];then
        echo "-le $? : True"
else
        echo "-le $? : False"
fi

#-ge Check Greater Than Or Equal To
if [ $a -ge $b ];then
        echo "-ge $? : True"
else
        echo "-ge $? : False"
fi

OutPut:
./int.sh 
a=3	b=4
-eq 1 : Not Equals
-ne 0 : Not equals
-lt 0 : Less
-gt 1 : Not greater
-le 0 : True
-ge 1 : False

```
3. File test operators — `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s`
```
<<usage
-f = If file exists and it is a regular file.
-d = If file exists and is a directory.
-e = If file exists and is a file/directory.
-r = If file exists and is readable.
-w = If file exists and is writable.
-x = If file exists and is executable.
-s = If file exists and has size greater than 0(Not Empty).
usage

read -p "Enter File Name : " fname

operators=("-f" "-d" "-e" "-r" "-w" "-x" "-s")
for oprt in "${operators[@]}";do
	if [ $oprt $fname ];then
		echo "$oprt $? : True"
	else
		echo "$oprt $? : False"
	fi
done

OutPut:
/ftest.sh 
Enter File Name : chech.sh
-f 0 : True
-d 1 : False
-e 0 : True
-r 0 : True
-w 0 : True
-x 0 : True
-s 0 : True

```
4. `if`, `elif`, `else` syntax
```
a=10
b=5
if [ $a -eq $b ];then
        echo "Equals"
elif [ $a -gt $b ];then
        echo "Greater"
else
        echo "Smaller"
fi

OutPut:
Greater

```
5. Logical operators — `&&`, `||`, `!`
```
a=10
b=5
(( ! a>b )) && echo "Smaller" || echo "Greater"

OutPut:
Smaller

```
6. Case statements — `case ... esac`
```
read -p "Choose from a,b,c : " num

case $num in
	a)
		echo "You chose a"
		;;
	b)
		echo "You chose b"
		;;
	c)
		echo "you chose c"
		;;
	*)
		echo "Invalid option"
		;;
esac

OutPut:
Choose from a,b,c : a
You chose a

Choose from a,b,c : d
Invalid option

```
---

# Task 3: Loops

1. `for` loop — list-based and C-style
2. `while` loop
3. `until` loop
4. Loop control — `break`, `continue`
5. Looping over files — `for file in *.log`
6. Looping over command output — `while read line`

---

### Task 4: Functions
Document with examples:
1. Defining a function — `function_name() { ... }`
2. Calling a function
3. Passing arguments to functions — `$1`, `$2` inside functions
4. Return values — `return` vs `echo`
5. Local variables — `local`

---

### Task 5: Text Processing Commands
Document the most useful flags/patterns for each:
1. `grep` — search patterns, `-i`, `-r`, `-c`, `-n`, `-v`, `-E`
2. `awk` — print columns, field separator, patterns, `BEGIN/END`
3. `sed` — substitution, delete lines, in-place edit
4. `cut` — extract columns by delimiter
5. `sort` — alphabetical, numerical, reverse, unique
6. `uniq` — deduplicate, count
7. `tr` — translate/delete characters
8. `wc` — line/word/char count
9. `head` / `tail` — first/last N lines, follow mode

---

### Task 6: Useful Patterns and One-Liners
Include at least 5 real-world one-liners you find useful. Examples:
- Find and delete files older than N days
- Count lines in all `.log` files
- Replace a string across multiple files
- Check if a service is running
- Monitor disk usage with alerts
- Parse CSV or JSON from command line
- Tail a log and filter for errors in real time

---

### Task 7: Error Handling and Debugging
Document with examples:
1. Exit codes — `$?`, `exit 0`, `exit 1`
2. `set -e` — exit on error
3. `set -u` — treat unset variables as error
4. `set -o pipefail` — catch errors in pipes
5. `set -x` — debug mode (trace execution)
6. Trap — `trap 'cleanup' EXIT`

---

### Task 8: Bonus — Quick Reference Table
Create a summary table like this at the top of your cheat sheet:

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## Format Guidelines

Your cheat sheet should be:
- Written in **Markdown** (`.md`)
- Organized with **clear headings** for each section
- Include **code blocks** with syntax highlighting (` ```bash `)
- Keep explanations **short** — 1-2 lines max per item
- Focus on **practical examples** over theory
- Something **you would actually refer back to** on the job

---

## Submission
1. Add your `shell_scripting_cheatsheet.md` to `2026/day-21/`
2. Commit and push to your fork

---

## Learn in Public

Share your cheat sheet on LinkedIn — help others revise too!

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
