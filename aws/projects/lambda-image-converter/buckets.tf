terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = ">= 4.0"
        }
    }
}

provider "aws" {
    region = var.region
}

resource "s3_bucket" "source_images" {
  bucket =  var.source_bucket_name
  tags = merge(var.common_tags, {
        Name = var.source_bucket_name
    })
}

resource "s3_bucket" "modifue" {
  bucket = var.modified_bucket_name
  tags = merge(var.common_tags, {
    Name = var.modified_bucket_name
  })
}