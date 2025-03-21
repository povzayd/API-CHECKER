#!/bin/bash

# Function to check the validity of a Square API key
check_api_key() {
    local auth_token=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $auth_token" "https://connect.squareup.com/v2/locations")
    
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Square API Key: $auth_token"
    else
        echo "❌ Invalid Square API Key: $auth_token"
    fi
}

# Prompt the user for the text file containing Square API keys
echo "Enter the path to the file containing Square API keys:"
read file_path

# Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Read the file line by line and check each API key
while IFS= read -r auth_token; do
    check_api_key "$auth_token"
done < "$file_path"
