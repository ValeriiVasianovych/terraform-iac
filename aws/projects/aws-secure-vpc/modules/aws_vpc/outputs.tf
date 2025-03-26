output "region" {
  value = var.region
}

output "env" {
  value = var.env
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "public_subnet_cidrs" {
  value = [
    for subnet in aws_subnet.public_subnets :
    "Public Subnet ${subnet.tags.Name} Info: Subnet ID: ${subnet.id}, CIDR: ${subnet.cidr_block}"
  ]
}

output "private_subnet_cidrs" {
  value = [
    for subnet in aws_subnet.private_subnets :
    "Private Subnet ${subnet.tags.Name} Info: Subnet ID: ${subnet.id}, CIDR: ${subnet.cidr_block}"
  ]
}

output "db_private_subnet_cidrs" {
  value = [
    for subnet in aws_subnet.db_private_subnets :
    "DB Private Subnet ${subnet.tags.Name} Info: Subnet ID: ${subnet.id}, CIDR: ${subnet.cidr_block}"
  ]
}