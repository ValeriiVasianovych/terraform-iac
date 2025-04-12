output "bastion_instance_id" {
  value       = length(var.public_subnet_ids) > 0 ? data.aws_instances.bastion_instances[0].ids : []
  description = "List of IDs of the bastion instances managed by the ASG."
}

output "bastion_instance_ip" {
  value       = length(var.public_subnet_ids) > 0 ? data.aws_instances.bastion_instances[0].public_ips : []
  description = "List of public IPs of the bastion instances managed by the ASG."
}

output "bastion_host_azs" {
  value       = length(var.public_subnet_ids) > 0 ? [data.aws_subnet.public_subnets[0].availability_zone] : []
  description = "List of Availability Zones of the bastion instances."
}

output "private_instance_id" {
  value       = local.valid_subnets ? data.aws_instances.private_instances[0].ids : []
  description = "List of IDs of the private instances managed by the ASG."
}

output "private_instance_ip" {
  value       = local.valid_subnets ? data.aws_instances.private_instances[0].private_ips : []
  description = "List of private IPs of the private instances managed by the ASG."
}

output "private_instances_azs" {
  value       = local.valid_subnets ? (local.use_nlb ? [data.aws_subnet.private_subnets[0].availability_zone] : [for subnet in data.aws_subnet.private_subnets : subnet.availability_zone]) : []
  description = "List of Availability Zones of the private instances."
}

output "application_domain_name" {
  value       = local.valid_subnets ? aws_route53_record.app_domain_record[0].fqdn : null
  description = "The fully qualified domain name (FQDN) of the application, or null if no private subnets are created."
}