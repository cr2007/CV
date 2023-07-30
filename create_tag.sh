#!/bin/bash

# List all previous Git tags
echo "Previous Git tags:"
git tag

# Function to prompt the user for tag name
function get_tag_name {
  read -p "Enter the tag name: " tag_name

  # Check if the tag name is empty
  if [ -z "$tag_name" ]; then
    echo -e "\e[31;1mError:\e[0m Tag name cannot be empty."
    get_tag_name
  fi
}

# Prompt the user for tag name
get_tag_name

# Check if the tag already exists
while git tag | grep -q "^$tag_name$"; do
  echo -e "\e[31;1mError:\e[0m Tag '$tag_name' already exists."
  get_tag_name
done

# Run the command to create the tag
git tag "$tag_name"

# Push the tag to the remote repository
git push origin "$tag_name"

echo -e "\e[32mTag '$tag_name' created and pushed successfully.\e[0m"
