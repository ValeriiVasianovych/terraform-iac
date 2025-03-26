provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner       = "Valerii Vasianovych with ID: ${var.account_id}"
      Project     = "Cybersecurity Project in ${var.region} region. Project: AWS Cloud and Terraform IaC"
      Environment = "${var.env}"
      Region      = "Region: ${var.region}"
    }
  }
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc-${var.env}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-${var.env}"
  }
}