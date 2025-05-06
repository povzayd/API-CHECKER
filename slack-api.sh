
#!/bin/bash

Function to check the validity of a Slack Bot Token
check_api_key() {
    local token=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "https://slack.com/api/auth.test" -H "Accept: application/json; charset=utf-8" -H "Authorization: Bearer $token")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Slack Bot Token: $token"
    else
        echo "❌ Invalid Slack Bot Token: $token"
    fi
}

Prompt the user for the text file containing Slack Bot Tokens
echo "Enter the path to the file containing Slack Bot Tokens (one per line):"
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
