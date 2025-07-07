#!/bin/bash

# --- NEW: Define absolute paths ---
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
PROJECT_ROOT=$(dirname "$SCRIPT_DIR")
# --- END NEW ---

# Source the configuration using an absolute path
source "$PROJECT_ROOT/bot/config.sh"

# Ensure a clean run
rm -rf "$PROJECT_ROOT/$CLONE_DIR"/*

# Initialize the database file using an absolute path
echo "Repository,Directory,Fingerprint" > "$PROJECT_ROOT/$DB_FILE"

echo "INFO: Finding repositories..."

# Get the GitHub user from config.sh
USER=$(grep "^USER=" "$PROJECT_ROOT/bot/config.sh" | cut -d'"' -f2)

gh repo list "$USER" --limit 5 | while read -r repo_full_name _; do
  # Pass the project root and repo name to the processing script
  "$SCRIPT_DIR/process_repo.sh" "$PROJECT_ROOT" "$repo_full_name"
done

# Call the analysis script (no changes needed for this one yet)
"$SCRIPT_DIR/analyze_results.sh"

echo "---"
echo "INFO: Script finished."