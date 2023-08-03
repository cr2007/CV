# Creates a tag everytime something is successful
# Usage: create_tag.ps1

# Function to list all previous Git tags
function list_previous_tags {
	# Print out a message
	Write-Host "Previous Git tags:"
	git tag
}

# Function to prompt the user for commit hash
function get_commit_hash_excerpt {
	# Print out a message
	$commit_hash_excerpt = Read-Host -Prompt "Enter the commit hash"
	# Read the commit hash
	$commit_hash = Read-Host

	# Check if the commit hash is empty
	if ([string]::IsNullOrEmpty($commit_hash_excerpt)) {
		# Print out a message
		Write-Host "Error: " -ForegroundColor DarkRed -NoNewline; Write-Host "Commit hash cannot be empty"

		# Prompt the user again
		get_commit_hash_excerpt
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
	return $commit_hash
}
