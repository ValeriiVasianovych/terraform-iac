variable "account_id" {
  description = "The AWS account ID"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "test"
}

variable "bastion_ami" {
  description = "Amazon Machine Image ID for the bastion host"
  type        = string
  default     = ""
}

variable "ami" {
  description = "Amazon Machine Image ID for EC2 instances"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
  default     = []
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
  default     = []
}

variable "db_private_subnet_ids" {
  description = "List of database private subnet IDs"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Name of the SSH key pair for EC2 instances"
  type        = string
}

variable "instance_type_bastion" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "instance_type_public_instance" {
  description = "EC2 instance type for public instances"
  type        = string
  default     = "t2.micro"
}

variable "instance_type_private_instance" {
  description = "EC2 instance type for private instances"
  type        = string
  default     = "t2.micro"
}

variable "instance_type_db_instance" {
  description = "EC2 instance type for database instances"
  type        = string
  default     = "t2.micro"
}

variable "public_sg" {
  description = "The ports for the public security group : SSH, HTTP, HTTPS, OpenVPN, OpenVPN Access Server"
  type        = list(number)
  default     = [22, 443, 1194, 943]
}

variable "private_sg" {
  description = "The ports for the private security group: SSH, HTTP, HTTPS, FlaskApp"
  type        = list(string)
  default     = [22, 443, 5000]
}

variable "db_private_sg" {
  description = "The ports for the database security group: mySQL"
  type        = list(string)
  default     = [22, 3306]
}

variable "hosted_zone_name" {
  description = "The name of the hosted zone"
  type        = string
}

variable "hosted_zone_id" {
  description = "The id of the hosted zone"
  type        = string
}

variable "client_vpn_cidr_block" {
  description = "The id of the hosted zone"
  type        = string
  default = "10.200.0.0/22"
}

variable "vpn_server_cert_arn" {
  description = "The name of the server certificate"
  type        = string
}

variable "vpn_client_cert_arn" {
  description = "The name of the client certificate"
  type        = string
}

locals {
  create_public_resources  = length(var.public_subnet_ids) > 0
  create_private_resources = length(var.private_subnet_ids) > 0
  create_db_resources      = length(var.db_private_subnet_ids) > 0

  use_nlb       = local.create_private_resources && length(var.private_subnet_ids) == 1
  use_alb       = local.create_private_resources && length(var.private_subnet_ids) >= 2
}
