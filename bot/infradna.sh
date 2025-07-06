#!/bin/bash

# A simple script to discover and list GitHub repositories.

echo "INFO: Finding repositories..."

# Use 'gh repo list' and specify your GitHub username.
# The '--limit' flag is used here for testing purposes.
gh repo list Puneetsharmatech --limit 5