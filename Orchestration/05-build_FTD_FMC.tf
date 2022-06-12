# This template will be used to create theFMC and FTD  in default Azure Subscription

#########################################
#      FMC
#########################################
//data "template_file" "fmcday0file" {
//  template = file("fmc-day0.txt")
//
//}
//
//resource   "azurerm_linux_virtual_machine"   "fmc"   {
//  name                    =   "fmc-${var.prefix}"
//  location                =   var.resource_group_location
//  resource_group_name     =   azurerm_resource_group.rg.name
//  network_interface_ids   =   [ azurerm_network_interface.nicmgmtfmc.id ]
//  size                    =   var.fmcmachinetype
//  admin_username          =   "adminuser"
//  computer_name           =    "vm-fmc"
//  disable_password_authentication = false
//  admin_password = "Admin123"
//
//  custom_data = base64encode(data.template_file.fmcday0file.rendered)
//  source_image_reference  {
//    publisher   =   var.publishercisco
//    offer       =   var.offerfmc
//    sku         =   var.skufmc
//    version     =   var.versionfmc
//  }
//  admin_ssh_key {
//    username = "adminuser"
//    public_key = tls_private_key.common.public_key_openssh #The magic here
//  }
//
//  plan {
//    name = var.skufmc
//    product = var.offerfmc
//    publisher = var.publishercisco
//  }
//
//
//  os_disk   {
//    name = "disk-fmc-${var.prefix}"
//    caching             =   "ReadWrite"
//    storage_account_type = "Standard_LRS"
//  }
//
//
//}

#########################################
#      FTD
#########################################




data "template_file" "ftdday0file" {
  template = file("ftd-day0.txt")

}

resource   "azurerm_linux_virtual_machine"   "ftd"   {
  name                    =   "ftd-${var.prefix}"
  location                =   var.resource_group_location
  resource_group_name     =   azurerm_resource_group.rg.name
  network_interface_ids   =   [ azurerm_network_interface.nicmgmtftd.id, azurerm_network_interface.nicdiagftd.id,azurerm_network_interface.nicinsideftd.id, azurerm_network_interface.nicoutsideftd.id ]
  size                    =   var.ftdmachinetype
  computer_name           =    "vm-ftd"
  admin_username          =   "adminuser"
  disable_password_authentication = false
  admin_password = "Admin123"


  source_image_reference {
    publisher   =   var.publishercisco
    offer       =   var.offerftd
    sku         =   var.skuftd
    version     =   var.versionftd
  }

  custom_data = base64encode(data.template_file.ftdday0file.rendered)


  admin_ssh_key {
    username = "adminuser"
    public_key = tls_private_key.common.public_key_openssh #The magic here
  }
  plan {
    name = var.skuftd
    product = var.offerftd
    publisher = var.publishercisco
  }
//  depends_on = [azurerm_linux_virtual_machine.fmc]

os_disk   {
    name = "disk-ftd-${var.prefix}"
    caching             =   "ReadWrite"
    storage_account_type   =   "Standard_LRS"

  }

}
