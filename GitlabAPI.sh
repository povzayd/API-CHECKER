
#!/bin/bash

Prompt the user for the file containing API keys
read -p "Enter the path to the file containing API keys: " file_path
read -p "Enter your GitLab instance URL (e.g., https://gitlab.com): " gitlab_url

Check if the file exists
if [[ ! -f "$file_path" ]]; then
    echo "File does not exist."
    exit 1
fi

Loop through each line (API key) in the file
while IFS= read -r api_key; do
    # Skip empty lines
    if [[ -z "$api_key" ]]; then
        continue
    fi

    # Trim whitespace
    api_key=$(echo "$api_key" | xargs)

    echo "Checking API key: $api_key"

    # Make the API request
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        "$gitlab_url/api/v4/projects?private_token=$api_key")

    # Interpret the response
    if [[ "$response" == "200" ]]; then
        echo "✅ API key '$api_key' is VALID."
    else
        echo "❌ API key '$api_key' is INVALID (HTTP $response)."
    fi
done < "$file_path"
