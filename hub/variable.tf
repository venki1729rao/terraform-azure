variable "resourcegroup_name" {
    type = string
    description = "resource group name"
    default = "HUB-resource-group"
  
}

variable "location" {
    type = string
    description = "azure region"
    default = "westus2"  
}

variable "vnet_name" {
    type = string
    description = "virtual network name"
    default = "HUB-vnet"
}

variable "address_space" {
    type = list(string)
    description = "vnet cidr"
    default = ["10.0.0.0/16"]

}

variable "subnet_name" {
    type = string
    description = "subnet name"
    default = "AzureFirewallSubnet"

}

variable "subnet_prefix" {
    type = list(string)
    description = "subnet cidr"
    default = ["10.0.0.0/26"]
}

variable "env" {
    type = string
    description = "environment"
    default = "dev"
  
}

variable "firewall_ip" {
    type = string
    description = "firewall staic ip" 
    default = "firewallpip"

}

variable "hub_firewall" {
    type = string
    description = "firewall name"
    default = "Hub-vnet-firewall"
  
}

variable "sku_tier" {
    type = string
    description = "firewall sku standard or premium"
    default = "Premium"
}

variable "sku_name" {
    type = string
    description = "firewall sku name"
    default = "AZFW_VNet"
  
}