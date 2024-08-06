#Azfirewall and policy
resource "azurerm_firewall_policy" "azfwpolicy" {
  name                = "azfw-policy"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"

  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }
}
resource "azurerm_firewall_policy_rule_collection_group" "azfwpolicyrcg" {
  name               = "azfwpolicy-rcg"
  firewall_policy_id = azurerm_firewall_policy.azfwpolicy.id
  priority           = 500
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 400
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["*"]
    }
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}
resource "azurerm_firewall" "azfw" {
  name                = "AzureFirewall"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.azfwpolicy.id

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_virtual_network.hub-vnet.subnet.*.id[2]
    public_ip_address_id = azurerm_public_ip.azfw-pip.id
  }
  timeouts {
    create = "2h"
    read   = "2h"
    update = "2h"
    delete = "2h"
  }

}

#firewall logging
resource "azurerm_monitor_diagnostic_setting" "fwlogs" {
  name                           = var.firewall_log
  target_resource_id             = azurerm_firewall.azfw.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.LAW.id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "AZFWNetworkRule"
  }
  enabled_log {
    category = "AZFWApplicationRule"
  }
  enabled_log {
    category = "AZFWNatRule"
  }
  enabled_log {
    category = "AZFWThreatIntel"
  }
  enabled_log {
    category = "AZFWIdpsSignature"
  }
  enabled_log {
    category = "AZFWDnsQuery"
  }
  enabled_log {
    category = "AZFWFqdnResolveFailure"
  }
  enabled_log {
    category = "AZFWFatFlow"
  }
  enabled_log {
    category = "AZFWFlowTrace"
  }
}
