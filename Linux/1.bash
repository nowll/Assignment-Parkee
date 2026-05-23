#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <extension_without_dot>"
    exit 1
fi

DIR=$1
EXT=$2

if [ ! -d "$DIR" ]; then
    echo "The directory '$DIR' does not exist."
    exit 1
fi

echo "Searching for files with extension .$EXT in directory $DIR..."

RESULTS=$(find "$DIR" -type f -name "*.$EXT")

if [ -z "$RESULTS" ]; then
    echo "No files with extension .$EXT exist in this directory."
else
    echo "$RESULTS"
fi
