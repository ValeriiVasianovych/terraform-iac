# ---------------------------------------------------------------------------------------------------------------------
# Common Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name for the resources"
  type        = string
  default     = "dev"
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default = {
    Owner     = "Valerii Vasianovych"
    Project   = "EKS Cluster"
    Terraform = "true"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# VPC Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "eks-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.20.0/24", "10.0.21.0/24"]
}

# ---------------------------------------------------------------------------------------------------------------------
# EKS Cluster Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-development"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.28"
}

# ---------------------------------------------------------------------------------------------------------------------
# Local Values
# ---------------------------------------------------------------------------------------------------------------------
locals {
  cluster_tags = merge(var.common_tags, {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  })
}