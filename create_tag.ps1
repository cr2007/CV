# Creates a tag everytime something is successful
# Usage: create_tag.ps1

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
