output "cosmosdb_connection_string" {
  value     = azurerm_cosmosdb_account.cosmosdb.connection_strings[0]
  sensitive = true
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.subnet.name
}

output "key_vault_id" {
  description = "The ID of the key vault"
  value       = azurerm_key_vault.keyvault.id
}

output "cosmosdb_endpoint" {
  description = "The endpoint of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmosdb.endpoint
}

output "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "nodejs_app_identity_id" {
  description = "The ID of the user-assigned identity for the Node.js app"
  value       = azurerm_user_assigned_identity.nodejs_app_identity.id
}

output "react_app_identity_id" {
  description = "The ID of the user-assigned identity for the React app"
  value       = azurerm_user_assigned_identity.react_app_identity.id
}


output "instrumentation_key" {
  value = azurerm_application_insights.app_insights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.app_insights.app_id
}

output "app_insights_connection_string" {
  value = azurerm_application_insights.app_insights.connection_string
  sensitive = true
}