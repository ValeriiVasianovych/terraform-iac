terraform {
    backend "s3" {
    bucket         = "terrafrom-tfstate-file-s3-bucket"
    # dynamodb_table = "terrafrom-tfstate-dynamodb"
    encrypt        = true
    key            = "aws/tfstates/ami_data-source/terraform.tfstate"
    region         = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}