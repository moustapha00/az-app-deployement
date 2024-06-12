resource "azurerm_key_vault" "keyvault" {
  name                = "keyv-formation-frct-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
  }
}

resource "azurerm_key_vault_secret" "cosmosdb_connection_string" {
  name         = "CosmosDBConnectionString"
  value        = azurerm_cosmosdb_account.cosmosdb.connection_strings[0]
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [azurerm_cosmosdb_account.cosmosdb]
}

resource "azurerm_key_vault_secret" "app_insights_connection_string" {
  name         = "AppInsightsConnectionString"
  value        = azurerm_application_insights.app_insights.connection_string
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [azurerm_application_insights.app_insights]
}