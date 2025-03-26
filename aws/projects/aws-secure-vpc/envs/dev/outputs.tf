output "vpc_dev_region" {
  value = module.vpc_dev.region
}

output "vpc_dev_env" {
  value = module.vpc_dev.env
}

output "vpc_dev_vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "vpc_dev_vpc_cidr_block" {
  value = module.vpc_dev.vpc_cidr_block
}

output "vpc_dev_public_subnet_cidrs" {
  value = module.vpc_dev.public_subnet_cidrs
}

output "vpc_dev_private_subnet_cidrs" {
  value = module.vpc_dev.private_subnet_cidrs
}

output "vpc_dev_db_private_subnet_cidrs" {
  value = module.vpc_dev.db_private_subnet_cidrs
}