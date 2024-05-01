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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
	Name = "my_vpc"
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
	Name = "dev_vpc"
  }
}

resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.20.0.0/16"
  tags = {
	Name = "prod_vpc"
  }
}

resource "aws_subnet" "prod_subnet_1" {
  vpc_id     = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "10.20.1.0/24"
  tags = {
	Name = "Subnet-1 ${data.aws_availability_zones.available.names[0]}"
	Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
	Region = "Subnet in Region: ${data.aws_region.current.name}"
	RegionDescription = "Region Description: ${data.aws_region.current.description}"
  }
}

resource "aws_subnet" "prod_subnet_2" {
  vpc_id     = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "10.20.2.0/24"
  tags = {
	Name = "Subnet-2 ${data.aws_availability_zones.available.names[1]}"
	Account = "Subnet in Account: ${data.aws_caller_identity.current.account_id}"
	Region = "Subnet in Region: ${data.aws_region.current.name}"
	RegionDescription = "Region Description: ${data.aws_region.current.description}"
  }
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}

data "aws_vpc" "prod_vpc" {
   tags = {
	 Name = "prod_vpc"
   }
}

