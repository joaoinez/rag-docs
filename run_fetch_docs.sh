#!/bin/bash

# Loop through all immediate subdirectories
for dir in */; do
  script_path="${dir}fetch-docs.sh"

  # Check if the script exists in the subdirectory
  if [[ -f "$script_path" ]]; then
    # Remove previous docs
    (cd "$dir" && rm -rf ./docs)
    echo "Running script in: ${dir}"
    # Enter the directory and execute the script
    (cd "$dir" && ./fetch-docs.sh)
  fi
done

echo "All scripts executed!"
