# Creates a tag everytime something is successful
# Usage: create_tag.ps1

# Function to list all previous Git tags
function list_previous_tags {
	# Print out a message
	Write-Host "Previous Git tags:"
	git tag
}
