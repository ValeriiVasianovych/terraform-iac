variable "region" {
  description = "Google cloud region"
  type        = string
  default     = "us-central1"
}

variable "gcloud_project_id" {
  description = "Google cloud project id"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    environment = "development"
    project     = "gcp_first_project"
    owner       = "valerii_vasianovych"
  }
}