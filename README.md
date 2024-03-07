# Jitendra Challenge
#### Deploying Static Website
---
##### Prerequitise
- Install Terraform and Ansible
- Note down AWS Creds and Download the .pem file to connect to AWS from Ansible
- Install boto3 library

##### Configuration
- Export AWS Creds
```
export AWS_ACCESS_KEY_ID=<Your AWS ACCESS KEY>
export AWS_SECRET_ACCESS_KEY=<Your AWS SECRET ACCESS KEY>
``` 
- In ansible.cfg change path to your private key
```
private_key_file = <Path_to_your private key>
```
##### Deploying
```
> bash deploy.sh
```