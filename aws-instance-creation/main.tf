terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "my_windows" {
  ami           = "ami-0f9c44e98edf38a2b"
  instance_type = "t2.micro"

  tags = {
    Name = "WindowsInstance"
  }
}

resource "aws_instance" "my_ubuntu" {
  count = 2
  ami           = "ami-07d9b9ddc6cd8dd30"
  instance_type = "t2.micro"

  tags = {
    Name = "UbuntuInstance"
  }
}