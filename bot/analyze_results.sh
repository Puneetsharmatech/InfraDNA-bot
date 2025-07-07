#!/bin/bash

# Source the configuration to get the DB_FILE path
source ./config.sh

echo ""
echo "---"
echo "🔬 Analyzing Results for Duplicates..."
echo "---"

# Use awk, sort, and uniq to find duplicate fingerprints
awk -F, 'NR>1 {print $3}' "$DB_FILE" | sort | uniq -d | while read -r duplicate; do
  if [ -n "$duplicate" ]; then
    echo "🔥 DUPLICATE FOUND: The following repos share the same fingerprint:"
    echo "   Fingerprint: $duplicate"
    
    # Find and print the repositories that have this duplicate fingerprint
    grep "$duplicate" "$DB_FILE" | while read -r line; do
      repo_name=$(echo "$line" | cut -d',' -f1)
      echo "   -> $repo_name"
    done
    echo ""
  fi
done