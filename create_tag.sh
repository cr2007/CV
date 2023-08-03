#!/bin/bash

# To run the code, make sure it has executable permissions
# chmod +x create_tag.sh
#
# To create a tag for the latest commit, run the following command
# ./create_tag.sh
#
# If you want to tag a particular commit, run the following command
# ./create_tag.sh -c
# and follow the instructions


# Function to list all previous Git tags
function list_previous_tags {
  echo "Previous Git tags:"
  git tag
}

# Function to prompt the user for commit hash
function get_commit_hash_excerpt {
  echo -e -n "Enter the \e[1mcommit hash\e[0m excerpt (minimum 7 characters) you want to tag: "
  read commit_hash_excerpt

  # Check if the commit hash is empty
  if [ -z "$commit_hash_excerpt" ]; then
    echo -e "\e[31;1mError:\e[0m Commit hash cannot be empty."
    get_commit_hash
  elif [ ${#commit_hash_excerpt} -lt 7 ]; then
    echo -e "\e[31;1mError:\e[0m Commit hash excerpt must be at least 7 characters long."
    echo -e "Get the hash by running the following command: \e[1;34mgit log\e[0m"
    exit 1
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
  get_commit_hash_excerpt

  # Verify if the commit hash excerpt exists in the repository
  full_commit_hash=$(git log --pretty=format:%H | grep -E -m 1 "^${commit_hash_excerpt}")
  if [ -z "$full_commit_hash" ]; then
    echo -e "\e[31;1mError:\e[0m Commit hash excerpt '$commit_hash_excerpt' does not exist in the repository."
	echo -e "Get the \e[1mcommit hash excerpt\e[0m by running the following command: \e[1;34mgit log\e[0m"
    exit 1
  fi

  echo -e "Commit hash \e[1;33m'$commit_hash_excerpt'\e[0m exists in the repository."

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
  git tag "$tag_name" "$full_commit_hash"

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
