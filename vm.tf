#vNIC's
resource "azurerm_network_interface" "hubvm-nic" {
  location            = var.location
  name                = "hubvm-nic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hubvm-pip.id
    subnet_id                     = azurerm_virtual_network.hub-vnet.subnet.*.id[0]
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_network_interface" "spokevm-nic" {
  location            = var.location
  name                = "spokevm-nic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.spokevm-pip.id
    subnet_id                     = azurerm_virtual_network.spoke-vnet.subnet.*.id[0]
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}


#VM's
resource "azurerm_windows_virtual_machine" "hubvm" {
  admin_password        = var.password
  admin_username        = var.username
  location              = var.location
  name                  = "hubvm"
  network_interface_ids = [azurerm_network_interface.hubvm-nic.id]
  resource_group_name   = var.resource_group_name
  size                  = "Standard_B2ms"
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}



resource "azurerm_windows_virtual_machine" "spokevm" {
  admin_password        = var.password
  admin_username        = var.username
  location              = var.location
  name                  = "spokevm"
  network_interface_ids = [azurerm_network_interface.spokevm-nic.id]
  resource_group_name   = var.resource_group_name
  size                  = "Standard_B2ms"
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
