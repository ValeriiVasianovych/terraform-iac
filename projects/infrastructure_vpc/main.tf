terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Owner     = "Valerii Vasianovych"
      CreatedBy = "Terraform"
      Project   = "Infrastructure_VPC"
    }
  }
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# Create resources

# Create VPC
resource "aws_vpc" "Infrastructure_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "Infrastructure_vpc"
    Account = "VPC in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "VPC in Region: ${data.aws_region.current.description}"
  }
}

# Create Public Subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.10.0/24"
  tags = {
    Name    = "Public Subnet A ${data.aws_availability_zones.available.names[0]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create Public Subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.20.0/24"
  tags = {
    Name    = "Public Subnet B ${data.aws_availability_zones.available.names[1]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create Private Subnet A
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.11.0/24"
  tags = {
    Name    = "Private Subnet A ${data.aws_availability_zones.available.names[0]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create Private Subnet B
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.21.0/24"
  tags = {
    Name    = "Private Subnet B ${data.aws_availability_zones.available.names[1]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create DB Subnet A
resource "aws_subnet" "db_subnet_a" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.12.0/24"
  tags = {
    Name    = "DB Subnet A ${data.aws_availability_zones.available.names[0]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create DB Subnet B
resource "aws_subnet" "db_subnet_b" {
  vpc_id            = aws_vpc.Infrastructure_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.22.0/24"
  tags = {
    Name    = "DB Subnet B ${data.aws_availability_zones.available.names[1]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Infrastructure_vpc.id
  tags = {
    Name    = "Internet Gateway"
    Account = "IGW in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "IGW in Region: ${data.aws_region.current.description}"
  }
}

# Create Elastic IP for NAT Gateway A
resource "aws_eip" "nat_eip_a" {
  vpc = true
  tags = {
    Name    = "NAT EIP"
    Account = "EIP in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "EIP in Region: ${data.aws_region.current.description}"
  }
}

# Create NAT Gateway for Private Subnet A
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.private_subnet_a.id
  tags = {
    Name    = "NAT Gateway A"
    Account = "NAT Gateway in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "NAT Gateway in Region: ${data.aws_region.current.description}"
  }
}

# Create Elastic IP for NAT Gateway B
resource "aws_eip" "nat_eip_b" {
  vpc = true
  tags = {
    Name    = "NAT EIP"
    Account = "EIP in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "EIP in Region: ${data.aws_region.current.description}"
  }
}

# Create NAT Gateway for Private Subnet B
resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.private_subnet_b.id
  tags = {
    Name    = "NAT Gateway B"
    Account = "NAT Gateway in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "NAT Gateway in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Infrastructure_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name    = "Public Route Table"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Associate Public Subnet A with Public Route Table
resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Subnet B with Public Route Table
resource "aws_route_table_association" "public_subnet_b_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Route Table for Private Subnet A with NAT Gateway A
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.Infrastructure_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }
  tags = {
    Name    = "Private Route Table A"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table for Private Subnet B with NAT Gateway B
resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.Infrastructure_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }
  tags = {
    Name    = "Private Route Table B"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Associate Private Subnet A with Private Route Table A
resource "aws_route_table_association" "private_subnet_a_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

# Associate Private Subnet B with Private Route Table B
resource "aws_route_table_association" "private_subnet_b_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_b.id
}

# Create Route Table for DB Subnet
resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.Infrastructure_vpc.id
  tags = {
    Name    = "DB Route Table"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Associate DB Subnet A with DB Route Table
resource "aws_route_table_association" "db_subnet_a_association" {
  subnet_id      = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.db_route_table.id
}

# Associate DB Subnet B with DB Route Table
resource "aws_route_table_association" "db_subnet_b_association" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.db_route_table.id
}


# Create Security Group for VPC 443, 80, 22 in my vpc
resource "aws_security_group" "vpc_sg" {
  name        = "VPC Security Group"
  description = "Allow HTTP, HTTPS and SSH inbound traffic"
  vpc_id      = aws_vpc.Infrastructure_vpc.id
  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "VPC Security Group"
    Account = "Security Group in Account: ${data.aws_caller_identity.current.account_id}"
  }
}

# Launch Template for Bastion Host
resource "aws_launch_template" "bastion_host" {
  image_id      = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  vpc_security_group_ids = [aws_security_group.vpc_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "Bastion Host"
      Owner   = "Valerii Vasianovych"
      Project = "Infrastructure_VPC"
    }
  }
}

# Create Target Group for Bastion Host 
resource "aws_lb_target_group" "bastion_tg" {
  port     = 22
  protocol = "TCP"
  vpc_id   = aws_vpc.Infrastructure_vpc.id
  tags = {
    Name    = "Bastion Target Group"
    Account = "Target Group in Account: ${data.aws_caller_identity.current.account_id}"
  }
}

# Create ASG for Bastion Host
resource "aws_autoscaling_group" "bastion_asg" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  launch_template {
    id      = aws_launch_template.bastion_host.id
    version = "$Latest"
  }
  target_group_arns   = [aws_lb_target_group.bastion_tg.arn]
  vpc_zone_identifier = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  tag {
    key                 = "Name"
    value               = "Bastion Host"
    propagate_at_launch = true
  }
}

# Create Instance in Private Subnet A
resource "aws_instance" "private_instance_a" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "ServersKey"
  subnet_id              = aws_subnet.private_subnet_a.id
  vpc_security_group_ids = [aws_security_group.vpc_sg.id]
  tags = {
    Name    = "Private Instance A"
    Owner   = "Valerii Vasianovych"
    Project = "Infrastructure_VPC"
  }
}

# Create Instance in DB Subnet A
resource "aws_instance" "db_instance_a" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  key_name               = "ServersKey"
  subnet_id              = aws_subnet.db_subnet_a.id
  vpc_security_group_ids = [aws_security_group.vpc_sg.id]
  tags = {
    Name    = "DB Instance A"
    Owner   = "Valerii Vasianovych"
    Project = "Infrastructure_VPC"
  }
}

output "Region" {
  value = data.aws_region.current.name
}

output "RegionDescription" {
  value = data.aws_region.current.description
}

output "Account" {
  value = data.aws_caller_identity.current.account_id
}

output "VPC_ID" {
  value = aws_vpc.Infrastructure_vpc.id
}

output "ElaticIP_A" {
  value = aws_eip.nat_eip_a.public_ip
}

output "ElaticIP_B" {
  value = aws_eip.nat_eip_b.public_ip
}