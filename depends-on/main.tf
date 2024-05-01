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
  region = "us-east-1"
}


resource "aws_s3_bucket" "bucket-1" {
  bucket = "my-tf-bucket-1-s3"
  }

resource "aws_s3_bucket" "bucket-2" {
  bucket = "my-tf-bucket-2-s3"
  depends_on = [ aws_s3_bucket.bucket-1 ]

}

resource "aws_s3_bucket" "bucket-3" {
  bucket = "my-tf-bucket-3-s3"
  depends_on = [ aws_s3_bucket.bucket-1, aws_s3_bucket.bucket-2 ]
}
  