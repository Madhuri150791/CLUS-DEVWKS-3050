#################################
#       Prefix
#################################
variable "resource_group_name_prefix" {
  default       = "rg"
  type = string
  description   = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
#################################
#       Prefix
#################################
variable "prefix" {
  type = string
  description   = "Prefix of the resources."
}
#################################
#       Location
#################################
variable "resource_group_location" {
  default       = "eastus"
  description   = "Location of the resource group."
}

#################################
#       VNET address
#################################
variable "vnet_address-space" {
  type      =  string
  description   = "Address SPace for the VNET"
}

#################################
#       Subnet Space
#################################
variable "subnet-mgmt" {
  type      =  string
  description   = "Subnet Variable"
}
variable "subnet-diag" {
  type      =  string
  description   = "Subnet Variable"
}
variable "subnet-inside" {
  type      =  string
  description   = "Subnet Variable"
}
variable "subnet-outside" {
  type      =  string
  description   = "Subnet Variable"
}
#################################
#       FMC Machine Type
#################################

variable "fmcmachinetype" {
  type      =  string
  description   = "Define FMC Machine Type"
}

#################################
#       FTD Machine Type
#################################

variable "ftdmachinetype" {
  type      =  string
  description   = "Define FMC Machine Type"
}

variable "vmmachinetype" {
  type      =  string
  description   = "Define FMC Machine Type"
}

#################################
#       Publisher
#################################
variable "publishercisco" {
  type = string
  default = "cisco"
  description = "This is to get the FMCv and FTD image"
}

variable "publishervm" {
  type = string
  description = "This is to get the Jumphost and test VM details"
}
#################################
#      Offer
#################################

variable "offerfmc" {
  type = string
  description = "For FMC"
}
variable "offerftd" {
  type = string
  description = "For FTD"
}
variable "offertestvm" {
  type = string
  description = "For Test VM"
}

#################################
#      SKU
#################################
variable "skufmc" {
  type = string
}
variable "skuftd" {
  type = string
}
variable "skutestvm" {
  type = string
}
#################################
#      Version
#################################
variable "versionfmc" {
  type = string
}
variable "versionftd" {
  type = string
}
variable "versiontestvm" {
  type = string
}





