#
#!/bin/bash

#Prompt the user for the file containing API keys
read -p "Enter the path to the file containing API keys: " file_path

#Check if the file exists
if [[ ! -f "$file_path" ]]; then
    echo "File does not exist."
    exit 1
fi

#Loop through each line (API key) in the file
while IFS= read -r api_key; do
    # Skip empty lines
    if [[ -z "$api_key" ]]; then
        continue
    fi

    echo "Checking API key: $api_key"

    # Make the API request
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "Authorization: Bearer $api_key" \
        https://api.spotify.com/v1/me)

    # Interpret the response
    if [[ "$response" == "200" ]]; then
        echo "-> VALID"
    else
        echo "-> INVALID (HTTP $response)"
    fi

    echo "---------------------------"
done < "$file_path"
