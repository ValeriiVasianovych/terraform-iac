# Remote Terraform State Management

This project demonstrates how to manage Terraform state remotely using AWS S3 and DynamoDB. By storing tfstate files in S3 and leveraging DynamoDB for state locking, multiple developers can safely collaborate on infrastructure development.

### Requirements:
1. Create an AWS S3 bucket for storing tfstate files.
2. Set up a DynamoDB table for state locking.

### Scenario:
- **Developer 1** creates the initial VPC, Subnets, IGW, Route Tables, and Associations. The tfstate file is stored in S3 under `dev1/terraform.tfstate`.
- **Developer 2** adds EC2 instances, Security Groups, and Key Pairs within the VPC created by Developer 1. The tfstate file is stored under `dev2/terraform.tfstate` in S3.
- **Developer 3** provisions an ALB, Target Group, Listener, Listener Rule, and ENI in the same VPC and EC2 setup. Their tfstate is stored under `dev3/terraform.tfstate`.

This approach ensures that all developers work in the same environment while maintaining separate tfstate files to avoid conflicts.