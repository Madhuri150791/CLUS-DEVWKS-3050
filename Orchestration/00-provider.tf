#################################
# Cloud Provider details: Azure
#################################
terraform {

  required_providers {
    azurerm = {
      version = "~>2.53.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription
  tenant_id = var.tenant
  features {}
}