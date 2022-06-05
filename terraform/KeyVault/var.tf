variable "keyvault_name" {
  type = string
  description = "The key vault name"
  default = "keyvaultsunitha"
}
variable "IP_Rules" {
  type = List
  description = "allow IP addresses you want to have the access to KeyVault"
}
variable "key_name" {
  type = string
  description = "Name of the Key"
}
variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
  default = "RG_AZR_SUNITHA"
}

variable "location" {
  type = string
  description = "The location for the deployment"
  default = "East US"
}
