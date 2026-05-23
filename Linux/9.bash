#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

PUB_KEY=$1
TARGET_USER=$2

USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
AUTH_FILE="$USER_HOME/.ssh/authorized_keys"

mkdir -p "$USER_HOME/.ssh"
cat "$PUB_KEY" >> "$AUTH_FILE"

chmod 700 "$USER_HOME/.ssh"
chmod 600 "$AUTH_FILE"
chown -R "$TARGET_USER:$TARGET_USER" "$USER_HOME/.ssh"

echo "Public key successfully added to $AUTH_FILE"
