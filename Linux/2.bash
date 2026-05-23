#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SOURCE_DIR=$1
DEST_DIR=$2
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$DEST_DIR/backup_${TIMESTAMP}.tar.gz"

mkdir -p "$DEST_DIR"
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

echo "Backup successfully saved to: $BACKUP_FILE"
