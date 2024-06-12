resource "azurerm_role_assignment" "nodejs_keyvault_access" {
  principal_id         = azurerm_user_assigned_identity.nodejs_app_identity.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.keyvault.id
}

resource "azurerm_role_assignment" "nodejs_cosmosdb_access" {
  principal_id         = azurerm_user_assigned_identity.nodejs_app_identity.principal_id
  role_definition_name = "Cosmos DB Account Reader Role"
  scope                = azurerm_cosmosdb_account.cosmosdb.id
}


resource "azurerm_role_assignment" "nodejs_acr_access" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.nodejs_app_identity.principal_id
  depends_on = [
    azurerm_user_assigned_identity.nodejs_app_identity
  ]
}

resource "azurerm_role_assignment" "react_app_identity" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "acrpull"
  principal_id         = azurerm_user_assigned_identity.react_app_identity.principal_id
  depends_on = [
    azurerm_user_assigned_identity.react_app_identity
  ]
}


