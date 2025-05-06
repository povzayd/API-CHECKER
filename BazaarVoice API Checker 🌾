
#!/bin/bash

#Function to check the validity of a Bazaarvoice Conversations API passkey
check_api_key() {
    local passkey=$1
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://which-cpv-api.bazaarvoice.com/clientInfo?conversationspasskey=$passkey" --insecure)
    if [ "$response" -eq 200 ]; then
        echo "✅ Valid Bazaarvoice Passkey: $passkey"
    else
        echo "❌ Invalid Bazaarvoice Passkey: $passkey"
    fi
}

#Prompt the user for the text file containing Bazaarvoice passkeys
echo "Enter the path to the file containing Bazaarvoice passkeys (one per line):"
read file_path

#Check if file exists
if [ ! -f "$file_path" ]; then
    echo "Error: File not found!"
    exit 1
fi

#Read the file line by line and check each passkey
while IFS= read -r passkey; do
    check_api_key "$passkey"
done < "$file_path"

#
#
#
