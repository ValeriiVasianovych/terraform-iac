output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "source_bucket_name" {
  value = var.source_bucket_name
}

output "modified_bucket_name" {
  value = var.modified_bucket_name
}

output "function_name" {
  value = var.function_name
}