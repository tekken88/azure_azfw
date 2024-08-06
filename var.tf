#variables
variable "location" {
  description = "Location of the resources, example: eastus2"
  default     = "eastus2"
}

variable "resource_group_name" {
  description = "Name of the resource group to create"
  default     = "azfwtest"
}

variable "home_public_ip" {
  description = "Your home public ip address"
}

variable "username" {
  description = "Username for Virtual Machines"
  default     = "azureuser"
}

variable "password" {
  description = "Password for Virtual Machines"
  default     = "P@SSWORD123!"
  sensitive   = true
}

variable "firewall_log" {
  description = ""
  default     = "firewall-east"
}

variable "workspace_log" {
  description = ""
  default     = "workspace-east"
}
