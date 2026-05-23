#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <ip_address>"
    exit 1
fi

USER=$1
IP=$2

if ssh -o BatchMode=yes -o ConnectTimeout=5 "$USER@$IP" exit &> /dev/null; then
    echo "Connection to $USER@$IP was SUCCESSFUL."
else
    echo "Connection to $USER@$IP FAILED."
fi
