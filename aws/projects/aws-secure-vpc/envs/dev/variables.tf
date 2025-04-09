variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

# variable "vpc_cidr" {
#   description = "The CIRDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "public_subnet_cidrs" {
#   description = "The CIDR blocks for the public subnets"
#   type        = list(string)
#   default     = ["10.0.10.0/24", "10.0.11.0/24"]
# }

# variable "private_subnet_cidrs" {
#   description = "The CIDR blocks for the private subnets"
#   type        = list(string)
#   default     = ["10.0.20.0/24", "10.0.21.0/24"]
# }

# variable "db_private_subnet_cidrs" {
#   description = "The CIDR blocks for the database subnets"
#   type        = list(string)
#   default     = ["10.0.30.0/24", "10.0.31.0/24"]
# }

variable "env" {
  description = "The environment"
  type        = string
  default     = "development"
}

variable "key_name" {
  description = "The name of the key pair to be used for SSH access"
  type        = string
}

variable "hosted_zone_name" {
  description = "The name of the hosted zone"
  type        = string
}

variable "instance_types" {
  description = "Map of instance types for different components"
  type        = map(string)
  default = {
    bastion          = "t2.micro"
    public_instance  = "t2.micro"
    private_instance = "t2.micro"
    db_instance      = "db.t2.micro"
  }
}