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

module "spoke" {
    source = "../spoke"
	firewall_ip  = module.hub.firewall_ip
	hubvnetid	 = module.hub.hubvnetid
	hubvnetrg	 = module.hub.hubvnetrg
	hubvnetname	 = module.hub.hubvnetname
}	

