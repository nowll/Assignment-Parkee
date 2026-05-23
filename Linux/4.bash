#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

SOURCE=$1
DEST=$2
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

mkdir -p "$DEST"
tar -czf "$DEST/$BACKUP_NAME" -C "$(dirname "$SOURCE")" "$(basename "$SOURCE")"
echo "Backup created: $DEST/$BACKUP_NAME"

find "$DEST" -name "backup_*.tar.gz" -type f -mtime +7 -exec rm -f {} \;
echo "Rotation complete (files older than 7 days removed)."
