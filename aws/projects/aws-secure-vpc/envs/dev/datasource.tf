data "aws_caller_identity" "current" {}
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_openvpn" {
  owners      = ["444663524611"]
  most_recent = true

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_route53_zone" "hosted_zone" {
  name = var.hosted_zone_name
}

