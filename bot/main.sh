#!/bin/bash

# Main orchestrator script for the InfraDNA Bot

# Source the configuration file
source ./config.sh

# Ensure a clean run by removing old clones
rm -rf "$CLONE_DIR"/*

# Initialize the database file with a header
echo "Repository,Directory,Fingerprint" > "$DB_FILE"

echo "INFO: Finding repositories for user: $USER"

# Find repositories and loop through each one, calling the processing script
gh repo list "$USER" --limit 5 | while read -r repo_full_name _; do
  ./process_repo.sh "$repo_full_name"
done

# Call the analysis script to find duplicates
./analyze_results.sh

echo "---"
echo "INFO: Script finished."