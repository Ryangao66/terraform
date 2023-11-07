import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a/extensions/MDE.Windows"
  to = azurerm_virtual_machine_extension.res-0
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/MRA-TEST-AES-NET-RG/providers/Microsoft.Compute/virtualMachines/vm101a/extensions/MicrosoftMonitoringAgent"
  to = azurerm_virtual_machine_extension.res-1
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg"
  to = azurerm_resource_group.res-2
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachines/vm101a"
  to = azurerm_windows_virtual_machine.res-3
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Compute/virtualMachines/vm101b"
  to = azurerm_windows_virtual_machine.res-4
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956"
  to = azurerm_network_interface.res-5
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101a956|/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  to = azurerm_network_interface_security_group_association.res-6
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729"
  to = azurerm_network_interface.res-7
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkInterfaces/vm101b729|/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg"
  to = azurerm_network_interface_security_group_association.res-8
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg"
  to = azurerm_network_security_group.res-9
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101a-nsg/securityRules/RDP"
  to = azurerm_network_security_rule.res-10
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg"
  to = azurerm_network_security_group.res-11
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg/securityRules/HTTP"
  to = azurerm_network_security_rule.res-12
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg/securityRules/HTTPS"
  to = azurerm_network_security_rule.res-13
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg/securityRules/RDP"
  to = azurerm_network_security_rule.res-14
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/networkSecurityGroups/vm101b-nsg/securityRules/SSH"
  to = azurerm_network_security_rule.res-15
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/vm101a-ip"
  to = azurerm_public_ip.res-16
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/publicIPAddresses/vm101b-ip"
  to = azurerm_public_ip.res-17
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x"
  to = azurerm_virtual_network.res-18
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.1.x"
  to = azurerm_subnet.res-19
}
import {
  id = "/subscriptions/b860b083-169c-4f62-8ba6-e2f75885d4fa/resourceGroups/mra-test-aes-net-rg/providers/Microsoft.Network/virtualNetworks/mra-test-aes-net-vnet10.x/subnets/subnet10.2.x"
  to = azurerm_subnet.res-20
}
