output "Region" {
  value = data.aws_region.current.name
}

output "RegionDescription" {
  value = data.aws_region.current.description
}

output "Account" {
  value = data.aws_caller_identity.current.account_id
}

output "VPC_ID" {
  value = aws_vpc.infrastructure_vpc.id
}

output "ElasitcIP_A" {
  value = aws_eip.nat_eip_a.public_ip
}

output "ElasitcIP_B" {
  value = aws_eip.nat_eip_b.public_ip
}