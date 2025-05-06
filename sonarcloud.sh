#sh Sonarcloud ke liye api Checker 
#!/bin/bash

#Prompt user for the token file
read -p "Enter the path to the file containing SonarCloud API tokens: " file

#Check if the file exists
if [[ ! -f "$file" ]]; then
    echo "File not found!"
    exit 1
fi

#Read and validate each token
while IFS= read -r token || [[ -n "$token" ]]; do
    token=$(echo "$token" | xargs) # Trim whitespace
    if [[ -z "$token" ]]; then
        continue
    fi

    # Validate using curl with basic auth
    response=$(curl -s -o /dev/null -w "%{http_code}" -u "$token:" "https://sonarcloud.io/api/authentication/validate")
    if [[ "$response" -eq 200 ]]; then
        echo "Token '$token' is VALID."
    else
        echo "Token '$token' is INVALID (HTTP $response)."
    fi
done < "$file"
