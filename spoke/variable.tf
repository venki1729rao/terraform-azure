variable "resourcegroup_name" {
    type = string
    description = "resource group name"
    default = "Spoke2-rg"
  
}

variable "location" {
    type = string
    description = "azure region"
    default = "westus2"  
}

variable "vnet_name" {
    type = string
    description = "virtual network name"
    default = "Spoke2-vnet"
}

variable "address_space" {
    type = list(string)
    description = "vnet cidr"
    default = ["10.1.0.0/16"]

}

variable "subnet_name" {
    type = string
    description = "subnet name"
    default = "subnet"
}

variable "subnet_count" {
  description = "Number of Subnets"
  default     = 2
  type        = string
}

variable "subnet_prefix" {
    type = list(string)
    description = "subnet cidr"
    default = ["10.1.1.0/24","10.1.2.0/24"]
}

variable "env" {
    type = string
    description = "environment"
    default = "dev"
}

variable "route_name" {
    type = string
    description = "route name"
    default = "internetroute"
}

variable "internet_address" {
    type = string
    description = "internet address"
    default = "0.0.0.0/0"
}

variable "firewall_ip" {
}

variable "hubvnetid" {
}

variable "hubvnetrg" {
}

variable "hubvnetname" {
}