# To create a tag for the latest
# commit, run the following command:
# ./create_tag.sh
#
# If you want to tag a particular commit, run the following command
# ./create_tag.sh -c
# and follow the instructions

# Function to list all previous Git tags
function Get-PreviousTags {
	# Print out a message
	Write-Host "Previous Git tags:"
	git tag
}

# Function to prompt the user for commit hash
function Get-CommitHashExcerpt {
	# Print out a message
	$commit_hash_excerpt = Read-Host -Prompt "Enter the commit hash"
	# Write-Host "Enter the commit hash: " -NoNewLine
	# Read the commit hash
	# $commit_hash_excerpt = Read-Host


	# Check if the commit hash is empty
	if ([string]::IsNullOrEmpty($commit_hash_excerpt)) {
		# Print out a message
		Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Commit hash cannot be empty"

		# Prompt the user again
		Get-CommitHashExcerpt
	# else if the commit hash is less than 7 characters
	} elseif ($commit_hash_excerpt.Length -lt 7) {
		# Print out error message
		Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Commit hash must be at least 7 characters"

		# Prints message for the user to get the hash
		Write-Host "Get the hash by running the following command: " -NoNewline; Write-Host "git log" -ForegroundColor Cyan;

		# Exit the program
		Exit
	}

	# Return the commit hash
	return $commit_hash_excerpt
}

# Function to prompt the user for tag name
function Get-TagName {
	# Read the tag name
	$tag_name = Read-Host -Prompt "Enter the tag name"

	# Write-Host "Enter the tag name: " -NoNewline
	# $tag_name = Read-Host


	# Check if the tag name is empty
	if ([string]::IsNullOrEmpty($tag_name)) {
		# Print out a message
		Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Tag name cannot be empty"

		# Prompt the user again
		Get-TagName
	}

	while (git tag | findstr $tag_name) {
		# Print out a message
		Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Tag name '$($tag_name)' already exists"

		# Prompt the user again
		$tag_name = Read-Host -Prompt "Enter the tag name"
	}

	# Return the tag name
	return $tag_name
}


# Main Function
function Invoke-Main {
	# Check if the script has a -c flag in the parameter
	if ($$ -contains "-c") {
		# Set the flag to true
		$c = $true
	}

	# Check if the script is called with the -c flag
	if ($c) {
		# Get the commit hash
		$commit_hash = Get-CommitHashExcerpt

		# Write-Host $commit_hash

		# Verify if the commit hash excerpt exists in the repository
		$full_commit_hash = $(git log --pretty=%H | findstr $commit_hash)

		Write-Host $full_commit_hash

		# Check if the commit hash exists
		if ([string]::IsNullOrEmpty($full_commit_hash)) {
			# Print out a message
			Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Commit hash '$($commit_hash)' does not exist"

			# Prints message for the user to get the hash
			Write-Host "Get the correct hash value by running the following command: " -NoNewline; Write-Host "git log" -ForegroundColor Cyan;

			# Exit the program
			Exit
		}

		# Acknowledge that the commit hash is correct
		Write-Host "Commit hash " -NoNewline; Write-Host "'$($commit_hash)'" -ForegroundColor Yellow -NoNewline; Write-Host " is correct"

		# List all previous tags
		Get-PreviousTags

		# Prompt the user for the tag name
		$tag_name = Get-TagName

		# Create the tag
		git tag $tag_name $full_commit_hash
	} else {
		# List all previous tags
		Get-PreviousTags

		# Prompt the user for the tag name
		$tag_name = Get-TagName

		# Create the tag
		git tag $tag_name
	}

	# Push the tag to the remote repository
	git push origin $tag_name

	# Print out success message

	Write-Host "Tag '$($tag_name)' created and pushed successfully." -ForegroundColor Green
}


# Call the main function
Invoke-Main
