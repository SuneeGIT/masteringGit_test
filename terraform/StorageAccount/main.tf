terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.2"
    }
  }
}

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "${lower(var.base_name)}${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  min_tls_version      = "TLS1_2"
  network_rules {
    default_action="Deny"
  }
  queue_properties  {
    logging {
      delete = true
      read = true
      write = true 
      version = "1.0"
      retention_policy_days = 10 
      }
      hour_metrics { 
        enabled = true 
        include_apis = true
        version = "1.0" 
        retention_policy_days = 10
         }
         minute_metrics {
           enabled = true 
           include_apis = true
           version = "1.0"
           retention_policy_days = 10
           }
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_account_customer_managed_key" "ok_cmk" {
  storage_account_id = azurerm_storage_account.storageaccount.id
  key_vault_id       = azurerm_key_vault.storageaccount.id
  key_name           = azurerm_key_vault_key.storageaccount.name
}