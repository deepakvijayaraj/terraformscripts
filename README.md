# Readme

This repo consists of terraform scripts that can 
 * assign permissions to S3 bucket for a given user id on specific folders with read or write permission
 * assign permission to a specific user id to start/stop EC2 server for a specific duration ( Eg: 3 days)
 
## Instructions to run this script

# for S3 bucket access

For a new user, create a new file with the relevant S3 bucket name, folder names to which read and write access is needed and place it in "users"

A template is provided for reference
users/templateuser.tfvars

Invoke the below script with the module name and user name: 
sh script/main.sh bucketpermission <user name>

Ex: sh script/main.sh bucketpermission jane.doe

# for temporary access to start / stop ec2 server for a given user id

Invoke the below script with the module name and user name: 
sh script/main.sh modifyec2permission <user name>

Ex: sh script/main.sh modifyec2permission jane.doe

