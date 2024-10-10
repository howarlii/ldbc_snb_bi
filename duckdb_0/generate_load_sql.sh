#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <SF> <DATAPATH>"
  exit 1
fi

SF=$1
DATAPATH=$2
sed "s|PATHVAR|/$DATAPATH/graphs/csv/bi/composite-merged-fk/initial_snapshot/|" snb-load.sql > temp.sql

# Step 2: Process each line in temp.sql
while IFS= read -r line; do
    # Find any occurrence of "*/*_0_0.csv.gz" (case-insensitive)
    if [[ $line =~ \'(.*/[^/]+)/([^/]+)_0_0\.csv\.gz\' ]]; then
        prefix="${BASH_REMATCH[1]}"
        folder="${BASH_REMATCH[2]}"

        # List files in the folder (case-insensitive match)
        folder=$(find "$prefix" -type d -iname "$folder" 2>/dev/null)

        files=$(find "$folder" -type f -iname "*.csv.gz")

        # If there are matching files, replace and duplicate the line
        if [[ -n $files ]]; then
            for file in $files; do
                # Replace "*/*_0_0.csv.gz" with the found file
                echo "${line//${BASH_REMATCH[0]}/\'$file\'}"
            done
        else
            # No matching files, just print the original line
            echo "$line" >&2
        fi
    else
        # If no match, just print the original line
        echo "$line"
    fi
done < temp.sql > updated-snb-load-sf${SF}.sql

rm temp.sql