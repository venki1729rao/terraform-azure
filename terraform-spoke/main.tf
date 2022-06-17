provider "azurerm" {
  features {}
}

terraform {
   backend "azurerm" {
         resource_group_name = "storage-rg"
		 storage_account_name = "remtfstate"
		 container_name = "tfstatefiles"
		 key = "npterraform.tfstate"
  }
}
 
module "hub" {
    source = "../hub"
}

/*
data "azurerm_firewall" "Hub" {
  name                = "Hub-vnet-firewall"
  resource_group_name = "HUB-resource-group"
}

data "azurerm_virtual_network" "Hub" {
  name                = "HUB-vnet"
  resource_group_name = "HUB-resource-group"
}*/

resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroup_name
  location = var.location
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  tags = {
    environment = var.env
  }

}

resource "azurerm_subnet" "subnet" {
    count                = var.subnet_count
    name                 = "${var.subnet_name}-${count.index}"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.spoke_vnet.name
    address_prefixes     = ["10.1.${1+count.index}.0/24"]
}

resource "azurerm_route_table" "internet_route" {
  name                          = var.route_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name           = var.route_name
    address_prefix = var.internet_address
    next_hop_type  = "VirtualAppliance"
	next_hop_in_ip_address = module.hub.firewall_ip
  }

  tags = {
    environment = "POC"
  }
}

resource "azurerm_subnet_route_table_association" "subnet" {
  count          = var.subnet_count
  subnet_id      = azurerm_subnet.subnet[count.index].id
  route_table_id = azurerm_route_table.internet_route.id
}

resource "azurerm_virtual_network_peering" "spoketohub" {
  name                      = "spoketohub"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet.name
  remote_virtual_network_id = module.hub.hubvnetid
}

resource "azurerm_virtual_network_peering" "hubtospoke" {
  name                      = "hubtospoke"
  resource_group_name       = module.hub.hubvnetrg
  virtual_network_name      = module.hub.hubvnetname
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet.id
}
