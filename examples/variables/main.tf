terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}
data "aws_region" "current" {}
data "aws_vpc" "default" {}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_eip" "static_ip" { 
    instance = aws_instance.instance_ubuntu.id
    tags = merge(var.common_tags, {
        Name = "${var.common_tags["Environment"]} Server IP" 
    })
}

resource "aws_instance" "instance_ubuntu" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type             # Instance type, default is t2.micro
  key_name               = "ServersKey"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = file("script.sh")
  monitoring             = var.monitoring_value          # Monitoring, default is false

  tags = merge(var.common_tags, {                       # Tags to apply to the instance
    Name        = "Ubuntu Instance"
  })
}

resource "aws_security_group" "web_sg" {
  name        = "Web Security Group"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.allow_sg_ports                        # List of ports to open, default is [22, 80, 443]
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
    tags = merge(var.common_tags, {
        Name = "Web Security Group"
    })
}
