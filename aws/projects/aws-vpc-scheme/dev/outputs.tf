output "aws_region" {
  value = data.aws_region.current.name
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  value = aws_vpc.infrastructure_vpc.id
}

output "elasitc_ip_a" {
  value = aws_eip.nat_eip_a.public_ip
}

output "elasitc_ip_b" {
  value = aws_eip.nat_eip_b.public_ip
}