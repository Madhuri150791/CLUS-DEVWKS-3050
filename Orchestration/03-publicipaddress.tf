# This template will be used to create the Public IP address  in default Azure Subscription

#########################################
#      Public IP Address
#########################################
//resource   "azurerm_public_ip"   "fmcpubip"   {
//  name   =   "fmc-pip-${var.prefix}"
//  location   =   var.resource_group_location
//  resource_group_name   =   azurerm_resource_group.rg.name
//  allocation_method   =   "Dynamic"
//  sku   =   "Basic"
//}
resource   "azurerm_public_ip"   "jumphost"   {
  name   =   "jumphost-pip-${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name
  allocation_method   =   "Dynamic"
  sku   =   "Basic"
}

//output "fmcpublicip" {
//  value = azurerm_public_ip.fmcpubip.public_ip
//}
output "jumphostpubip" {
  value = azurerm_public_ip.jumphost.ip_address
}