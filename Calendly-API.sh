
#!/bin/bash

Function to check the validity of a Calendly API token
check_api_key() {
    local token=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" --header "X-TOKEN: $token" https://calendly.com/api/v1/users/me)
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Calendly API Token: $token"
    else
        echo "❌ Invalid Calendly API Token: $token"
    fi
}

Prompt the user for the text file containing Calendly API tokens
echo "Enter the path to the file containing Calendly API tokens (one per line):"
read file_path

Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

Read the file line by line and check each token
while IFS= read -r token; do
    check_api_key "$token"
done < "$file_path"
