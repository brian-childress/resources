#!/bin/bash

# USAGE: ./filename.sh /path/to/directory keyword

# Check if the script received exactly two arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 directory keyword"
    exit 1
fi

# Save the command line arguments into variables
directory=$1
keyword=$2

# Use find command to find files containing the keyword in their name
# The -type f flag indicates we're only interested in files (not directories)
# The -name flag is used to specify the name of the files we're looking for, and '*' is a wildcard character
matches=$(find "$directory" -type f -name "*$keyword*")

# Print the relative paths of the matching files
echo "Files containing '$keyword' in their name:"
echo "$matches"

# Count the number of matching files
count=$(echo "$matches" | wc -l)

echo "Number of files: $count"

# Exit the script
exit 0
