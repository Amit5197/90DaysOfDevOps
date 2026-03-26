# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Task

You are a system administrator responsible for managing a network of servers. Every day, a log file is generated on each server containing important system events and error messages. Your job is to analyze these log files, identify specific events, and generate a summary report.

Write a Bash script (`log_analyzer.sh`) that automates the process of analyzing log files and generating a daily summary report.

---

## Expected Output
- A Bash script: `log_analyzer.sh`
- A generated summary report: `log_report_<date>.txt`
- A markdown file: `day-20-solution.md` documenting your approach

---

## Challenge Tasks

### Task 1: Input and Validation
Your script should:
1. Accept the path to a log file as a command-line argument
2. Exit with a clear error message if no argument is provided
3. Exit with a clear error message if the file doesn't exist

## Output:
 + To accomplish Task 1, you'll need to use special variables like $1 (the first argument) and "test" operators like -f (to check if a file exists).

<img width="677" height="178" alt="image" src="https://github.com/user-attachments/assets/c7bce842-8344-4999-a5c2-3dc0fda7429d" />

Component,Logic
$#,"A built-in variable that counts the number of arguments. If it's 0, the user forgot the input."
$0,"This refers to the name of the script itself, useful for showing the ""Usage"" message."
"[ ! -f ""$LOG_FILE"" ]","The -f flag specifically checks if the path points to a file (rather than a directory). The ! means ""if NOT a file."""
exit 1,"In Linux, an exit code of 0 means success, while any non-zero number indicates an error. This helps other programs know your script failed."

---

### Task 2: Error Count
1. Count the total number of lines containing the keyword `ERROR` or `Failed`
2. Print the total error count to the console

## create a new firl  
``` Vim error_count.sh ```

## Create a Sample Log
Run this command in your terminal to create a dummy log file with some errors in it:
``` echo -e "INFO: System started\nERROR: Database connection failed\nDEBUG: Loading assets\nFailed: Authentication timeout\nINFO: User logged in" > sample.log ```

# If your real log file is somewhere else (like /var/log/syslog), you need to provide the full path:

``` ./error_count.sh /var/log/syslog ```
## Verify the file exists
Before running your script again, you can double-check the file is there by typing:
``` ls -l sample.log ```
## Final Test
Once you've created the file using the echo command above, run your script again:
``` ./error_count.sh sample.log ```
Expected Output:
Total error count: 2

<img width="1897" height="355" alt="image" src="https://github.com/user-attachments/assets/926d9bee-610a-4ae2-b541-88a0c44e44bd" />

---

### Task 3: Critical Events
1. Search for lines containing the keyword `CRITICAL`
2. Print those lines along with their line number

Example output:
```
--- Critical Events ---
Line 84: 2025-07-29 10:15:23 CRITICAL Disk space below threshold
Line 217: 2025-07-29 14:32:01 CRITICAL Database connection lost
```

# Output
# create a critical.sh file 
# Add a critical event:
``` echo "CRITICAL: Power supply failure on line 4" >> sample.log ```
# Run the script:
``` ./critical.sh sample.log ```

<img width="1027" height="365" alt="image" src="https://github.com/user-attachments/assets/f444e73b-3e3b-4e34-aec4-9727a112b0fd" />

---

### Task 4: Top Error Messages
1. Extract all lines containing `ERROR`
2. Identify the **top 5 most common** error messages
3. Display them with their occurrence count, sorted in descending order

Example output:
```
--- Top 5 Error Messages ---
45 Connection timed out
32 File not found
28 Permission denied
15 Disk I/O error
9  Out of memory
```
## Output:
``` ./error_count.sh sample.log ```

<img width="682" height="223" alt="image" src="https://github.com/user-attachments/assets/3ff2efa7-44b0-486b-994a-c7a5fcf4ded2" />

---

### Task 5: Summary Report
Generate a summary report to a text file named `log_report_<date>.txt` (e.g., `log_report_2026-02-11.txt`). The report should include:
1. Date of analysis
2. Log file name
3. Total lines processed
4. Total error count
5. Top 5 error messages with their occurrence count
6. List of critical events with line numbers

## output:

<img width="1763" height="650" alt="image" src="https://github.com/user-attachments/assets/7a6f1bf5-b388-4e28-8e01-9be4fbf224b8" />

---

### Task 6 (Optional): Archive Processed Logs
Add a feature to:
1. Create an `archive/` directory if it doesn't exist
2. Move the processed log file into `archive/` after analysis
3. Print a confirmation message

 <img width="1763" height="650" alt="image" src="https://github.com/user-attachments/assets/0f1d3fdb-158b-49df-9127-01b8a666a774" />

---

## Sample Log File

A sample log file is available in this directory: `sample_log.log`

You can also pick real-world log datasets from the [LogHub repository](https://github.com/logpai/loghub) to test your script against production-like logs (e.g., ZooKeeper, HDFS, Apache, Linux syslogs).

---

## Hints
- Count errors: `grep -c "ERROR" logfile.log`
- Print with line numbers: `grep -n "CRITICAL" logfile.log`
- Top occurrences: `grep "ERROR" logfile.log | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5`
- Associative arrays: `declare -A error_map`
- Date for filename: `date +%Y-%m-%d`
- Move files: `mv logfile.log archive/`

