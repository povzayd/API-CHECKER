#bash
#!/bin/bash

#Function to check the validity of a Shodan API key
check_api_key() {
    local token=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.shodan.io/shodan/host/8.8.8.8?key=$token")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Shodan API Key: $token"
    else
        echo "❌ Invalid Shodan API Key: $token"
    fi
}

#prompt the user for the text file containing Shodan API tokens
echo "Enter the path to the file containing Shodan API tokens (one per line):"
read file_path

#Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

#Read the file line by line and check each token
while IFS= read -r token; do
    check_api_key "$token"
done < "$file_path"
