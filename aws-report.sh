#!/bin/bash

aws_region=$1
date
echo "LISTING EC2 INSTANCES IN REGION $aws_region"
aws ec2 describe-instances --region $aws_region
echo "LISTING S3 BUCKETS IN REGION $aws_region"
aws s3 ls --region $aws_region 
echo "LISTING RDS INSTANCES IN REGION $aws_region"
aws rds describe-db-instances --region $aws_region 
echo "LISTING DYNAMODB TABLES IN REGION $aws_region"
aws dynamodb list-tables --region $aws_region
echo "LISTING LAMBDA FUNCTIONS IN REGION $aws_region"
aws lambda list-functions --region $aws_region
echo "LISTING EBS VOLUMES IN REGION $aws_region"
aws ec2 describe-volumes --region $aws_region 
echo "LISTING ELASTIC LOAD BALANCERS IN REGION $aws_region"
aws elb describe-load-balancers --region $aws_region
echo "LISTING IAM USERS"
aws iam list-users >> report.txt
echo "LISTING VPCs IN REGION $aws_region"
aws ec2 describe-vpcs --region $aws_region 
    