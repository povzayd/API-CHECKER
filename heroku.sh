#!/bin/bash

# Function to check the validity of a Heroku API key
check_api_key() {
    local api_key=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST https://api.heroku.com/apps \
        -H "Accept: application/vnd.heroku+json; version=3" \
        -H "Authorization: Bearer $api_key")
    
    if [ "$response" -eq 201 ]; then
        echo "✅ Valid API Key: $api_key"
    else
        echo "❌ Invalid API Key: $api_key"
    fi
}

# Prompt the user for the text file containing API keys
echo "Enter the path to the file containing Heroku API keys:"
read file_path

# Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Read the file line by line and check each API key
while IFS= read -r api_key; do
    check_api_key "$api_key"
done < "$file_path"
