################################################################################################################################
# Route Table Creation and Route Table Association
################################################################################################################################


resource "azurerm_route_table" "FTD_NIC2" {
  name                = "${var.prefix}-RT-Subnet2"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  route{
    name = "default_inside_route"
    address_prefix = "0.0.0.0/0"
    next_hop_type = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.nicinsideftd.private_ip_address
  }
}

resource "azurerm_route_table" "FTD_NIC3" {
  name                = "${var.prefix}-RT-Subnet3"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  route {
    address_prefix = var.subnet-inside
    name = "forward_to_inside"
    next_hop_type = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_network_interface.nicoutsideftd.private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "rt-associa-2" {
  subnet_id                 = azurerm_subnet.insidesubnet.id
  route_table_id            = azurerm_route_table.FTD_NIC2.id
}
resource "azurerm_subnet_route_table_association" "rt-associa-3" {
  subnet_id                 = azurerm_subnet.outsidesubnet.id
  route_table_id            = azurerm_route_table.FTD_NIC3.id
}
