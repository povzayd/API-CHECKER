#start linkedin client id & secret
#!/bin/bash

#Function to check the validity of a LinkedIn client ID and secret pair
check_api_key() {
    local credentials=$1
    local client_id=$(echo "$credentials" | cut -d':' -f1)
    local client_secret=$(echo "$credentials" | cut -d':' -f2)
    response=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
        -H "Content-type: application/x-www-form-urlencoded" \
        -d "grant_type=client_credentials&client_id=$client_id&client_secret=$client_secret" \
        "https://www.linkedin.com/oauth/v2/accessToken")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid LinkedIn credentials: $client_id:$client_secret"
    else
        echo "❌ Invalid LinkedIn credentials: $client_id:$client_secret"
    fi
}

#Prompt the user for the text file containing LinkedIn client credentials
echo "Enter the path to the file containing LinkedIn credentials (client_id:client_secret per line):"
read file_path

#Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

#Read the file line by line and check each credential pair
while IFS= read -r credentials; do
    check_api_key "$credentials"
done < "$file_path"
