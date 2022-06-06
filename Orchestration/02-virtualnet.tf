# This template will be used to create the VNET  in default Azure Subscription

#########################################
#       VNET and its Associated Subnets
#########################################

resource   "azurerm_virtual_network"   "vnet"   {
  name   =   "vnet-${var.prefix}"
  address_space   =   [ var.vnet_address-space ]
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name
}

resource   "azurerm_subnet"   "mgmtsubnet"   {
  name   =   "subnet-mgmt-${var.prefix}"
  resource_group_name   =    azurerm_resource_group.rg.name
  virtual_network_name   =   azurerm_virtual_network.vnet.name
  address_prefixes   =   [var.subnet-mgmt]
}
resource   "azurerm_subnet"   "diagsubnet"   {
  name   =   "subnet-diag-${var.prefix}"
  resource_group_name   =    azurerm_resource_group.rg.name
  virtual_network_name   =   azurerm_virtual_network.vnet.name
  address_prefixes   =   [var.subnet-diag]
}
resource   "azurerm_subnet"   "insidesubnet"   {
  name   =   "subnet-inside-${var.prefix}"
  resource_group_name   =    azurerm_resource_group.rg.name
  virtual_network_name   =   azurerm_virtual_network.vnet.name
  address_prefixes   =   [var.subnet-inside]
}
resource   "azurerm_subnet"   "outsidesubnet"   {
  name   =   "subnet-outside-${var.prefix}"
  resource_group_name   =    azurerm_resource_group.rg.name
  virtual_network_name   =   azurerm_virtual_network.vnet.name
  address_prefixes   =   [var.subnet-outside]
}