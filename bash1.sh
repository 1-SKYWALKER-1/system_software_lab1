#!/bin/bash

# Check if correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 directory1 directory2"
    exit 1
fi

# Check if directories exist
if [ ! -d "$1" ] || [ ! -d "$2" ]; then
    echo "Error: One or both directories do not exist."
    exit 1
fi

# Move files from directory 1 to a temporary location
temp_dir=$(mktemp -d)
mv "$1"/* "$temp_dir"/

# Move files from directory 2 to directory 1
mv "$2"/* "$1"/

# Move files from temporary location to directory 2
mv "$temp_dir"/* "$2"/

# Count the number of moved files in each directory
count_dir1=$(find "$1" -maxdepth 1 -type f | wc -l)
count_dir2=$(find "$2" -maxdepth 1 -type f | wc -l)

# Calculate the total number of moved files
total_files=$((count_dir1 + count_dir2))

echo "Total files moved: $total_files"

# Cleanup temporary directory
rm -r "$temp_dir"