resource "azurerm_virtual_machine_extension" "res-0" {
  auto_upgrade_minor_version = true
  name                       = "MDE.Windows"
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  settings                   = "{\"autoUpdate\":true,\"azureResourceId\":\"/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a\",\"forceReOnboarding\":false,\"vNextEnabled\":false}"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-4,
  ]
}
resource "azurerm_virtual_machine_extension" "res-1" {
  auto_upgrade_minor_version = true
  name                       = "MDE.Windows"
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  settings                   = "{\"autoUpdate\":true,\"azureResourceId\":\"/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101b\",\"forceReOnboarding\":false,\"vNextEnabled\":false}"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101b"
  depends_on = [
    azurerm_windows_virtual_machine.res-6,
  ]
}
resource "azurerm_virtual_machine_extension" "res-2" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"69213211-d470-49eb-bbc8-ebd8bb5b60cc\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101b"
  depends_on = [
    azurerm_windows_virtual_machine.res-6,
  ]
}
resource "azurerm_resource_group" "res-3" {
  location = "australiaeast"
  name     = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}
resource "azurerm_windows_virtual_machine" "res-4" {
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
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-12,
  ]
}
resource "azurerm_virtual_machine_extension" "res-5" {
  auto_upgrade_minor_version = true
  name                       = "CustomScriptExtension"
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-4,
  ]
}
resource "azurerm_windows_virtual_machine" "res-6" {
  admin_password        = "ignored-as-imported"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "vm101b"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729"]
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
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-16,
  ]
}
resource "azurerm_virtual_machine_extension" "res-7" {
  auto_upgrade_minor_version = true
  name                       = "CustomScriptExtension"
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachines/vm101b"
  depends_on = [
    azurerm_windows_virtual_machine.res-6,
  ]
}
resource "azurerm_lb" "res-8" {
  location            = "australiaeast"
  name                = "mratestaesnetrglb"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  frontend_ip_configuration {
    name = "PublicIP"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-9" {
  loadbalancer_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb"
  name            = "LB_Pool"
  depends_on = [
    azurerm_lb.res-8,
  ]
}
resource "azurerm_lb_nat_rule" "res-10" {
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIP"
  frontend_port                  = 33891
  loadbalancer_id                = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb"
  name                           = "rdp101a"
  protocol                       = "Tcp"
  resource_group_name            = "mra-test-aes-net-rg"
  depends_on = [
    azurerm_lb.res-8,
  ]
}
resource "azurerm_lb_nat_rule" "res-11" {
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIP"
  frontend_port                  = 33892
  loadbalancer_id                = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb"
  name                           = "rdp101b"
  protocol                       = "Tcp"
  resource_group_name            = "mra-test-aes-net-rg"
  depends_on = [
    azurerm_lb.res-8,
  ]
}
resource "azurerm_network_interface" "res-12" {
  location            = "australiaeast"
  name                = "vm101a956"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_subnet.res-32,
  ]
}
resource "azurerm_network_interface_backend_address_pool_association" "res-13" {
  backend_address_pool_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb/backendAddressPools/LB_Pool"
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  depends_on = [
    azurerm_lb_backend_address_pool.res-9,
    azurerm_network_interface.res-12,
  ]
}
resource "azurerm_network_interface_nat_rule_association" "res-14" {
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb/inboundNatRules/rdp101a"
  network_interface_id  = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  depends_on = [
    azurerm_lb_nat_rule.res-10,
    azurerm_network_interface.res-12,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-15" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  depends_on = [
    azurerm_network_interface.res-12,
    azurerm_network_security_group.res-20,
  ]
}
resource "azurerm_network_interface" "res-16" {
  location            = "australiaeast"
  name                = "vm101b729"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_subnet.res-32,
  ]
}
resource "azurerm_network_interface_backend_address_pool_association" "res-17" {
  backend_address_pool_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb/backendAddressPools/LB_Pool"
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729"
  depends_on = [
    azurerm_lb_backend_address_pool.res-9,
    azurerm_network_interface.res-16,
  ]
}
resource "azurerm_network_interface_nat_rule_association" "res-18" {
  ip_configuration_name = "ipconfig1"
  nat_rule_id           = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/mratestaesnetrglb/inboundNatRules/rdp101b"
  network_interface_id  = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729"
  depends_on = [
    azurerm_lb_nat_rule.res-11,
    azurerm_network_interface.res-16,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-19" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg"
  depends_on = [
    azurerm_network_interface.res-16,
    azurerm_network_security_group.res-23,
  ]
}
resource "azurerm_network_security_group" "res-20" {
  location            = "australiaeast"
  name                = "vm101a-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_network_security_rule" "res-21" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "AllowAnyHTTPInbound"
  network_security_group_name = "vm101a-nsg"
  priority                    = 310
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-20,
  ]
}
resource "azurerm_network_security_rule" "res-22" {
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
    azurerm_network_security_group.res-20,
  ]
}
resource "azurerm_network_security_group" "res-23" {
  location            = "australiaeast"
  name                = "vm101b-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_network_security_rule" "res-24" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "HTTP"
  network_security_group_name = "vm101b-nsg"
  priority                    = 320
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-23,
  ]
}
resource "azurerm_network_security_rule" "res-25" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "HTTPS"
  network_security_group_name = "vm101b-nsg"
  priority                    = 340
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-23,
  ]
}
resource "azurerm_network_security_rule" "res-26" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "vm101b-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-23,
  ]
}
resource "azurerm_network_security_rule" "res-27" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "SSH"
  network_security_group_name = "vm101b-nsg"
  priority                    = 360
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-23,
  ]
}
resource "azurerm_public_ip" "res-28" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "lb_ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_public_ip" "res-29" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "vm101a-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_public_ip" "res-30" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "vm101b-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_virtual_network" "res-31" {
  address_space       = ["10.0.0.0/8"]
  location            = "australiaeast"
  name                = "mra-test-aes-net-vnet10.x"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_subnet" "res-32" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-31,
  ]
}
resource "azurerm_subnet" "res-33" {
  address_prefixes     = ["10.2.0.0/16"]
  name                 = "subnet10.2.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-31,
  ]
}
resource "azurerm_storage_account" "res-34" {
  account_replication_type         = "LRS"
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false
  location                         = "southeastasia"
  name                             = "mratestaesnetrgsa"
  resource_group_name              = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_storage_container" "res-36" {
  name                 = "scriptstorage"
  storage_account_name = "mratestaesnetrgsa"
}
