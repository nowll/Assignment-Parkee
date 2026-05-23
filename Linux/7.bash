#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <ip_address>"
    exit 1
fi

PUB_KEY=$1
USER=$2
IP=$3

ssh-copy-id -i "$PUB_KEY" "$USER@$IP"
