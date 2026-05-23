#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string> <username>"
    exit 1
fi

UNIQUE_STR=$1
TARGET_USER=$2
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
AUTH_FILE="$USER_HOME/.ssh/authorized_keys"

if [ -f "$AUTH_FILE" ]; then
    sed -i.bak "/$UNIQUE_STR/d" "$AUTH_FILE"
    echo "Key containing '$UNIQUE_STR' has been removed from $AUTH_FILE"
else
    echo "The authorized_keys file was not found for user $TARGET_USER"
fi
