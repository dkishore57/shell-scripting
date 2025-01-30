#!/bin/bash
# AWS Resource Listing Script
# Version: 1.0
# Author: Your Name
# Description: This script lists AWS resources based on the service name provided as an argument.
# Usage: ./script.sh <region> <service_name>
# Example: ./script.sh us-east-1 EC2
# Metadata: Requires AWS CLI configured with necessary permissions.

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then
    echo "Incorrect usage!"
    echo "Format: $0 <region> <service_name>"
    exit 1
fi

# Assigning input arguments to variables
aws_service=$2
aws_region=$1

# Case statement to check the provided AWS service and execute the corresponding AWS CLI command
case $2 in 
    EC2)
        echo "LISTING $2 INSTANCES IN REGION $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    S3)
        echo "LISTING S3 BUCKETS IN REGION $aws_region"
        aws s3 ls --region $aws_region
        ;;
    RDS)
        echo "LISTING RDS INSTANCES IN REGION $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    DYNAMODB)
        echo "LISTING DYNAMODB TABLES IN REGION $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    LAMBDA)
        echo "LISTING LAMBDA FUNCTIONS IN REGION $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    EBS)
        echo "LISTING EBS VOLUMES IN REGION $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    ELB)
        echo "LISTING ELASTIC LOAD BALANCERS IN REGION $aws_region"
        aws elb describe-load-balancers --region $aws_region
        ;;
    IAM)
        echo "LISTING IAM USERS"
        aws iam list-users 
        ;;
    VPC)
        echo "LISTING VPCs IN REGION $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    *)
        echo "INVALID SERVICE NAME OR SERVICE NOT SUPPORTED IN THIS SCRIPT"
        ;;
esac
