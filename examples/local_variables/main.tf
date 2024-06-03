terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_vpc" "default" {}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${local.full_project_name}"
}

locals {
  country   = "Ireland"
  city      = "Dublin"
  az_list   = join(",", data.aws_availability_zones.available.names)
  region    = var.region
  location  = "In ${local.region}, there are AZ: ${local.az_list}"
  city_info = "In ${data.aws_region.current.name}, is located ${local.city}"
}


resource "aws_security_group" "local-var-sg" {
  name        = "Local Variables Security Group"
  description = "Allow HTTP, HTTPS and SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.allow_sg_ports
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
    Name         = "Local Variables Security Group"
    Project      = "${local.full_project_name} Security Group"
    Owner        = var.owner
    ProjectOwner = local.project_owner
    city         = local.city
    country      = local.country
    region       = local.region
    location     = local.location
    city_info    = local.city_info
  }
}



