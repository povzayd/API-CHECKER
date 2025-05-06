
#!/bin/bash

#Function to check the validity of a Keen.io API read key
check_api_key() {
    local line=$1
    local project_id=$(echo "$line" | cut -d':' -f1)
    local api_key=$(echo "$line" | cut -d':' -f2)
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        "https://api.keen.io/3.0/projects/$project_id/events?api_key=$api_key")
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Keen.io API Key for project $project_id"
    else
        echo "❌ Invalid Keen.io API Key for project $project_id"
    fi
}

#Prompt the user for the text file containing Keen.io project_id:api_key pairs
echo "Enter the path to the file containing Keen.io project_id:api_key pairs (one per line):"
read file_path

#Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

#Read the file line by line and check each project_id/api_key pair
while IFS= read -r line; do
    check_api_key "$line"
done < "$file_path"
