#for weglot
#!/bin/bash

#Prompt the user for the file containing API keys
read -ep "Enter the path to the file containing API keys: " file

#Check if the file exists
if [[ ! -f "$file" ]]; then
    echo "File not found!"
    exit 1
fi

#Read the file line by line
while IFS= read -r key || [[ -n "$key" ]]; do
    # Remove any leading/trailing whitespace
    key=$(echo "$key" | xargs)
    if [[ -z "$key" ]]; then
        continue
    fi

    # Send a request to the API using the key
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.weglot.com/translate?api_key=$key")

    # Check the response code
    if [[ "$response" -eq 200 ]]; then
        echo "API key '$key' is VALID."
    else
        echo "API key '$key' is INVALID (HTTP $response)."
    fi
done < "$file"
