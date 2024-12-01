### How works tfstate remote
Requires:
1. Create a bucket in AWS S3
2. Create a DynamoDB table

Scenario:
1. Developer 1 creates: VPC, Subnets, IGW, Route Tables, Route Tables Association. The tfstate file is stored in the S3 bucket using: key: dev1/terraform.tfstate
2. Developer 2 creates: EC2, Security Group, Key Pair in the same VPC created by Developer 1 importing the tfstate file and defining own backend configuration to store the tfstate file in the S3 bucket using: key: dev2/terraform.tfstate
3. Developer 3 creates: ALB, Target Group, Listener, Listener Rule and ENI in the same VPC created by Developer 1 and Developer 2 using the tfstate file stored in the S3 bucket using: key: dev3/terraform.tfstate

Dev1: Create VPC
Dev2: Create EC2
Dev3: ALB using VPC created by Dev1 and Instance created by Dev2