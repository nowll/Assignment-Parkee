#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start|stop|status> <service_name>"
    exit 1
fi

ACTION=$1
SERVICE=$2

if [[ "$ACTION" =~ ^(start|stop|status)$ ]]; then
    systemctl "$ACTION" "$SERVICE"
else
    echo "Invalid action. Use: start, stop, or status."
fi
