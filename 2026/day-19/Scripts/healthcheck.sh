#!/bin/bash
# This is the "Shebang". It is the executing argument that tells 
# the system to run this file using the Bash interpreter.

# 3. Create a variable and assign the log file path
LOG_PATH="/var/log/health.log"

# Get current date and time
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Check Disk Usage (Targeting the root '/' partition)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

# Gets the percentage of used memory
MEM_USAGE=$(free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2}')

# Gets the 1-minute load average
CPU_LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)



# Logic: Append the health data to the log file using the variable
echo "[$TIMESTAMP] System Health Check" >> "$LOG_PATH"
echo "Current Disk Usage: $DISK_USAGE" >> "$LOG_PATH"
echo "Memory usage: $MEMORY_USAGE" >> "$LOG_PATH"
echo "Load Average: $CPU_LOAD" >>  "$LOG_PATH"

echo "-----------------------------------" >> "$LOG_PATH"
