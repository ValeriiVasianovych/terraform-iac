output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  description = "Location of the created resource group"
  value       = azurerm_resource_group.rg.location
}

output "vnet_name" {
  description = "Name of the created virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "ID of the created virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

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

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in azurerm_subnet.public : subnet.id]
}

output "public_subnet_names" {
  description = "List of public subnet names"
  value       = [for subnet in azurerm_subnet.public : subnet.name]
}

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

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in azurerm_subnet.private : subnet.id]
}

output "private_subnet_names" {
  description = "List of private subnet names"
  value       = [for subnet in azurerm_subnet.private : subnet.name]
}

output "public_nsg_id" {
  description = "ID of the public subnets NSG"
  value       = azurerm_network_security_group.public.id
}

output "public_nsg_name" {
  description = "Name of the public subnets NSG"
  value       = azurerm_network_security_group.public.name
}

output "private_nsg_id" {
  description = "ID of the private subnets NSG"
  value       = azurerm_network_security_group.private.id
}

output "private_nsg_name" {
  description = "Name of the private subnets NSG"
  value       = azurerm_network_security_group.private.name
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = azurerm_route_table.public.id
}

output "public_route_table_name" {
  description = "Name of the public route table"
  value       = azurerm_route_table.public.name
}

output "public_routes" {
  description = "Public route table routes"
  value = {
    for k, route in azurerm_route.public : k => {
      name                   = route.name
      address_prefix         = route.address_prefix
      next_hop_type          = route.next_hop_type
      next_hop_in_ip_address = route.next_hop_in_ip_address
    }
  }
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = azurerm_route_table.private.id
}

output "private_route_table_name" {
  description = "Name of the private route table"
  value       = azurerm_route_table.private.name
}

output "private_routes" {
  description = "Private route table routes"
  value = {
    for k, route in azurerm_route.private : k => {
      name                   = route.name
      address_prefix         = route.address_prefix
      next_hop_type          = route.next_hop_type
      next_hop_in_ip_address = route.next_hop_in_ip_address
    }
  }
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = var.enable_nat_gateway ? azurerm_nat_gateway.main[0].id : null
}

output "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  value       = var.enable_nat_gateway ? azurerm_nat_gateway.main[0].name : null
}

output "nat_gateway_public_ip_id" {
  description = "ID of the NAT Gateway Public IP"
  value       = var.enable_nat_gateway ? azurerm_public_ip.nat_gateway[0].id : null
}

output "nat_gateway_public_ip_address" {
  description = "Public IP address of the NAT Gateway"
  value       = var.enable_nat_gateway ? azurerm_public_ip.nat_gateway[0].ip_address : null
}

output "vnet_info" {
  description = "Complete VNet information for use in other modules"
  value = {
    vnet_id             = azurerm_virtual_network.vnet.id
    vnet_name           = azurerm_virtual_network.vnet.name
    vnet_address_space  = tolist(azurerm_virtual_network.vnet.address_space)[0]
    resource_group_name = azurerm_resource_group.rg.name
    resource_group_id   = azurerm_resource_group.rg.id
    location            = azurerm_resource_group.rg.location
    public_subnets = {
      for idx, subnet in azurerm_subnet.public : subnet.name => {
        id             = subnet.id
        address_prefix = subnet.address_prefixes[0]
        name           = subnet.name
        nsg_id         = azurerm_network_security_group.public.id
        route_table_id = azurerm_route_table.public.id
      }
    }
    private_subnets = {
      for idx, subnet in azurerm_subnet.private : subnet.name => {
        id             = subnet.id
        address_prefix = subnet.address_prefixes[0]
        name           = subnet.name
        nsg_id         = azurerm_network_security_group.private.id
        route_table_id = azurerm_route_table.private.id
        nat_gateway_id = var.enable_nat_gateway ? azurerm_nat_gateway.main[0].id : null
      }
    }
    nat_gateway = var.enable_nat_gateway ? {
      id                = azurerm_nat_gateway.main[0].id
      name              = azurerm_nat_gateway.main[0].name
      public_ip_id      = azurerm_public_ip.nat_gateway[0].id
      public_ip_address = azurerm_public_ip.nat_gateway[0].ip_address
    } : null
  }
}

