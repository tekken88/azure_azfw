#log analytics workspace
resource "azurerm_log_analytics_workspace" "LAW" {
  name                = var.workspace_log
  location            = var.location
  resource_group_name = var.resource_group_name

}