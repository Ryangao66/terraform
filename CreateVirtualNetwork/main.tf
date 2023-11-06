terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}

resource "azurerm_resource_group" "example" {
  name     = "mra-test-aes-net-rg"
  location = "Australia East"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}


resource "azurerm_virtual_network" "example" {
  name                = "mra-test-aes-net-vnet10.x"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/8"]


  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}


resource "azurerm_subnet" "example01" {
  name                 = "subnet10.1.x"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.0.0/16"]


}

resource "azurerm_subnet" "example02" {
  name                 = "subnet10.2.x"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.2.0.0/16"]


}


