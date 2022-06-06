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
  features {}
}