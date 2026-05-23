#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_dir> <username> <ip_address>"
    exit 1
fi
rsync -avz "$1" "$2@$3:~/"
