#Opsgenie API Checker 
#!/bin/bash

Prompt the user for the file containing API keys
read -p "Enter the path to the file containing API keys: " file_path

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
        -H "Authorization: GenieKey $api_key" \
        https://api.opsgenie.com/v2/alerts)

    # Interpret the response
    if [[ "$response" == "200" ]]; then
        echo "✅ API key '$api_key' is VALID."
    else
        echo "❌ API key '$api_key' is INVALID (HTTP $response)."
    fi
done < "$file_path"

#
