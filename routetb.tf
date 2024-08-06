#route table
resource "azurerm_route_table" "RT" {
  name                          = "all-to-fw"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = false

  route {
    name                   = "inet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azfw.ip_configuration[0].private_ip_address
  }
  route {
    name                   = "tospoke"
    address_prefix         = "10.250.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azfw.ip_configuration[0].private_ip_address
  }
  route {
    name                   = "tohub"
    address_prefix         = "10.0.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azfw.ip_configuration[0].private_ip_address
  }
  route {
    name           = "tohome"
    address_prefix = "${var.home_public_ip}/32"
    next_hop_type  = "Internet"

  }

  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }
}

resource "azurerm_subnet_route_table_association" "onhubdefaultsubnet" {
  subnet_id      = azurerm_virtual_network.hub-vnet.subnet.*.id[0]
  route_table_id = azurerm_route_table.RT.id
  timeouts {
    create = "2h"
    read   = "2h"
    #update = "2h"
    delete = "2h"
  }
}
resource "azurerm_subnet_route_table_association" "onspokedefaultsubnet" {
  subnet_id      = azurerm_virtual_network.spoke-vnet.subnet.*.id[0]
  route_table_id = azurerm_route_table.RT.id
  timeouts {
    create = "2h"
    read   = "2h"
    #update = "2h"
    delete = "2h"
  }
}