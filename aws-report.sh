#!/bin/bash

#AWS daily report generator
#version:1.2
#author: D Kishore Kumar
#description:generates a daily aws report and saves it to a file.
#usage:./aws-report.sh <aws_region>

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI not installed. Please install it first."
    exit 1
fi

# Validate input
if [ -z "$1" ]; then
    echo "❌ Usage: $0 <aws_region>"

    exit 1
fi

aws_region=$1
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")  # Generates timestamp
report_file="aws-report-${timestamp}.txt"  # Report filename
echo -e "Report saving as: $report_file"
# Report Header

{
echo "====================================="
echo "📅 AWS REPORT - $timestamp"
echo "📍 Region: $aws_region"
echo "====================================="

# Listing AWS Resources

echo -e "\n🔹 LISTING EC2 INSTANCES..."
aws ec2 describe-instances --region $aws_region \
    --query "Reservations[].Instances[].{ID:InstanceId,State:State.Name,Type:InstanceType}" \
    --output table 

echo -e "\n🔹 LISTING S3 BUCKETS..."
aws s3 ls --region $aws_region --output table

echo -e "\n🔹 LISTING RDS INSTANCES..."
aws rds describe-db-instances --region $aws_region \
    --query "DBInstances[].{ID:DBInstanceIdentifier,Engine:Engine,Status:DBInstanceStatus}" \
    --output table 

echo -e "\n🔹 LISTING DYNAMODB TABLES..."
aws dynamodb list-tables --region $aws_region 

echo -e "\n🔹 LISTING LAMBDA FUNCTIONS..."
aws lambda list-functions --region $aws_region \
    --query "Functions[].FunctionName" --output table 

echo -e "\n🔹 LISTING EBS VOLUMES..."
aws ec2 describe-volumes --region $aws_region \
    --query "Volumes[].{ID:VolumeId,State:State,Size:Size}" --output table 

echo -e "\n🔹 LISTING ELASTIC LOAD BALANCERS..."
aws elb describe-load-balancers --region $aws_region \
    --query "LoadBalancerDescriptions[].LoadBalancerName" --output table 

echo -e "\n🔹 LISTING IAM USERS..."
aws iam list-users --query "Users[].{Name:UserName,Created:CreateDate}" --output table 

echo -e "\n Report saved as: $report_file"

} >> "$report_file"
aws s3 cp ${report_file} s3://dkmybucket/


