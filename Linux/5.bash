#!/bin/bash

LOG_FILE="/var/log/system_update.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "--- Update started at $TIMESTAMP ---" >> "$LOG_FILE"

if command -v apt-get &> /dev/null; then
    apt-get update -y >> "$LOG_FILE" 2>&1
    apt-get upgrade -y >> "$LOG_FILE" 2>&1
elif command -v yum &> /dev/null; then
    yum update -y >> "$LOG_FILE" 2>&1
else
    echo "Unsupported package manager." >> "$LOG_FILE"
    exit 1
fi

echo "--- Update completed ---" >> "$LOG_FILE"
