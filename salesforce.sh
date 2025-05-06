#Salesforce API Checker 
#!/bin/bash

#Prompt the user for the instance name and file containing API keys
read -p "Enter your Salesforce instance name (e.g., your-domain.my): " instance_name
read -p "Enter the path to the file containing API keys: " file_path

#Check if the file exists
if [[ ! -f "$file_path" ]]; then
    echo "File does not exist."
    exit 1
fi

#Construct the base URL
base_url="https://${instance_name}.salesforce.com/services/data/v20.0/"

#Loop through each line (API key) in the file
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
        -H "Authorization: Bearer $api_key" \
        "$base_url")

    # Interpret the response
    if [[ "$response" == "200" ]]; then
        echo "✅ API key '$api_key' is VALID."
    else
        echo "❌ API key '$api_key' is INVALID (HTTP $response)."
    fi
done < "$file_path"
