#!/bin/bash

DEPLOY_BUCKET="twin-deploy-1776433537"

# Delete the file and bucket (replace with your bucket name)
aws s3 rm s3://$DEPLOY_BUCKET/lambda-deployment.zip
aws s3 rb s3://$DEPLOY_BUCKET
