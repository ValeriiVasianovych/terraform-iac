variable "region" {
    type = string
    description = "The region in which to launch the EC2 instance"
    default = "us-east-1"
}

variable "instance_type" {
    type = string
    description = "The type of instance to launch"
    default = "t2.micro" 
}

variable "key_name" {
    type = string
    description = "The name of the key pair to use for the instance"
    default = "aws_ssh_key"
}

variable "count_instance" {
    type = number
    description = "The number of instances to launch"
    default = 1
}

variable "env" {
    type = string
    description = "The environment"
    default = "dev"
}