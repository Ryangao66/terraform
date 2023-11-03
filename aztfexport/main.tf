resource "azurerm_virtual_machine_extension" "res-0" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"69213211-d470-49eb-bbc8-ebd8bb5b60cc\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-3,
  ]
}
resource "azurerm_virtual_machine_extension" "res-1" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"69213211-d470-49eb-bbc8-ebd8bb5b60cc\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/102a"
  depends_on = [
    azurerm_windows_virtual_machine.res-5,
  ]
}


resource "azurerm_resource_group" "res-2" {
  location = "australiaeast"
  name     = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
}
resource "azurerm_windows_virtual_machine" "res-3" {
  admin_password        = "Welcome321!321!"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "101a"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/101a581"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    owner = "Ryan"
    usage = "TerrafromTesting"
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
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-6,
  ]
}
resource "azurerm_windows_virtual_machine" "res-4" {
  admin_password        = "Welcome321!321!"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "101b"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/101b894"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
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
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-8,
  ]
}
resource "azurerm_windows_virtual_machine" "res-5" {
  admin_password        = "Welcome321!321!"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "102a"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/102a581"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
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
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-10,
  ]
}
resource "azurerm_network_interface" "res-6" {
  location            = "australiaeast"
  name                = "101a581"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    owner = "Ryan"
    usage = "TerrafromTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/101a-ip"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_public_ip.res-22,
    azurerm_subnet.res-26,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-7" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/101a581"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/101a-nsg"
  depends_on = [
    azurerm_network_interface.res-6,
    azurerm_network_security_group.res-12,
  ]
}
resource "azurerm_network_interface" "res-8" {
  location            = "australiaeast"
  name                = "101b894"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/101b-ip"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_public_ip.res-23,
    azurerm_subnet.res-26,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-9" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/101b894"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/101b-nsg"
  depends_on = [
    azurerm_network_interface.res-8,
    azurerm_network_security_group.res-14,
  ]
}
resource "azurerm_network_interface" "res-10" {
  location            = "australiaeast"
  name                = "102a581"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/102a-ip"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.2.x"
  }
  depends_on = [
    azurerm_public_ip.res-24,
    # One of azurerm_subnet.res-27,azurerm_subnet_network_security_group_association.res-28 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_interface_security_group_association" "res-11" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/102a581"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/102a-nsg"
  depends_on = [
    azurerm_network_interface.res-10,
    azurerm_network_security_group.res-16,
  ]
}
resource "azurerm_network_security_group" "res-12" {
  location            = "australiaeast"
  name                = "101a-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-13" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "101a-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-12,
  ]
}
resource "azurerm_network_security_group" "res-14" {
  location            = "australiaeast"
  name                = "101b-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-15" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "101b-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-14,
  ]
}
resource "azurerm_network_security_group" "res-16" {
  location            = "australiaeast"
  name                = "102a-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-17" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "102a-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-16,
  ]
}
resource "azurerm_network_security_group" "res-18" {
  location            = "australiaeast"
  name                = "mra-test-aes-sgp"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-19" {
  access                      = "Allow"
  destination_address_prefix  = "10.2.0.4"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "AllowCidrBlockHTTPInbound"
  network_security_group_name = "mra-test-aes-sgp"
  priority                    = 100
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "10.1.0.100"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_security_rule" "res-20" {
  access                      = "Allow"
  destination_address_prefix  = "10.2.0.4"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "AllowCidrBlockRDPInbound"
  network_security_group_name = "mra-test-aes-sgp"
  priority                    = 110
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "10.1.0.200"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_security_rule" "res-21" {
  access                      = "Deny"
  destination_address_prefix  = "10.2.0.0/16"
  destination_port_range      = "*"
  direction                   = "Inbound"
  name                        = "DenyCidrBlockCustomAnyInbound"
  network_security_group_name = "mra-test-aes-sgp"
  priority                    = 120
  protocol                    = "*"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "10.1.0.0/16"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_public_ip" "res-22" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "101a-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_public_ip" "res-23" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "101b-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_public_ip" "res-24" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "102a-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_virtual_network" "res-25" {
  address_space       = ["10.0.0.0/8"]
  location            = "australiaeast"
  name                = "mra-test-aes-net-vnet10.x"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "Ryan"
    usage = "TerrafromTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_subnet" "res-26" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-25,
  ]
}
resource "azurerm_subnet" "res-27" {
  address_prefixes     = ["10.2.0.0/16"]
  name                 = "subnet10.2.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-25,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-28" {
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/mra-test-aes-sgp"
  subnet_id                 = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.2.x"
  depends_on = [
    azurerm_network_security_group.res-18,
    azurerm_subnet.res-27,
  ]
}
