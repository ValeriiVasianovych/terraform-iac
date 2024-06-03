variable "region" {
  description = "My AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "The environment to launch the instance"
  type        = string
  default     = "Development"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "Example of Local Variables"
}


variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "Valerii Vasianovych"
}

variable "allow_sg_ports" {
  description = "The list of ports to allow in the security group"
  type        = list(number)
  default     = [22, 80, 443]
}