
#!/bin/bash

#Function to check the validity of a Pivotal Tracker API token
check_api_key() {
    local token=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" -X GET -H "X-TrackerToken: $token" "https://www.pivotaltracker.com/services/v5/me?fields=%3Adefault")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Pivotal Tracker API Token: $token"
    else
        echo "❌ Invalid Pivotal Tracker API Token: $token"
    fi
}

#Prompt the user for the text file containing Pivotal Tracker API tokens
echo "Enter the path to the file containing Pivotal Tracker API tokens (one per line):"
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
#ThankYou
#make a table format & set options to call each. code written in notepad.
