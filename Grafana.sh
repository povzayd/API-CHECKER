#sh
#!/bin/bash

#Function to check the validity of a Grafana API key
check_api_key() {
    local api_key=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $api_key" "http://your-grafana-server-url.com/api/user")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Grafana API Key: $api_key"
    else
        echo "❌ Invalid Grafana API Key: $api_key"
    fi
}

#Prompt the user for the text file containing Grafana API keys
echo "Enter the path to the file containing Grafana API keys (one per line):"
read file_path

#Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

#Read the file line by line and check each API key
while IFS= read -r api_key; do
    check_api_key "$api_key"
done < "$file_path"
 
