# Creation of ALB for private instances
locals {
  valid_subnets = length(var.private_subnet_ids) >= 2
}

resource "aws_lb" "private_instance_alb" {
  count              = local.valid_subnets ? 1 : 0
  name               = "${var.env}-private-instance-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_sg.id]
  subnets            = var.private_subnet_ids

  tags = {
    Name = "${var.env}-private-instance-alb"
  }
}

resource "aws_lb_target_group" "private_instance_tg" {
  count       = local.valid_subnets ? 1 : 0
  name        = "${var.env}-private-instance-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "${var.env}-private-instance-tg"
  }
}

resource "aws_lb_listener" "private_instance_listener_https" {
  count             = length(var.private_subnet_ids) >= 2 ? 1 : 0
  load_balancer_arn = aws_lb.private_instance_alb[0].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.app_cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_instance_tg[0].arn
  }

  depends_on = [aws_acm_certificate_validation.app_cert]
}

# resource "aws_lb_listener" "private_instance_listener" {
#   count             = local.valid_subnets ? 1 : 0
#   load_balancer_arn = aws_lb.private_instance_alb[0].arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.private_instance_tg[0].arn
#   }
# }

# Creation of ASG for private instances
resource "aws_launch_template" "private_instance_lt" {
  count         = length(var.private_subnet_ids) > 0 ? 1 : 0
  image_id      = var.ami
  instance_type = var.instance_type_private_instance
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/scripts/install-nginx.sh")
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.private_sg.id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = {
    Name = "${var.env}-private-instance-lt"
  }
}

resource "aws_autoscaling_group" "private_instance_asg" {
  count               = length(var.private_subnet_ids) > 0 ? 1 : 0
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = length(var.private_subnet_ids)
  max_size            = length(var.private_subnet_ids)
  min_size            = 1

  launch_template {
    id      = aws_launch_template.private_instance_lt[0].id
    version = "$Latest"
  }

  target_group_arns = local.valid_subnets ? [aws_lb_target_group.private_instance_tg[0].arn] : []

  dynamic "tag" {
    for_each = {
      Name = "${var.env}-private-instance-asg-${count.index + 1}"
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

