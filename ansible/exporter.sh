#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output_file>"
    exit 1
fi

output_file="$1"

# Fetch the provisioned host IPs using terraform output
workers_ips=$(terraform output -json workers_ips | jq -r '.[]')

# Write the header to the specified output file
echo "[servers]" > "$output_file"

# Loop through each IP address and write the formatted entry to the specified output file
i=1
for ip in ${workers_ips[@]}; do
    echo "worker${i} ansible_host=${ip} ansible_user=root" >> "$output_file"
    ((i++))
done
