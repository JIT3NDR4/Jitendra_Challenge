#!/bin/bash

#Deploying Infrastructure
terraform init &&
terraform apply -auto-approve &&
public_ip=$(terraform output -raw ec2_public_ip) &&

#Configuring the Machine
ansible-playbook -i $public_ip, configure_server.yml &&

# Running Tests
bash tests.sh
