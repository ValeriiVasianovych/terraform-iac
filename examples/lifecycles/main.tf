terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lifecycle_instance" {
  ami                    = "ami-07d9b9ddc6cd8dd30"
  instance_type          = "t3.micro"
  key_name               = "ServersKey"
  vpc_security_group_ids = [aws_security_group.lifecycle_security_group.id]

# If you have running instance and you want to prevent it from being destroyed, you can use the following block:

  lifecycle {
    # prevent_destroy = true
    # ignore_changes  = [ami, instance_type]
  }

  tags = {
    Name    = "LifecycleUbuntuServer"
    Owner   = "Valerii Vasianovych"
    Project = "AWS Instance Creation with Terraform and dynamic template"
  }
}

resource "aws_security_group" "lifecycle_security_group" {
  name        = "terraform_server"
  description = "An example security group for Terraform"

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
}