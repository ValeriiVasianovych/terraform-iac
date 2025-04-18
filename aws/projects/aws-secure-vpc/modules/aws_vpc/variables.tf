variable "account_id" {
  description = "The AWS account ID"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "The environment"
  type        = string
  default     = "test"
}

variable "vpc_cidr" {
  description = "The CIRDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "db_private_subnet_cidrs" {
  description = "The CIDR blocks for the database subnets"
  type        = list(string)
  default     = ["10.0.30.0/24", "10.0.31.0/24"]
}