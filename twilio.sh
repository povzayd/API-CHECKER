#!/bin/bash

# Function to check the validity of a Twilio API key
check_api_key() {
    local account_sid=$1
    local auth_token=$2
    response=$(curl -s -o /dev/null -w "%{http_code}" -X GET 'https://api.twilio.com/2010-04-01/Accounts.json' \
        -u "$account_sid:$auth_token")
    
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Twilio Credentials: $account_sid:$auth_token"
    else
        echo "❌ Invalid Twilio Credentials: $account_sid:$auth_token"
    fi
}

# Prompt the user for the text file containing Twilio credentials
echo "Enter the path to the file containing Twilio credentials (ACCOUNT_SID:AUTH_TOKEN format per line):"
read file_path

# Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Read the file line by line and check each credential set
while IFS= read -r credentials; do
    account_sid=$(echo "$credentials" | cut -d ':' -f1)
    auth_token=$(echo "$credentials" | cut -d ':' -f2)
    check_api_key "$account_sid" "$auth_token"
done < "$file_path"
                                      
