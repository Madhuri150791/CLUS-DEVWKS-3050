################################################################################################################################
# VN Peering to allow FMC Vnet to communicate to FTD VNET
################################################################################################################################

locals {
  src_net_id = "9a4f16e4-cacb-4ab9-a1f6-533c849478ea"
  resource_group_name = "clus-fmc"
  src_net_name = "vnet01"
}
data "azurerm_resources" "spokes" {
  type = "Microsoft.Network/virtualNetworks"

}

resource "azurerm_virtual_network_peering" "peer_fmc_to_vnet" {
  name                         = "peer-vnet-a-with-b"
  resource_group_name          = local.resource_group_name
  virtual_network_name         = local.src_net_name
  remote_virtual_network_id    = azurerm_virtual_network.vnet.id
  allow_virtual_network_access = true
}
# Azure Virtual Network peering between Virtual Network B and A
resource "azurerm_virtual_network_peering" "peer_vnet_to_fmc" {
  count = length(data.azurerm_resources.spokes.resources)
  name                         = "peer-vnet-b-with-a"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = data.azurerm_resources.spokes.resources[0].id
  allow_virtual_network_access = true
  depends_on = [azurerm_virtual_network_peering.peer_fmc_to_vnet]
}