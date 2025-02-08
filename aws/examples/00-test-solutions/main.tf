# Datasources
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# Variables
variable "region" {
  type        = string
  description = "The region in which to launch the EC2 instance"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "The environment in which to launch the EC2 instance"
  default     = "dev"
}

# variable "instance_types" {
#   type        = map(string)
#   description = "The types of instances to launch"
#   default = {
#     dev     = "t2.micro"
#     staging = "t2.medium"
#     prod    = "t2.large"
#   }
# }

locals {
  file_content = file("${path.module}/hello-tf.txt") # Path module is the directory where the current module is located
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply to all resources"
  default = {
    Owner    = "Valerii Vasianovych"
    Provider = "AWS-Terraform"
  }
}

# Provider
provider "aws" {
  region = var.region
}

# Resources
# resource "aws_instance" "example_ec2" {
#   ami               = data.aws_ami.latest_ubuntu.id
# #   instance_type     = lookup(var.instance_types, var.environment, "t3.micro")
#   instance_type = (terraform.workspace == "dev" ? "t3.micro" : "t2.medium")
#   availability_zone = "${var.region}-a"
#   key_name          = "ServersKey"
#   tags = merge(var.common_tags, {
#     Name = "ec2-instance"
#   })
# }

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "An example security group for Terraform"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "example_sg"
    Owner = "Valerii Vasianovych"
  }
}

# Outputs
# output "created_instance_type" {
#   value = aws_instance.example_ec2.instance_type
# }

# output "created_instance_az" {
#   value = aws_instance.example_ec2.availability_zone
# }

output "file_content" {
  value = local.file_content
}