#!/bin/bash
WEBHOOK_URL="https://your-webhook-url.com/notify"

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt 80 ]; then
    MESSAGE="Warning: Disk usage on server $(hostname) has reached ${DISK_USAGE}%"
    
    curl -s -X POST -H "Content-type: application/json" --data "{\"text\":\"$MESSAGE\"}" "$WEBHOOK_URL"
    
    echo "$MESSAGE" | wall
fi
