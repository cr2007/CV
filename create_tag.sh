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

set -e


# Function to list all previous Git tags
function list_previous_tags {
	latest_tag=$(git describe --tags --abbrev=0)

	echo -e "Latest Git tag: \e[35;1m$latest_tag\e[0m"

	echo "Previous Git tags:"
	git tag
}

# Function to prompt the user for tag name
function get_tag_name {
	# read -p "Enter the tag name: " tag_name

	# Exit the program when I do Ctrl+ C
	trap "exit" INT

	tag_name=$(gum input --prompt "Enter the tag name: " --placeholder "(i.e. v0.1.3)" )

	# Check if the tag name is empty
	if [ -z "$tag_name" ]; then
		echo -e "\e[31;1mError:\e[0m Tag name cannot be empty."
		get_tag_name
	fi

	# Check if the tag already exists
	while git tag | grep -q "^$tag_name$"; do
		echo -e "\e[31;1mError:\e[0m Tag '$tag_name' already exists."
		get_tag_name
	done
}

# Check if the script is called with the -c flag
if [[ "$1" == "-c" ]]; then
	# Makes the user select from the list of commits
	commit_hash=$(git log --oneline | gum filter --height 5 | cut -d' ' -f1)

	# List all previous Git tags
	list_previous_tags

	# Prompt the user for tag name
	get_tag_name

	# Run the command to create the tag for the specified commit
	git tag "$tag_name" "$full_commit_hash"

else
	# List all previous Git tags
	list_previous_tags

	# Prompt the user for tag name
	get_tag_name

	# Run the command to create the tag for the latest commit
	git tag "$tag_name"

fi

# Push the tag to the remote repository
git push origin "$tag_name" | gum spin --spinner points --title "Pushing the tag..." --spinner.foreground="#34A853" -- sleep 5

echo -e "\e[32mTag '$tag_name' created and pushed successfully.\e[0m"
