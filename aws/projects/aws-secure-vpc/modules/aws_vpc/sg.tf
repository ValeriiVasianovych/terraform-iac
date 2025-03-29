# SG for bastion host 80 443 and 22

resource "aws_security_group" "public-sg" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = var.public_sg
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-security-group-public"
  }
}

resource "aws_security_group" "private-sg" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = var.private_sg
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-security-group-private"
  }
}


resource "aws_security_group" "sg" {
  description = "Allows HTTP SSH"
  dynamic "ingress" {
    for_each = var.db_private_sg
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-security-group-db"
  }
}