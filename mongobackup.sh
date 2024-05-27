#!/bin/bash

# Set variables
MONGO_HOST=localhost
MONGO_PORT=27017
MONGO_USER=myUserAdmin
MONGO_PASSWORD=password
S3_BUCKET=factious-unriddle-graphic
BACKUP_DIR=/home/ec2-user/mbd

# Create backup directory
# mkdir -p $BACKUP_DIR

# Perform mongodump
mongodump --host $MONGO_HOST --port $MONGO_PORT --username $MONGO_USER --password $MONGO_PASSWORD --out $BACKUP_DIR

# Sync backup files to S3
aws s3 sync $BACKUP_DIR s3://$S3_BUCKET