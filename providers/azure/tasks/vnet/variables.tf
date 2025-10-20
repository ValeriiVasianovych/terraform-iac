variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "West Europe"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "vnet-infrastructure"
}

variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnets" {
  description = "Public subnet configurations"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    {
      name           = "public-subnet-1"
      address_prefix = "10.0.10.0/24"
    },
    {
      name           = "public-subnet-2"
      address_prefix = "10.0.20.0/24"
    }
  ]
}

variable "private_subnets" {
  description = "Private subnet configurations"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    {
      name           = "private-subnet-1"
      address_prefix = "10.0.11.0/24"
    },
    {
      name           = "private-subnet-2"
      address_prefix = "10.0.21.0/24"
    }
  ]
}
