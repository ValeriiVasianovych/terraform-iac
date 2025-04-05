# output "bastion_host_public_ip" {
#   value = length(var.public_subnet_ids) > 0 ? aws_autoscaling_group.bastion_host[0].instances[0].public_ip : null
# }

