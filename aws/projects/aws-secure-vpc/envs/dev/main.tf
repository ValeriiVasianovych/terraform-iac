terraform {
  backend "s3" {
    bucket       = "terrafrom-tfstate-file-s3-bucket"
    encrypt      = true
    key          = "aws/tfstates/projects/aws-secure-vpc/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

module "vpc_dev" {
  source                  = "../../modules/aws_vpc"
  region                  = "us-east-1"
  env                     = "development"
  vpc_cidr                = "10.0.0.0/16"
  public_subnet_cidrs     = ["10.0.10.0/24", "10.0.11.0/24"]
  private_subnet_cidrs    = ["10.0.20.0/24"]
  db_private_subnet_cidrs = ["10.0.30.0/24", "10.0.31.0/24"]
  account_id              = data.aws_caller_identity.current.account_id
}


