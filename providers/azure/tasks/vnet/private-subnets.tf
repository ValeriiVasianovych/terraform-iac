
# Private Subnets
resource "azurerm_subnet" "private" {
  count                = length(var.private_subnets)
  name                 = var.private_subnets[count.index].name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnets[count.index].address_prefix]
}

# Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gateway" {
  name                = "${var.project_name}-${var.environment}-nat-gateway-pip"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "NAT Gateway Public IP"
  }
}

# NAT Gateway
resource "azurerm_nat_gateway" "main" {
  name                    = "${var.project_name}-${var.environment}-nat-gateway"
  location                = azurerm_resource_group.vnet_rg.location
  resource_group_name     = azurerm_resource_group.vnet_rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "NAT Gateway for Private Subnets"
  }
}

# Associate NAT Gateway with Public IP
resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.nat_gateway.id
}

# Associate NAT Gateway with Private Subnets
resource "azurerm_subnet_nat_gateway_association" "private" {
  count          = length(azurerm_subnet.private)
  subnet_id      = azurerm_subnet.private[count.index].id
  nat_gateway_id = azurerm_nat_gateway.main.id
}

# Network Security Group for Private Subnets
resource "azurerm_network_security_group" "private" {
  name                = "${var.project_name}-${var.environment}-private-nsg"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name

  # Deny inbound traffic from Internet
  security_rule {
    name                       = "DenyInternetInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  # Allow communication within VNet
  security_rule {
    name                       = "AllowVNetInbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"
  }

  # Allow outbound traffic to Internet (through NAT Gateway)
  security_rule {
    name                       = "AllowOutboundInternet"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  # Allow communication with other subnets
  security_rule {
    name                       = "AllowToVNet"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/16"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Purpose     = "Private Subnets NSG"
  }
}

# Associate NSG with Private Subnets
resource "azurerm_subnet_network_security_group_association" "private" {
  count                     = length(azurerm_subnet.private)
  subnet_id                 = azurerm_subnet.private[count.index].id
  network_security_group_id = azurerm_network_security_group.private.id
}
