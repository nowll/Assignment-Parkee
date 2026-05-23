#!/bin/bash
LOG_FILE="/var/log/cpu_monitor.log"

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)

if (( $(echo "$CPU_USAGE > 75.0" | bc -l) )); then
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] ALERT: High CPU usage! Average: $CPU_USAGE%" >> "$LOG_FILE"
fi
