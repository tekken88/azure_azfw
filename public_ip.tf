#Public IP's
resource "azurerm_public_ip" "azurevpngw-pip" {
  name                = "azurevpngw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}

resource "azurerm_public_ip" "azfw-pip" {
  name                = "azfw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_public_ip" "hubvm-pip" {
  name                = "hubvm-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_public_ip" "spokevm-pip" {
  name                = "spokevm-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}