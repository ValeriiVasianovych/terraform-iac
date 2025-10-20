# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.vnet_rg.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.vnet_rg.id
}

output "resource_group_location" {
  description = "Location of the created resource group"
  value       = azurerm_resource_group.vnet_rg.location
}

# Virtual Network Outputs
output "vnet_name" {
  description = "Name of the created virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "ID of the created virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.main.address_space
}

# Public Subnets Outputs
output "public_subnets" {
  description = "Information about public subnets"
  value = {
    for idx, subnet in azurerm_subnet.public : subnet.name => {
      id             = subnet.id
      address_prefix = subnet.address_prefixes[0]
      name           = subnet.name
    }
  }
}

# Private Subnets Outputs
output "private_subnets" {
  description = "Information about private subnets"
  value = {
    for idx, subnet in azurerm_subnet.private : subnet.name => {
      id             = subnet.id
      address_prefix = subnet.address_prefixes[0]
      name           = subnet.name
    }
  }
}

# NAT Gateway Outputs
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = azurerm_nat_gateway.main.id
}

output "nat_gateway_public_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = azurerm_public_ip.nat_gateway.ip_address
}

# Network Security Groups Outputs
output "public_nsg_id" {
  description = "ID of the public subnets NSG"
  value       = azurerm_network_security_group.public.id
}

output "private_nsg_id" {
  description = "ID of the private subnets NSG"
  value       = azurerm_network_security_group.private.id
}

# Summary Output
output "network_summary" {
  description = "Summary of the created network infrastructure"
  value = {
    vnet_name          = azurerm_virtual_network.main.name
    vnet_address_space = azurerm_virtual_network.main.address_space
    public_subnets     = [for subnet in azurerm_subnet.public : subnet.name]
    private_subnets    = [for subnet in azurerm_subnet.private : subnet.name]
    nat_gateway_ip     = azurerm_public_ip.nat_gateway.ip_address
    location           = azurerm_resource_group.vnet_rg.location
  }
}
