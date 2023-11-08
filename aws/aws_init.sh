#!/bin/bash

# This is to pratcie AWS Cli
# IAM admin account:  aws_admin, https://179666141320.signin.aws.amazon.com/console
# bastion : awsstation01
# private key has been stored

#connect with AWS account
aws configure
#Provide access keys and login 
#---------- Connecting with EC2 instance -------
chmod 400 awsstation01.pem #giving necessary permissions 
ssh -i "./keys/awsstation01.pem" ec2-user@ec2-54-158-23-13.compute-1.amazonaws.com #connect with DNS name