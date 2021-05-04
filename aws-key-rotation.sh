#!/bin/bash

# Inspired by: https://uly.me/aws-rotate-iam-keys/

# This script will automate the rotation of AWS access keys, which should be rotated regularly for security and compliance reasons

# TO USE:

# Update the following variables:
# - USER - Your AWS user name
# - LOCAL_BASE_PATH - The location of the .aws folder for your user. Will contain a config and credentials file

# Set some variables
USER=''
LOCAL_BASE_PATH=''

AWS="docker run --rm -it -v $LOCAL_BASE_PATH:/root/.aws amazon/aws-cli"

NEW_KEY_FILE="$LOCAL_BASE_PATH/new-access-key.json"
OLD_KEY_FILE="$LOCAL_BASE_PATH/old-access-key.json"
CREDENTIALS_FILE="$LOCAL_BASE_PATH/credentials"

# Retrieve Old credentials
echo 'LISTING EXISTING KEYS'
$AWS iam list-access-keys --user-name $USER > $OLD_KEY_FILE

# Create new key
echo 'CREATING NEW KEY'
$AWS iam create-access-key --user-name $USER > $NEW_KEY_FILE


# Backup old credentials
cp $CREDENTIALS_FILE $LOCAL_BASE_PATH/credentials-backup

# SET new access keys and new secret variables
NEW_ACCESS_KEY=$(grep -o '"AccessKeyId": "[^"]*' $NEW_KEY_FILE | grep -o '[^"]*$')
NEW_ACCESS_SECRET=$(grep -o '"SecretAccessKey": "[^"]*' $NEW_KEY_FILE | grep -o '[^"]*$')

# store the new key
echo '[default]' > $CREDENTIALS_FILE
echo 'aws_access_key_id = '$NEW_ACCESS_KEY >> $CREDENTIALS_FILE
echo 'aws_secret_access_key = '$NEW_ACCESS_SECRET >> $CREDENTIALS_FILE
sleep 10

# Delete old key
OLD_ACCESS_KEY=$(grep -o '"AccessKeyId": "[^"]*' $OLD_KEY_FILE | grep -o '[^"]*$')

echo 'DELETING KEYS'
$AWS iam delete-access-key --user-name $USER --access-key-id $OLD_ACCESS_KEY

# Cleanup
rm $NEW_KEY_FILE
rm $OLD_KEY_FILE
