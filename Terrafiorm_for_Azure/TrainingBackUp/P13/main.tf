resource "azurerm_resource_group" "res-0" {
  location = "australiaeast"
  name     = "mra-test-aes-net-rg"
  tags = {
    owner = "ryan"
    usage = "TerraformTesting"
  }
}
resource "azurerm_windows_virtual_machine" "res-1" {
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
    sku       = "2022-datacenter-smalldisk-g2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-4,
  ]
}
resource "azurerm_virtual_machine_extension" "res-2" {
  auto_upgrade_minor_version = true
  name                       = "CustomScriptExtension"
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.9"
  virtual_machine_id         = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachines/vm101a"
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}
resource "azurerm_application_gateway" "res-3" {
  location            = "australiaeast"
  name                = "webgw"
  resource_group_name = "mra-test-aes-net-rg"
  tags = {
    usage = "TerraformTesting"
  }
  autoscale_configuration {
    max_capacity = 10
    min_capacity = 1
  }
  backend_address_pool {
    fqdns = ["www.cathead.top"]
    name  = "webbackendpool"
  }
  backend_http_settings {
    cookie_based_affinity = "Disabled"
    name                  = "web-pool-setting"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  frontend_ip_configuration {
    name                 = "appGwPublicFrontendIpIPv4"
    public_ip_address_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/webgw"
  }
  frontend_port {
    name = "port_80"
    port = 80
  }
  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/ag-subnet"
  }
  http_listener {
    frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
    frontend_port_name             = "port_80"
    name                           = "web-listener"
    protocol                       = "Http"
  }
  request_routing_rule {
    backend_address_pool_name  = "webbackendpool"
    backend_http_settings_name = "web-pool-setting"
    http_listener_name         = "web-listener"
    name                       = "we-rule"
    priority                   = 200
    rule_type                  = "Basic"
  }
  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }
  depends_on = [
    azurerm_public_ip.res-10,
    azurerm_subnet.res-12,
  ]
}
resource "azurerm_network_interface" "res-4" {
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
    azurerm_subnet.res-13,
  ]
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "res-5" {
  backend_address_pool_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/applicationGateways/webgw/backendAddressPools/webbackendpool"
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  depends_on = [
    azurerm_network_interface.res-4,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-6" {
  network_interface_id      = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  network_security_group_id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  depends_on = [
    azurerm_network_interface.res-4,
    azurerm_network_security_group.res-7,
  ]
}
resource "azurerm_network_security_group" "res-7" {
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
resource "azurerm_network_security_rule" "res-8" {
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
    azurerm_network_security_group.res-7,
  ]
}
resource "azurerm_public_ip" "res-9" {
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
resource "azurerm_public_ip" "res-10" {
  allocation_method   = "Static"
  location            = "australiaeast"
  name                = "webgw"
  resource_group_name = "mra-test-aes-net-rg"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-11" {
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
resource "azurerm_subnet" "res-12" {
  address_prefixes     = ["10.0.4.0/28"]
  name                 = "ag-subnet"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-11,
  ]
}
resource "azurerm_subnet" "res-13" {
  address_prefixes     = ["10.1.0.0/16"]
  name                 = "subnet10.1.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-11,
  ]
}
resource "azurerm_subnet" "res-14" {
  address_prefixes     = ["10.2.0.0/16"]
  name                 = "subnet10.2.x"
  resource_group_name  = "mra-test-aes-net-rg"
  virtual_network_name = "mra-test-aes-net-vnet10.x"
  depends_on = [
    azurerm_virtual_network.res-11,
  ]
}
resource "azurerm_storage_account" "res-15" {
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
resource "azurerm_storage_container" "res-17" {
  name                 = "script"
  storage_account_name = "mratestaesnetrgsa"
}
