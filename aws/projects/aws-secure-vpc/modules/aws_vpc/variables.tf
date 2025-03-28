variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIRDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["192.168.10.0/24", "192.168.20.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["192.168.11.0/24", "192.168.21.0/24"]
}

variable "db_private_subnet_cidrs" {
  description = "The CIDR blocks for the database subnets"
  type        = list(string)
  default     = ["192.168.12.0/24", "192.168.22.0/24"]
}

variable "env" {
  description = "The environment"
  type        = string
  default     = "test"
}