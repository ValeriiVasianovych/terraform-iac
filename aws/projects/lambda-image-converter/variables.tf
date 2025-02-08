variable "region" {
    description = "The AWS region to deploy the resources."
    type        = string
    default     = "us-east-1"
}

variable "source_bucket_name" {
    description = "The name of the bucket to store the source images."
    type        = string
    default     = "source-images"
}

variable "modified_bucket_name" {
    description = "The name of the bucket to store the modified images."
    type        = string
    default     = "modified-images"
}

variable "function_name" {
    description = "The name of the Lambda function."
    type        = string
    default     = "image-converter"
}

variable "common_tags" {
    description = "The tags to apply to all resources."
    type        = map(string)
    default     = {
        Environment = "Production"
        Owner       = "Valerii Vasianovych"
    }
}