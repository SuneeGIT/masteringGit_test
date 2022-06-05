variable "base_name" {
  type = string
  description = "The storage accout base name"
  default = "sunithateststoragetest"
}
variable "keyvault_name" {
  type = string
  description = "The key vault name"
  default = "sunithatestkeyvault"
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
