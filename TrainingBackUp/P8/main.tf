resource "azurerm_virtual_machine_extension" "res-0" {
  auto_upgrade_minor_version = true
  name                       = "MDE.Windows"
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  settings                   = "{\"autoUpdate\":true,\"azureResourceId\":\"/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a\",\"forceReOnboarding\":false,\"vNextEnabled\":false}"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-7,
  ]
}
resource "azurerm_virtual_machine_extension" "res-1" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"69213211-d470-49eb-bbc8-ebd8bb5b60cc\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-7,
  ]
}
resource "azurerm_virtual_machine_extension" "res-2" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"69213211-d470-49eb-bbc8-ebd8bb5b60cc\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vmss_f8864b6b"
  depends_on = [
    azurerm_windows_virtual_machine.res-8,
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
resource "azurerm_orchestrated_virtual_machine_scale_set" "res-4" {
  location                    = "australiaeast"
  name                        = "vmss"
  platform_fault_domain_count = 1
  resource_group_name         = "mra-test-aes-net-rg"
  sku_name                    = "Standard_B2s"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  additional_capabilities {
  }
  boot_diagnostics {
  }
  network_interface {
    name                      = "mra-test-aes-net-vnet10.x-nic01"
    network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/basicNsgmra-test-aes-net-vnet10.x-nic01"
    primary                   = true
    ip_configuration {
      load_balancer_backend_address_pool_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/vmss-lb/backendAddressPools/bepool"]
      name                                   = "mra-test-aes-net-vnet10.x-nic01-defaultIpConfiguration"
      primary                                = true
      subnet_id                              = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
      public_ip_address {
        name = "publicIp-mra-test-aes-net-vnet10.x-nic01"
      }
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  os_profile {
    windows_configuration {
      admin_password = "Welcome321!321!"
      admin_username = "ryan"
    }
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2019-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_lb_backend_address_pool.res-11,
    azurerm_network_security_group.res-18,
    azurerm_subnet.res-27,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-5" {
  name                         = "CustomScriptExtension"
  publisher                    = "Microsoft.Compute"
  type                         = "CustomScriptExtension"
  type_handler_version         = "1.9"
  virtual_machine_scale_set_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachineScaleSets/vmss"
  depends_on = [
    azurerm_orchestrated_virtual_machine_scale_set.res-4,
  ]
}
resource "azurerm_windows_virtual_machine" "res-7" {
  admin_password        = "Welcome321!321!"
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
    azurerm_network_interface.res-16,
  ]
}
resource "azurerm_windows_virtual_machine" "res-8" {
  admin_password        = "Welcome321!321!"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "vmss_f8864b6b"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/mra-test-aes-net-vnet10.x-nic01-b41f6c8d"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  virtual_machine_scale_set_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachineScaleSets/vmss"
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
    azurerm_orchestrated_virtual_machine_scale_set.res-4,
    azurerm_network_interface.res-13,
  ]
}
resource "azurerm_monitor_autoscale_setting" "res-9" {
  location            = "australiaeast"
  name                = "vmssautoscale"
  resource_group_name = "mra-test-aes-net-rg"
  target_resource_id  = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachineScaleSets/vmss"
  profile {
    name = "Default condition"
    capacity {
      default = 2
      maximum = 10
      minimum = 1
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachineScaleSets/vmss"
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 80
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT10M"
      }
      scale_action {
        cooldown  = "PT5M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachineScaleSets/vmss"
        operator           = "LessThan"
        statistic          = "Average"
        threshold          = 40
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT10M"
      }
      scale_action {
        cooldown  = "PT5M"
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 1
      }
    }
  }
  depends_on = [
    azurerm_orchestrated_virtual_machine_scale_set.res-4,
  ]
}
resource "azurerm_lb" "res-10" {
  location            = "australiaeast"
  name                = "vmss-lb"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  frontend_ip_configuration {
    name = "vmss-lb-frontendconfig01"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-11" {
  loadbalancer_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/vmss-lb"
  name            = "bepool"
  depends_on = [
    azurerm_lb.res-10,
  ]
}
resource "azurerm_lb_nat_rule" "res-12" {
  backend_address_pool_id        = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/vmss-lb/backendAddressPools/bepool"
  backend_port                   = 3389
  frontend_ip_configuration_name = "vmss-lb-frontendconfig01"
  frontend_port_end              = 53599
  frontend_port_start            = 50000
  loadbalancer_id                = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/vmss-lb"
  name                           = "vmss-lb-natRule01"
  protocol                       = "Tcp"
  resource_group_name            = "mra-test-aes-net-rg"
  depends_on = [
    azurerm_lb_backend_address_pool.res-11,
  ]
}
resource "azurerm_network_interface" "res-13" {
  location            = "australiaeast"
  name                = "mra-test-aes-net-vnet10.x-nic01-b41f6c8d"
  resource_group_name = "mra-test-aes-net-rg"
  ip_configuration {
    name                          = "mra-test-aes-net-vnet10.x-nic01-defaultIpConfiguration"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/publicIp-mra-test-aes-net-vnet10.x-nic01-b41f6c8d"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  }
  depends_on = [
    azurerm_public_ip.res-23,
    azurerm_subnet.res-27,
  ]
}
resource "azurerm_network_interface_backend_address_pool_association" "res-14" {
  backend_address_pool_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/loadBalancers/vmss-lb/backendAddressPools/bepool"
  ip_configuration_name   = "mra-test-aes-net-vnet10.x-nic01-defaultIpConfiguration"
  network_interface_id    = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/mra-test-aes-net-vnet10.x-nic01-b41f6c8d"
  depends_on = [
    azurerm_lb_backend_address_pool.res-11,
    azurerm_network_interface.res-13,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-15" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/mra-test-aes-net-vnet10.x-nic01-b41f6c8d"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/basicNsgmra-test-aes-net-vnet10.x-nic01"
  depends_on = [
    azurerm_network_interface.res-13,
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_interface" "res-16" {
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
    azurerm_public_ip.res-24,
    azurerm_subnet.res-27,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-17" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  depends_on = [
    azurerm_network_interface.res-16,
    azurerm_network_security_group.res-21,
  ]
}
resource "azurerm_network_security_group" "res-18" {
  location            = "australiaeast"
  name                = "basicNsgmra-test-aes-net-vnet10.x-nic01"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_network_security_rule" "res-19" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "AllowAnyRDPInbound"
  network_security_group_name = "basicNsgmra-test-aes-net-vnet10.x-nic01"
  priority                    = 310
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_security_rule" "res-20" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "Tcp"
  network_security_group_name = "basicNsgmra-test-aes-net-vnet10.x-nic01"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_security_group" "res-21" {
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
    azurerm_network_security_group.res-21,
  ]
}
resource "azurerm_public_ip" "res-23" {
  allocation_method       = "Static"
  idle_timeout_in_minutes = 15
  location                = "australiaeast"
  name                    = "publicIp-mra-test-aes-net-vnet10.x-nic01-b41f6c8d"
  resource_group_name     = "mra-test-aes-net-rg"
  sku                     = "Standard"
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_public_ip" "res-24" {
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
resource "azurerm_public_ip" "res-25" {
  allocation_method       = "Static"
  idle_timeout_in_minutes = 15
  location                = "australiaeast"
  name                    = "vmss-lb-publicip"
  resource_group_name     = "mra-test-aes-net-rg"
  sku                     = "Standard"
  depends_on = [
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_virtual_network" "res-26" {
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
resource "azurerm_subnet" "res-27" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-26,
  ]
}
resource "azurerm_subnet" "res-28" {
  address_prefixes     = ["10.2.0.0/16"]
  name                 = "subnet10.2.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-26,
  ]
}
resource "azurerm_storage_account" "res-29" {
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
    azurerm_resource_group.res-3,
  ]
}
resource "azurerm_storage_container" "res-31" {
  name                 = "script"
  storage_account_name = "mratestaesnetrgsa"
}
