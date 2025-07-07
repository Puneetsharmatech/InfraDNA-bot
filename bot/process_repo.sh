#!/bin/bash

# The PROJECT_ROOT is passed as the first argument
PROJECT_ROOT="$1"
# The full repo name is the second argument
repo_full_name="$2"

# Source the configuration using the absolute path
source "$PROJECT_ROOT/bot/config.sh"

repo_name=$(basename "$repo_full_name")
repo_clone_path="$PROJECT_ROOT/$CLONE_DIR/$repo_name"

echo "---"
echo "INFO: Processing repository: $repo_full_name"

git clone --quiet "https://github.com/$repo_full_name.git" "$repo_clone_path"

tf_dirs=$(find "$repo_clone_path" -type f -name "*.tf" -exec dirname {} \; | sort -u)

if [ -n "$tf_dirs" ]; then
  echo "SUCCESS: Terraform code found in $repo_name."
  
  while IFS= read -r dir; do
    (
      cd "$dir" || exit
      terraform init -upgrade > /dev/null 2>&1
      terraform plan -out=tfplan.binary > /dev/null 2>&1
      
      if [ -f "tfplan.binary" ]; then
        terraform show -json tfplan.binary > plan.json
        fingerprint=$(jq -c -r '[.planned_values.root_module.resources[].type] | unique | sort' plan.json)
        
        # --- DEBUGGING LINES ---
        echo "DEBUG: Repo Full Name: $repo_full_name"
        echo "DEBUG: Directory: $dir"
        echo "DEBUG: Fingerprint: $fingerprint"
        echo "DEBUG: DB File Path: $PROJECT_ROOT/$DB_FILE"
        # --- END DEBUGGING ---

        # Write to the database using an absolute path
        echo "$repo_full_name,$dir,$fingerprint" >> "$PROJECT_ROOT/$DB_FILE"
      else
        echo "     - ERROR: Failed to generate Terraform plan."
      fi
      rm -f tfplan.binary plan.json .terraform.lock.hcl
    )
  done <<< "$tf_dirs"
else
  echo "INFO: No Terraform files found in $repo_name."
fi