output "firewall_ip" {
        value = azurerm_firewall.Hub_firewall.ip_configuration.0.private_ip_address
}		
output "hubvnetid" {		
		value = azurerm_virtual_network.hub_vnet.id
}
output "hubvnetrg" {		
		value = azurerm_virtual_network.hub_vnet.resource_group_name
}
output "hubvnetname" {		
		value = azurerm_virtual_network.hub_vnet.name
}		