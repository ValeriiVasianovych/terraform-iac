terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
  required_version = ">= 1.1.3"
}

provider "azurerm" {
  features {}

  # subscription_id = "5ce38f..."
  # client_id       = "c3ec85..."
  # client_secret   = "T178Q~..."
  # tenant_id       = "2cdc8c..."
}
