terraform {
  backend "s3" {
    bucket       = "terrafrom-tfstate-file-s3-bucket"
    encrypt      = true
    key          = "aws/tfstates/projects/aws-secure-vpc/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Owner       = "Valerii Vasianovych with ID"
      Project     = "Cybersecurity Project in ${var.region} region. Project: AWS Cloud and Terraform IaC"
      Environment = var.env
      Region      = "Region: ${var.region}"
    }
  }
}

module "vpc_dev" {
  source                  = "../../modules/aws_vpc"
  region                  = var.region
  env                     = var.env
  vpc_cidr                = "10.0.0.0/16"
  public_subnet_cidrs     = []
  private_subnet_cidrs    = []
  db_private_subnet_cidrs = []
  account_id              = data.aws_caller_identity.current.id
}

module "compute_dev" {
  source                = "../../modules/aws_compute"
  region                = module.vpc_dev.region
  env                   = module.vpc_dev.env
  vpc_id                = module.vpc_dev.vpc_id
  public_subnet_ids     = module.vpc_dev.public_subnet_ids
  private_subnet_ids    = module.vpc_dev.private_subnet_ids
  db_private_subnet_ids = module.vpc_dev.db_private_subnet_ids
  client_vpn_cidr_block = "10.200.0.0/22"
  vpn_server_cert_arn   = var.vpn_server_cert_arn
  vpn_client_cert_arn   = var.vpn_client_cert_arn
  account_id            = data.aws_caller_identity.current.id

  instance_type_bastion          = var.instance_types["bastion"]
  instance_type_public_instance  = var.instance_types["public_instance"]
  instance_type_private_instance = var.instance_types["private_instance"]
  instance_type_db_instance      = var.instance_types["db_instance"]
  bastion_ami                    = data.aws_ami.latest_openvpn.id
  ami                            = data.aws_ami.latest_ubuntu.id
  key_name                       = var.key_name
  hosted_zone_name               = var.hosted_zone_name
  hosted_zone_id                 = data.aws_route53_zone.hosted_zone.zone_id
  public_sg                      = [22, 443, 1194, 943, 945]
  private_sg                     = [22, 80, 443, 5000]
  db_private_sg                  = []

  depends_on = [module.vpc_dev]
}
