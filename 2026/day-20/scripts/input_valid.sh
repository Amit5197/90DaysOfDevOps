#!/bin/bash

# Accept the path to a log file as a command-line argument
log_file="$1"

# Exit with a clear error message if no argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No log file path provided."
    exit 1
fi

# Exit with a clear error message if the file doesn't exist
if [ ! -f "$log_file" ]; then
    echo "Error: $log_file does not exists"
    exit 1
fi