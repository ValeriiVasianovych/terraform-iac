data "aws_instances" "bastion_instances" {
  count = length(var.public_subnet_ids) > 0 ? 1 : 0

  instance_tags = {
    Name = "${var.env}-bastion-host-asg-*"
  }

  depends_on = [aws_autoscaling_group.bastion_instance]
}

data "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_ids)
  id    = var.public_subnet_ids[count.index]
}

data "aws_instances" "private_instances" {
  count = local.valid_subnets ? 1 : 0

  instance_tags = {
    Name = "${var.env}-private-instance-asg-*"
  }

  depends_on = [aws_autoscaling_group.private_instance_asg]
}

data "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_ids)
  id    = var.private_subnet_ids[count.index]
}