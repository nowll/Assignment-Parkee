#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR=$1

printf "%-30s | %-10s | %-10s | %-10s\n" "Filename" "Lines" "Words" "Chars"
printf "%s\n" "-----------------------------------------------------------------------"

find "$DIR" -type f -exec wc {} + | while read -r lines words chars file; do
    if [ "$file" != "total" ]; then
        printf "%-30s | %-10s | %-10s | %-10s\n" "$(basename "$file")" "$lines" "$words" "$chars"
    fi
done
