terraform {
  backend "s3" {
    bucket = "terrafrom-tfstate-file-s3-bucket"
    # dynamodb_table = "terraform-tfstate-dynamodb"
    encrypt = true
    key     = "aws/tfstates/projects/eks-project/terraform.tfstate"
    region  = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}
