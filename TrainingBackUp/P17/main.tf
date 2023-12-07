resource "azurerm_resource_group" "res-0" {
  location = "australiaeast"
  name     = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}
resource "azurerm_windows_virtual_machine" "res-1" {
  admin_password        = "ignored-as-imported"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "vm101a"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    usage = "TerraformTesting"
  }
  additional_capabilities {
  }
  boot_diagnostics {
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-2,
  ]
}
resource "azurerm_network_interface" "res-2" {
  location            = "australiaeast"
  name                = "vm101a956"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/vm101a-ip"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_public_ip.res-6,
    azurerm_subnet.res-8,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-3" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  depends_on = [
    azurerm_network_interface.res-2,
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_network_security_group" "res-4" {
  location            = "australiaeast"
  name                = "vm101a-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-5" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "vm101a-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_public_ip" "res-6" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "vm101a-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-7" {
  address_space       = ["10.0.0.0/8"]
  location            = "australiaeast"
  name                = "mra-test-aes-net-vnet10.x"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_subnet" "res-8" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-7,
  ]
}
resource "azurerm_subnet" "res-9" {
  address_prefixes     = ["10.2.0.0/16"]
  name                 = "subnet10.2.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-7,
  ]
}
resource "azurerm_storage_account" "res-10" {
  account_replication_type         = "LRS"
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  location                         = "australiaeast"
  name                             = "mratestaesnetrgsa"
  resource_group_name              = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_share" "res-13" {
  name                 = "mrasharedfiles"
  quota                = 5120
  storage_account_name = "mratestaesnetrgsa"
}
