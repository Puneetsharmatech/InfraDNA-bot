#!/bin/bash

# Source the configuration
source ./config.sh

# The full repo name (e.g., "user/repo") is the first argument to the script
repo_full_name="$1"
repo_name=$(basename "$repo_full_name")
repo_clone_path="$CLONE_DIR/$repo_name"

echo "---"
echo "INFO: Processing repository: $repo_full_name"

# Clone the repository
git clone --quiet "https://github.com/$repo_full_name.git" "$repo_clone_path"

# Find directories containing .tf files
tf_dirs=$(find "$repo_clone_path" -type f -name "*.tf" -exec dirname {} \; | sort -u)

if [ -n "$tf_dirs" ]; then
  echo "SUCCESS: Terraform code found in $repo_name."
  
  while IFS= read -r dir; do
    echo "  -> Analyzing directory: $dir"
    
    (
      cd "$dir" || exit
      
      echo "     - Initializing Terraform..."
      terraform init -upgrade > /dev/null 2>&1
      
      echo "     - Generating plan..."
      terraform plan -out=tfplan.binary > /dev/null 2>&1
      
      if [ -f "tfplan.binary" ]; then
        terraform show -json tfplan.binary > plan.json
        fingerprint=$(jq -c -r '[.planned_values.root_module.resources[].type] | unique | sort' plan.json)
        echo "     - FINGERPRINT: $fingerprint"
        
        # Save the fingerprint to our database
        echo "$repo_full_name,$dir,$fingerprint" >> "$DB_FILE"
      else
        echo "     - ERROR: Failed to generate Terraform plan."
      fi
      
      # Cleanup
      rm -f tfplan.binary plan.json .terraform.lock.hcl
    )
  done <<< "$tf_dirs"
  
else
  echo "INFO: No Terraform files found in $repo_name."
fi