output "data_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}

output "aws_vpc_prod" {
  value = data.aws_vpc.prod_vpc.id
}

output "aws_vpc_prod_cidr_block" {
  value = data.aws_vpc.prod_vpc.cidr_block
}