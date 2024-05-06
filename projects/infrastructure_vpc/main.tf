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

# Create VPC
resource "aws_vpc" "infrastructure_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "Infrastructure_vpc"
    Account = "VPC in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "VPC in Region: ${data.aws_region.current.description}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "infrastructure_igw" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  tags = {
    Name    = "Infrastructure_IGW"
    Account = "IGW in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "IGW in Region: ${data.aws_region.current.description}"
  } 
}

# Create Public Subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.infrastructure_vpc.id
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
  vpc_id            = aws_vpc.infrastructure_vpc.id
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
  vpc_id            = aws_vpc.infrastructure_vpc.id
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
  vpc_id            = aws_vpc.infrastructure_vpc.id
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
  vpc_id            = aws_vpc.infrastructure_vpc.id
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
  vpc_id            = aws_vpc.infrastructure_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.22.0/24"
  tags = {
    Name    = "DB Subnet B ${data.aws_availability_zones.available.names[1]}"
    Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Subnet in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infrastructure_igw.id
  }
  tags = {
    Name    = "Public Route Table"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table For DB Subnets
resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  tags = {
    Name    = "DB Route Table"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table for Private Subnet A
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.infrastructure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }

  tags = {
    Name    = "Private Route Table A"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Create Route Table for Private Subnet B
resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.infrastructure_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }

  tags = {
    Name    = "Private Route Table B"
    Account = "Route Table in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Route Table in Region: ${data.aws_region.current.description}"
  }
}

# Create Elastic IP for NAT Gateway in Public Subnet A
resource "aws_eip" "nat_eip_a" {
  vpc = true
  tags = {
    Name    = "NAT EIP A"
    Account = "EIP in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "EIP in Region: ${data.aws_region.current.description}"
  }
}

# Create Elastic IP for NAT Gateway in Public Subnet B
resource "aws_eip" "nat_eip_b" {
  vpc = true
  tags = {
    Name    = "NAT EIP B"
    Account = "EIP in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "EIP in Region: ${data.aws_region.current.description}"
  }
}

# Create NAT Gateway for Public Route Table A
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags = {
    Name    = "NAT Gateway A"
    Account = "NAT Gateway in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "NAT Gateway in Region: ${data.aws_region.current.description}"
  }
}

# Create NAT Gateway in Public Subnet B
resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_subnet_b.id
  tags = {
    Name    = "NAT Gateway B"
    Account = "NAT Gateway in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "NAT Gateway in Region: ${data.aws_region.current.description}"
  }
}

# Associate Public Route Table with Public Subnet A
resource "aws_route_table_association" "public_route_table_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Route Table with Public Subnet B
resource "aws_route_table_association" "public_route_table_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Private Route Table A with Private Subnet A
resource "aws_route_table_association" "private_route_table_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

# Associate Private Route Table B with Private Subnet B
resource "aws_route_table_association" "private_route_table_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table_b.id
}

# Associate DB Route Table with DB Subnet A
resource "aws_route_table_association" "db_route_table_association_a" {
  subnet_id      = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.db_route_table.id
}

# Associate DB Route Table with DB Subnet B
resource "aws_route_table_association" "db_route_table_association_b" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.db_route_table.id
}

# Create Security Group for Bastion Host with SSH Inbound Rule and All Outbound Rule
resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.infrastructure_vpc.id
  tags = {
    Name    = "Bastion Security Group"
    Account = "Security Group in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Security Group in Region: ${data.aws_region.current.description}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Create Launch Template for Bastion Host
resource "aws_launch_template" "bastion_launch_template" {
  name_prefix   = "Bastion-host"
  image_id      = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"

  network_interfaces {
    security_groups = [aws_security_group.security_group.id]  # Associate security group here
  }
  
  tags = {
    Name    = "Bastion Host"
    Account = "Bastion Host in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Bastion Host in Region: ${data.aws_region.current.description}"
  }
}

# Create Autoscaling Group for Bastion Host
resource "aws_autoscaling_group" "bastion_autoscaling_group" {
  desired_capacity     = 1
  max_size             = 1
  min_size             = 1
  launch_template {
    id      = aws_launch_template.bastion_launch_template.id
    version = "$Latest"
  }

  vpc_zone_identifier = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

# Create Instance in Private Subnet A
resource "aws_instance" "private_instance_a" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  subnet_id     = aws_subnet.private_subnet_a.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name    = "Private Instance A"
    Account = "Instance in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Instance in Region: ${data.aws_region.current.description}"
  }
}

# Create Instance in DB Subnet A
resource "aws_instance" "db_instance_a" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  subnet_id     = aws_subnet.db_subnet_a.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name    = "DB Instance A"
    Account = "Instance in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Instance in Region: ${data.aws_region.current.description}"
  }
}

# Create Instance in Private Subnet B
resource "aws_instance" "private_instance_b" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  subnet_id     = aws_subnet.private_subnet_b.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name    = "Private Instance B"
    Account = "Instance in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Instance in Region: ${data.aws_region.current.description}"
  }
}

# Create Instance in DB Subnet B
resource "aws_instance" "db_instance_b" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ServersKey"
  subnet_id     = aws_subnet.db_subnet_b.id
  security_groups = [aws_security_group.security_group.id]
  tags = {
    Name    = "DB Instance B"
    Account = "Instance in Account: ${data.aws_caller_identity.current.account_id}"
    Region  = "Instance in Region: ${data.aws_region.current.description}"
  }
}