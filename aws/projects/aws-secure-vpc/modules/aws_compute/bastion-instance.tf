
resource "aws_launch_template" "bastion_host" {
  count                  = length(var.public_subnet_ids) > 0 ? 1 : 0
  image_id               = var.ami
  instance_type          = var.instance_type_public_instance
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  #user_data = filebase64("${path.module}/script.sh")
  network_interfaces {
  associate_public_ip_address = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = {
    Name = "bastion-host-launch-template"
  }
}

resource "aws_autoscaling_group" "bastion_host" {
  count               = length(var.public_subnet_ids) > 0 ? 1 : 0
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.bastion_host[0].id
    version = "$Latest"
  }
  dynamic "tag" {
    for_each = {
      Name   = "bastion-host-auto-scaling-group"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}