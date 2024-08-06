#NSG's
resource "azurerm_network_security_group" "hubvnetNSG" {
  location            = var.location
  name                = "AZ-hub-vnet-default-nsg"
  resource_group_name = var.resource_group_name
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_network_security_rule" "hubvnetnsgrule1" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "AllowCidrBlockRDPInbound"
  network_security_group_name = "AZ-hub-vnet-default-nsg"
  priority                    = 2711
  protocol                    = "Tcp"
  resource_group_name         = azurerm_network_security_group.hubvnetNSG.resource_group_name
  source_address_prefix       = var.home_public_ip
  source_port_range           = "*"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}


resource "azurerm_network_security_group" "spokevnetNSG" {
  location            = var.location
  name                = "AZ-spoke-vnet-default-nsg"
  resource_group_name = var.resource_group_name
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_network_security_rule" "spokevnetnsgrule1" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "AllowCidrBlockRDPInbound"
  network_security_group_name = "AZ-spoke-vnet-default-nsg"
  priority                    = 2711
  protocol                    = "Tcp"
  resource_group_name         = azurerm_network_security_group.spokevnetNSG.resource_group_name
  source_address_prefix       = var.home_public_ip
  source_port_range           = "*"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
