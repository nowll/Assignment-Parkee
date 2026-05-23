#!/bin/bash
echo "=== System Information ==="
echo "Hostname        : $(hostname)"
echo "System Time     : $(date +"%Y-%m-%d %H:%M:%S %Z")"
echo "Logged-in Users : $(who | wc -l) users currently logged in"
