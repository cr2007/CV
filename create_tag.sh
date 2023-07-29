#!/bin/bash

# Check if the script is called with the tag name parameter
if [ -z "$1" ]; then
  echo "Error: Tag name parameter is missing."
  echo "Usage: $0 <tag-name>"
  exit 1
fi

tag_name="$1"

# Run the command to create the tag
git tag "$tag_name"

# Push the tag to the remote repository
git push origin "$tag_name"