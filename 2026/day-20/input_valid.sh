#!/bin/bash

# 1. Check if an argument was provided
# $# represents the number of arguments passed
if [ $# -eq 0 ]; then
    echo "Error: No log file path provided."
    echo "Usage: $0 /path/to/logfile.log"
    exit 1
fi

LOG_FILE=$1

# 2. Check if the file exists and is a regular file
# -f checks for file existence; ! negates the result
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

echo "Success: Found $LOG_FILE. Proceeding with analysis..."
# Your log processing logic would go here
