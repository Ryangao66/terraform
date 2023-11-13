resource "azurerm_virtual_machine_extension" "res-0" {
  auto_upgrade_minor_version = true
  name                       = "MDE.Windows"
  publisher                  = "Microsoft.Azure.AzureDefenderForServers"
  settings                   = "{\"autoUpdate\":true,\"azureResourceId\":\"/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a\",\"forceReOnboarding\":false,\"vNextEnabled\":false}"
  type                       = "MDE.Windows"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a"
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
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-3,
  ]
}
resource "azurerm_resource_group" "res-2" {
  location = "australiaeast"
  name     = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}
resource "azurerm_windows_virtual_machine" "res-3" {
  admin_password        = "ignored-as-imported"
  admin_username        = "ryan"
  location              = "australiaeast"
  name                  = "vm101a"
  network_interface_ids = ["/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a276"]
  resource_group_name   = "mra-test-aes-net-rg"
  size                  = "Standard_B2s"
  tags = {
    Owner = "ryan"
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
    azurerm_network_interface.res-9,
  ]
}
resource "azurerm_firewall" "res-4" {
  firewall_policy_id  = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/firewallPolicies/fw-policy"
  location            = "australiaeast"
  name                = "fw-01"
  resource_group_name = "mra-test-aes-net-rg"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"
  tags = {
    usage = "TerraformTesting"
  }
  ip_configuration {
    name                 = "fw-ip-01"
    public_ip_address_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/fw-ip-01"
    subnet_id            = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/AzureFirewallSubnet"
  }
  management_ip_configuration {
    name                 = "fw-mgmt-ip-01"
    public_ip_address_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/fw-mgmt-ip-01"
    subnet_id            = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/AzureFirewallManagementSubnet"
  }
  depends_on = [
    azurerm_firewall_policy.res-6,
    azurerm_public_ip.res-14,
    azurerm_public_ip.res-15,
    azurerm_subnet.res-24,
    # One of azurerm_subnet.res-22,azurerm_subnet_route_table_association.res-23 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_bastion_host" "res-5" {
  location            = "australiaeast"
  name                = "vnet10.0-bastion"
  resource_group_name = "mra-test-aes-net-rg"
  ip_configuration {
    name                 = "IpConf"
    public_ip_address_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/vnet10.0-ip"
    subnet_id            = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/AzureBastionSubnet"
  }
  depends_on = [
    azurerm_public_ip.res-17,
    azurerm_subnet.res-21,
  ]
}
resource "azurerm_firewall_policy" "res-6" {
  location            = "australiaeast"
  name                = "fw-policy"
  resource_group_name = "mra-test-aes-net-rg"
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_firewall_policy_rule_collection_group" "res-7" {
  firewall_policy_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/firewallPolicies/fw-policy"
  name               = "DefaultApplicationRuleCollectionGroup"
  priority           = 300
  application_rule_collection {
    action   = "Allow"
    name     = "allow-app"
    priority = 200
    rule {
      destination_fqdns = ["*.google.com"]
      name              = "allow-google"
      source_addresses  = ["10.1.0.0/16"]
      protocols {
        port = 443
        type = "Https"
      }
    }
  }
  application_rule_collection {
    action   = "Allow"
    name     = "allow-youtube"
    priority = 210
    rule {
      destination_fqdns = ["www.youtube.com"]
      name              = "allow-youtube"
      source_addresses  = ["10.1.0.0/16"]
      protocols {
        port = 443
        type = "Https"
      }
    }
  }
  depends_on = [
    azurerm_firewall_policy.res-6,
  ]
}
resource "azurerm_firewall_policy_rule_collection_group" "res-8" {
  firewall_policy_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/firewallPolicies/fw-policy"
  name               = "DefaultNetworkRuleCollectionGroup"
  priority           = 200
  network_rule_collection {
    action   = "Allow"
    name     = "allowdns"
    priority = 200
    rule {
      destination_addresses = ["8.8.8.8"]
      destination_ports     = ["53"]
      name                  = "allowdns"
      protocols             = ["Any"]
      source_addresses      = ["10.1.0.0/16"]
    }
  }
  depends_on = [
    azurerm_firewall_policy.res-6,
  ]
}
resource "azurerm_network_interface" "res-9" {
  location            = "australiaeast"
  name                = "vm101a276"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/subnet10.1"
  }
  depends_on = [
    # One of azurerm_subnet.res-25,azurerm_subnet_route_table_association.res-26 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_network_interface_security_group_association" "res-10" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a276"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  depends_on = [
    azurerm_network_interface.res-9,
    azurerm_network_security_group.res-11,
  ]
}
resource "azurerm_network_security_group" "res-11" {
  location            = "australiaeast"
  name                = "vm101a-nsg"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_network_security_rule" "res-12" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "HTTP"
  network_security_group_name = "vm101a-nsg"
  priority                    = 320
  protocol                    = "Tcp"
  resource_group_name         = "mra-test-aes-net-rg"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-11,
  ]
}
resource "azurerm_network_security_rule" "res-13" {
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
    azurerm_network_security_group.res-11,
  ]
}
resource "azurerm_public_ip" "res-14" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "fw-ip-01"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_public_ip" "res-15" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "fw-mgmt-ip-01"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_public_ip" "res-16" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "vm101a-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_public_ip" "res-17" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "vnet10.0-ip"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_route_table" "res-18" {
  location            = "australiaeast"
  name                = "rt-vnet10"
  resource_group_name = "mra-test-aes-net-rg"
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_route" "res-19" {
  address_prefix         = "0.0.0.0/0"
  name                   = "10.x_to_firewall"
  next_hop_in_ip_address = "10.0.2.4"
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = "mra-test-aes-net-rg"
  route_table_name       = "rt-vnet10"
  depends_on = [
    azurerm_route_table.res-18,
  ]
}
resource "azurerm_virtual_network" "res-20" {
  address_space       = ["10.0.0.0/8"]
  location            = "australiaeast"
  name                = "vnet10.0"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    Owner = "ryan"
    usage = "TerraformTesting"
  }
  depends_on = [
    azurerm_resource_group.res-2,
  ]
}
resource "azurerm_subnet" "res-21" {
  address_prefixes     = ["10.0.1.0/26"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "vnet10.0"
  depends_on = [
    azurerm_virtual_network.res-20,
  ]
}
resource "azurerm_subnet" "res-22" {
  address_prefixes     = ["10.0.3.0/26"]
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "vnet10.0"
  depends_on = [
    azurerm_virtual_network.res-20,
  ]
}
resource "azurerm_subnet_route_table_association" "res-23" {
  route_table_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/routeTables/377df306-8af2-41b5-bc0e-bb8f8dec5551"
  subnet_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/AzureFirewallManagementSubnet"
  depends_on = [
    azurerm_subnet.res-22,
  ]
}
resource "azurerm_subnet" "res-24" {
  address_prefixes     = ["10.0.2.0/26"]
  name                 = "AzureFirewallSubnet"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "vnet10.0"
  depends_on = [
    azurerm_virtual_network.res-20,
  ]
}
resource "azurerm_subnet" "res-25" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "vnet10.0"
  depends_on = [
    azurerm_virtual_network.res-20,
  ]
}
resource "azurerm_subnet_route_table_association" "res-26" {
  route_table_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/routeTables/rt-vnet10"
  subnet_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/vnet10.0/subnets/subnet10.1"
  depends_on = [
    azurerm_route_table.res-18,
    azurerm_subnet.res-25,
  ]
}
