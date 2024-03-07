#!/bin/bash

# Extracting the IP address from Terraform output
public_ip=$(terraform output -raw ec2_public_ip)

#Testing HTTP to HTTPS redirection
http_status_code=$(curl -s -o /dev/null -w "%{http_code}" http://${public_ip}/)
echo "HTTP Status Code: $http_status_code"
if [ "$http_status_code" -ne 301 ]; then
  echo "HTTP to HTTPS redirection test failed"
  exit 1
fi

# Testing HTTPS connection
https_status_code=$(curl -s -k -o /dev/null -w "%{http_code}" https://${public_ip}/)
echo "HTTPS Status Code: $https_status_code"
if [ "$https_status_code" -ne 200 ]; then
  echo "HTTPS connection test failed"
  exit 1
fi

echo "All tests passed successfully"
exit 0
