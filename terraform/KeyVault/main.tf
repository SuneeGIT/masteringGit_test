provider "azurerm" {
  features{}
}

data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  network_acls {
                  default_action = "Deny"
                   bypass = "AzureServices" 
                   ip_rules = var.IP_Rules
                }
  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "kvpolicy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  key_permissions    = ["Backup","Create","Decrypt","Delete","Encrypt","Get","Import","List","Purge","Recover","Restore","Sign","UnwrapKey","Update","Verify","WrapKey"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "sakey" {
  name         = var.key_name
  key_vault_id = azurerm_key_vault.keyvault.id
  #checkov:skip=CKV_AZURE_112:suppressed intentionally
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  expiration_date = "2023-12-30T20:00:00Z"

  depends_on = [
    azurerm_key_vault_access_policy.kvpolicy
  ]
}