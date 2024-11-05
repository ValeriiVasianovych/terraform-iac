resource "aws_instance" "dynamic_template_server" {
  ami                    = "ami-07d9b9ddc6cd8dd30"
  instance_type          = "t2.micro"
  key_name               = "ServersKey"
  vpc_security_group_ids = [aws_security_group.terraform-server.id]
  user_data = templatefile("template.sh.tpl", {
    f_name  = "Valerii"
    l_name  = "Vasianovych"
    email   = "valerii.vasianovych.2003@gmail.com"
    age     = "20"
    friends = ["Sarah", "John", "Michael"]
  })

  tags = {
    Name    = "TerraformUbuntuServer"
    Owner   = "Valerii Vasianovych"
    Project = "AWS Instance Creation with Terraform and dynamic template"
  }
}

resource "aws_security_group" "terraform-server" {
  name        = "terraform_server"
  description = "An example security group for Terraform"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]

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
}