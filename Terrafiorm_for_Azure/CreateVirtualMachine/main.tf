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

resource "azurerm_network_interface" "example01" {
  name                = "101a740"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "example02" {
  name                = "101b740"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example01.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "example01" {
  name                = "101a"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B2s"
  admin_username      = "ryan"
  admin_password      = "Welcome321!321!"
  network_interface_ids = [
    azurerm_network_interface.example01.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "example02" {
  name                = "101b"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B2s"
  admin_username      = "ryan"
  admin_password      = "Welcome321!321!"
  network_interface_ids = [
    azurerm_network_interface.example02.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
