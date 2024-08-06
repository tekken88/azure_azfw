#vnets and subnets
resource "azurerm_virtual_network" "hub-vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = "AZ-hub-vnet"
  resource_group_name = var.resource_group_name
  subnet {
    address_prefix = "10.0.0.0/24"
    name           = "default"
    security_group = azurerm_network_security_group.hubvnetNSG.id
  }
  subnet {
    address_prefix = "10.0.1.0/24"
    name           = "GatewaySubnet"
  }
  subnet {
    address_prefix = "10.0.2.0/24"
    name           = "AzureFirewallSubnet"
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}


resource "azurerm_virtual_network" "spoke-vnet" {
  address_space       = ["10.250.0.0/16"]
  location            = var.location
  name                = "AZ-spoke-vnet"
  resource_group_name = var.resource_group_name
  subnet {
    address_prefix = "10.250.0.0/24"
    name           = "default"
    security_group = azurerm_network_security_group.spokevnetNSG.id
  }
  subnet {
    address_prefix = "10.250.1.0/24"
    name           = "GatewaySubnet"
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}

resource "azurerm_virtual_network_peering" "hubtospokepeering" {
  name                      = "hub-to-spoke-peering"
  remote_virtual_network_id = azurerm_virtual_network.spoke-vnet.id
  resource_group_name       = var.resource_group_name
  virtual_network_name      = "AZ-hub-vnet"
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }
  depends_on = [
    azurerm_virtual_network.hub-vnet,
    azurerm_virtual_network.spoke-vnet,

  ]
}
resource "azurerm_virtual_network_peering" "spoketohubpeering" {
  name                      = "spoke-to-hub-peering"
  remote_virtual_network_id = azurerm_virtual_network.hub-vnet.id
  resource_group_name       = var.resource_group_name
  virtual_network_name      = "AZ-spoke-vnet"
  allow_forwarded_traffic   = true
  #use_remote_gateways = true
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }
  depends_on = [
    azurerm_virtual_network.spoke-vnet,
    azurerm_virtual_network.hub-vnet,

  ]
}










