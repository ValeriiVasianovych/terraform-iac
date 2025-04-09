# output "bastion_host_public_ip" {
#   value = length(var.public_subnet_ids) > 0 ? aws_autoscaling_group.bastion_host[0].instances[0].public_ip : null
# }

# data "aws_autoscaling_group" "bastion_group" {
#   name = aws_autoscaling_group.bastion_host.name
# }

# data "aws_instance" "bastion_instance" {
#   instance_id = data.aws_autoscaling_group.bastion_group.instances[0].instance_id
# }

# output "bastion_host_public_ip" {
#   value = length(var.public_subnet_ids) > 0 ? data.aws_instance.bastion_instance.public_ip : null
# }

output "route53_hosted_zone_id" {
  value = aws_route53_record.app_domain_record.zone_id
}

output "alb_hosted_zone_id" {
  value = length(var.private_subnet_ids) > 0 ? aws_lb.private_instance_alb[0].zone_id : null
}