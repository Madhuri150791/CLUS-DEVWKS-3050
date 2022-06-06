#########################################
#      Inside Host
#########################################

resource   "azurerm_linux_virtual_machine"   "insidehost"   {
  name                    =   "insidehost"
  location                =   var.resource_group_location
  resource_group_name     =   azurerm_resource_group.rg.name
  network_interface_ids   =   [ azurerm_network_interface.nicinsidehost.id]
  size                    =   var.vmmachinetype
  admin_username          =   "adminuser"
  admin_password          =   "Password123!"
  computer_name           =    "insidehost"
  disable_password_authentication = false
  source_image_reference   {
    publisher   =   var.publishervm
    offer       =   var.offertestvm
    sku         =   var.skutestvm
    version     =   var.versiontestvm
  }

 os_disk  {
    name = "disk-inside-${var.prefix}"
    caching             =   "ReadWrite"
    storage_account_type   =   "Standard_LRS"

  }


}

#########################################
#      Jumphost Host
#########################################

resource   "azurerm_linux_virtual_machine"   "jumphost"   {
  name                    =   "jumphost"
  location                =   var.resource_group_location
  resource_group_name     =   azurerm_resource_group.rg.name
  network_interface_ids   =   [ azurerm_network_interface.nicmgmtjumphost.id]
  size                    =   var.vmmachinetype
  admin_username          =   "adminuser"
  admin_password          =   "Password123!"
  computer_name           =    "jumphost"
  disable_password_authentication = false
  source_image_reference   {
    publisher   =   var.publishervm
    offer       =   var.offertestvm
    sku         =   var.skutestvm
    version     =   var.versiontestvm
  }


  os_disk   {
    name = "disk-jumphost-${var.prefix}"
    caching             =   "ReadWrite"
    storage_account_type   =   "Standard_LRS"

  }


}