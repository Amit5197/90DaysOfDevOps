#!/bin/bash

if [ -z "$1" ]; then  # -z String is empty (String Comparisons)
    echo "Usage: ./greet.sh <name>"
    exit 1
fi 
    echo "Hello, $1!"