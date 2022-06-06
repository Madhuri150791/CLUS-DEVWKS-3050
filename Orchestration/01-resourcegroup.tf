# This template will be used to create the resource group in Azure Subscription

#################################
#       Resource Group
#################################

resource "azurerm_resource_group" "rg" {
  name      = "rg-${var.prefix}"
  location  = var.resource_group_location
}
