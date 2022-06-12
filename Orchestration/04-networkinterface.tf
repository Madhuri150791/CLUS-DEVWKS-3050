# This template will be used to create the network interfaces in default Azure Subscription

#########################################
#      Network Interfaces
#########################################
//resource   "azurerm_network_interface"   "nicmgmtfmc"   {
//  name   =   "nic-mgmt-fmc-${var.prefix}"
//  location   =   var.resource_group_location
//  resource_group_name   =   azurerm_resource_group.rg.name
//
//  ip_configuration   {
//    name   =   "ipconfig-mgmt-fmc-${var.prefix}"
//    subnet_id   =   azurerm_subnet.mgmtsubnet.id
//    private_ip_address_allocation   =   "Static"
//    private_ip_address = "10.121.10.4"
//    public_ip_address_id   =   azurerm_public_ip.fmcpubip.id
//}
//}

resource   "azurerm_network_interface"   "nicmgmtjumphost"   {
  name   =   "nic-mgmt-jumphost-${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-mgmt-jumphost-${var.prefix}"
    subnet_id   =   azurerm_subnet.mgmtsubnet.id
    private_ip_address_allocation   =   "Static"
    private_ip_address = "10.121.10.5"
    public_ip_address_id   =   azurerm_public_ip.jumphost.id
  }
}


resource   "azurerm_network_interface"   "nicmgmtftd"   {
  name   =   "nic-mgmt-ftd--${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-mgmt-ftd-${var.prefix}"
    subnet_id   =   azurerm_subnet.mgmtsubnet.id
    private_ip_address = "10.121.10.6"
    private_ip_address_allocation   =   "Static"

}
}

resource   "azurerm_network_interface"   "nicdiagftd"   {
  name   =   "nic-diag-ftd--${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-diag-ftd-${var.prefix}"
    subnet_id   =   azurerm_subnet.diagsubnet.id
    private_ip_address_allocation   =   "Dynamic"

  }
}

resource   "azurerm_network_interface"   "nicinsideftd"   {
  name   =   "nic-inside-ftd--${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-inside-ftd-${var.prefix}"
    subnet_id   =   azurerm_subnet.insidesubnet.id
    private_ip_address_allocation   =   "Dynamic"

  }
}

resource   "azurerm_network_interface"   "nicinsidehost"   {
  name   =   "nic-inside-host--${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-insidehost-${var.prefix}"
    subnet_id   =   azurerm_subnet.insidesubnet.id
    private_ip_address_allocation   =   "Dynamic"

  }
}


resource   "azurerm_network_interface"   "nicoutsideftd"   {
  name   =   "nic-outside-ftd--${var.prefix}"
  location   =   var.resource_group_location
  resource_group_name   =   azurerm_resource_group.rg.name

  ip_configuration   {
    name   =   "ipconfig-outside-ftd-${var.prefix}"
    subnet_id   =   azurerm_subnet.outsidesubnet.id
    private_ip_address_allocation   =   "Dynamic"

  }
}



resource "azurerm_network_interface_security_group_association" "FTDv_NIC0_NSG" {
  network_interface_id      = azurerm_network_interface.nicmgmtftd.id
  network_security_group_id = azurerm_network_security_group.allow-all.id
}
resource "azurerm_network_interface_security_group_association" "FTDv_NIC1_NSG" {
  network_interface_id      = azurerm_network_interface.nicdiagftd.id
  network_security_group_id = azurerm_network_security_group.allow-all.id
}
