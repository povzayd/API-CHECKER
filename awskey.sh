#Aws key:secret
#!/bin/bash

#Prompt the user for the file containing API keys
read -p "Enter the path to the file containing API keys (format: AWS_ACCESS_KEY_ID:AWS_SECRET_ACCESS_KEY): " file_path

#Check if the file exists
if [[ ! -f "$file_path" ]]; then
    echo "File does not exist."
    exit 1
fi

#Loop through each line (API key) in the file
while IFS= read -r line; do
    # Skip empty lines
    if [[ -z "$line" ]]; then
        continue
    fi

    # Trim whitespace
    line=$(echo "$line" | xargs)

    # Split the line into access key and secret key
    AWS_ACCESS_KEY_ID=${line%%:*}
    AWS_SECRET_ACCESS_KEY=${line#*:}

    # Check if both access key and secret key are present
    if [[ -z "$AWS_ACCESS_KEY_ID" || -z "$AWS_SECRET_ACCESS_KEY" ]]; then
        echo "Invalid API key format: $line"
        continue
    fi

    echo "Checking API key: $AWS_ACCESS_KEY_ID"

    # Make the API request
    response=$(AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY aws sts get-caller-identity --output text --query 'Account' 2>&1)

    # Interpret the response
    if [[ $? -eq 0 ]]; then
        echo "✅ API key '$AWS_ACCESS_KEY_ID' is VALID."
    else
        echo "❌ API key '$AWS_ACCESS_KEY_ID' is INVALID: $response"
    fi
done < "$file_path"
```

#Input file format AWS_ACCESS_KEY:CLIENT_SECRET
