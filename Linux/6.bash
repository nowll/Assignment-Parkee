#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <storage_directory>"
    exit 1
fi

KEY_DIR=$1
mkdir -p "$KEY_DIR"

ssh-keygen -t ed25519 -f "$KEY_DIR/id_ed25519" -N "" -q
echo "SSH Key successfully generated in $KEY_DIR"
