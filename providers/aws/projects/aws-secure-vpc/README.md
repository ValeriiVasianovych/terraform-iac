### bastion config
```hcl
# resource "aws_launch_template" "bastion_instance" {
#   count       = local.create_public_resources ? 1 : 0
#   image_id      = var.bastion_ami
#   instance_type = var.instance_type_bastion
#   key_name      = var.key_name
#   #user_data = filebase64("${path.module}/script.sh")
#   network_interfaces {
#     associate_public_ip_address = true
#     security_groups             = length(var.public_subnet_ids) > 0 ? [aws_security_group.public_sg[0].id] : []
#   }

#   metadata_options {
#     http_endpoint = "enabled"
#     http_tokens   = "required"
#   }
#   tags = {
#     Name = "${var.env}-bastion-host-lt"
#   }
# }

# resource "aws_autoscaling_group" "bastion_instance" {
#  count               = local.create_public_resources ? 1 : 0
#   vpc_zone_identifier = var.public_subnet_ids
#   desired_capacity    = 1
#   max_size            = 1
#   min_size            = 1

#   launch_template {
#     id      = aws_launch_template.bastion_instance[0].id
#     version = "$Latest"
#   }
#   tag {
#     key                 = "Name"
#     value               = "${var.env}-bastion-host"
#     propagate_at_launch = true
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }
```