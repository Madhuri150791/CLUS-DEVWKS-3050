################################################################################################################################
# Route Table Creation and Route Table Association
################################################################################################################################


resource "azurerm_route_table" "FTD_NIC2" {
  name                = "${var.prefix}-RT-Subnet2"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_route_table" "FTD_NIC3" {
  name                = "${var.prefix}-RT-Subnet3"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_route_table_association" "rt-associa-2" {
  subnet_id                 = azurerm_subnet.insidesubnet.id
  route_table_id            = azurerm_route_table.FTD_NIC2.id
}
resource "azurerm_subnet_route_table_association" "rt-associa-3" {
  subnet_id                 = azurerm_subnet.outsidesubnet.id
  route_table_id            = azurerm_route_table.FTD_NIC3.id
}
