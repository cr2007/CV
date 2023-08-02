#!/bin/bash

# Function to list all previous Git tags
function list_previous_tags {
  echo "Previous Git tags:"
  git tag
}

# Function to prompt the user for commit hash
function get_commit_hash {
  echo -e -n "Enter the \e[1mcommit hash\e[0m you want to tag\n(If you want to enter a shortened one, enter the first 7 digits of the commit hash)\n"
  read commit_hash

  # Check if the commit hash is empty
  if [ -z "$commit_hash" ]; then
    echo "Error: Commit hash cannot be empty."
    get_commit_hash
  fi
}

# Function to prompt the user for tag name
function get_tag_name {
  read -p "Enter the tag name: " tag_name

  # Check if the tag name is empty
  if [ -z "$tag_name" ]; then
    echo -e "\e[31;1mError:\e[0m Tag name cannot be empty."
    get_tag_name
  fi
}

# Check if the script is called with the -c flag
if [[ "$1" == "-c" ]]; then
  # Prompt the user for commit hash
  get_commit_hash

  # Verify if the commit hash exists using grep
  if git log --pretty=oneline | cut -d' ' -f1 | grep -q "^$commit_hash$"; then
    echo -e "Commit hash \e[1;33m'$commit_hash'\e[0m exists in the repository."
  else
    # Checks with the first 7 digits of the commit hash
    echo -e "\e[31;1mError:\e[0m Commit hash '$commit_hash' does not exist."
    echo -e "\e[1;33mRe-checking with first 7 digits of commit hash\e[0m"

	if git log --pretty=oneline | cut -d' ' -f1 | grep -E -q "^${commit_hash:0:7}"; then
      echo -e "Commit hash \e[1;33m'$commit_hash'\e[0m exists in the repository."
    else
      echo -e "\e[31;1mError:\e[0m Commit hash '$commit_hash' does not exist."
      exit 1
    fi
  fi

  # List all previous Git tags
  list_previous_tags

  # Prompt the user for tag name
  get_tag_name

  # Check if the tag already exists
  while git tag | grep -q "^$tag_name$"; do
    echo -e "\e[31;1mError:\e[0m Tag '$tag_name' already exists."
    get_tag_name
  done

  # Run the command to create the tag for the specified commit
  git tag "$tag_name" "$commit_hash"

else
  # List all previous Git tags
  list_previous_tags

  # Prompt the user for tag name
  get_tag_name

  # Check if the tag already exists
  while git tag | grep -q "^$tag_name$"; do
    echo -e "\e[31;1mError:\e[0m Tag '$tag_name' already exists."
    get_tag_name
  done

  # Run the command to create the tag for the latest commit
  git tag "$tag_name"

fi

# Push the tag to the remote repository
git push origin "$tag_name"

echo -e "\e[32mTag '$tag_name' created and pushed successfully.\e[0m"
