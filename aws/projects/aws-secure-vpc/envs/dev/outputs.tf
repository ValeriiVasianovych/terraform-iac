output "vpc_region" {
  value       = module.vpc_dev.region
  description = "The AWS region of the VPC."
}

output "vpc_env" {
  value       = module.vpc_dev.env
  description = "The environment of the VPC."
}

output "vpc_id" {
  value       = module.vpc_dev.vpc_id
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = module.vpc_dev.vpc_cidr_block
  description = "The CIDR block of the VPC."
}

output "public_subnet_cidr_blocks" {
  value       = module.vpc_dev.public_subnet_cidr_blocks
  description = "The CIDR blocks of the public subnets."
}

output "public_subnet_ids" {
  value       = module.vpc_dev.public_subnet_ids
  description = "The IDs of the public subnets."
}

output "private_subnet_cidr_blocks" {
  value       = module.vpc_dev.private_subnet_cidr_blocks
  description = "The CIDR blocks of the private subnets."
}

output "private_subnet_ids" {
  value       = module.vpc_dev.private_subnet_ids
  description = "The IDs of the private subnets."
}

output "db_private_subnet_cidr_blocks" {
  value       = module.vpc_dev.db_private_subnet_cidr_blocks
  description = "The CIDR blocks of the database private subnets."
}

output "db_private_subnet_ids" {
  value       = module.vpc_dev.db_private_subnet_ids
  description = "The IDs of the database private subnets."
}

output "bastion_instance_id" {
  value       = module.compute_dev.bastion_instance_id
  description = "List of IDs of the bastion instances managed by the ASG."
}

output "bastion_instance_ip" {
  value       = module.compute_dev.bastion_instance_ip
  description = "List of public IPs of the bastion instances managed by the ASG."
}

output "bastion_host_azs" {
  value       = module.compute_dev.bastion_host_azs
  description = "List of Availability Zones of the bastion instances."
}

output "private_instance_id" {
  value       = module.compute_dev.private_instance_id
  description = "List of IDs of the private instances managed by the ASG."
}

output "private_instance_ip" {
  value       = module.compute_dev.private_instance_ip
  description = "List of private IPs of the private instances managed by the ASG."
}

output "private_instances_azs" {
  value       = module.compute_dev.private_instances_azs
  description = "List of Availability Zones of the private instances."
}

output "application_domain_name" {
  value       = module.compute_dev.application_domain_name
  description = "The fully qualified domain name (FQDN) of the application, or null if no private subnets are created."
}
