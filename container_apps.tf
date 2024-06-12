resource "azurerm_container_app_environment" "env" {
  name                     = "env-formation-frct-01"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  infrastructure_subnet_id = azurerm_subnet.subnet.id
}


resource "azurerm_container_app" "nodejs_app" {
  name                         = "nodejs-app"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"
  depends_on                   = [null_resource.docker_push]

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.nodejs_app_identity.id]
  }

  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.nodejs_app_identity.id
  }

  template {
    container {
      name   = "nodejs"
      image  = "${azurerm_container_registry.acr.login_server}/nodejs:latest"
      cpu    = 0.25
      memory = "0.5Gi"

      /*env {
        name  = "AZURE_COSMOS_CONNECTION_STRING"
        value = azurerm_key_vault_secret.cosmosdb_connection_string.value
      }

      env {
        name  = "AZURE_COSMOS_DATABASE_NAME"
        value = "Todo"
      }

      env {
        name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
        value = azurerm_key_vault_secret.app_insights_connection_string.value
      }

      env {
        name  = "APPLICATIONINSIGHTS_ROLE_NAME"
        value = "API"
      }*/
    }
  }

  /*ingress {
    external_enabled = true  // Allow external access
    target_port      = 3100     // Assuming your Node.js app uses port 3100
    traffic_weight {
      latest_revision = true
      percentage = 100
    }

  }*/

}

resource "azurerm_container_app" "react_app" {
  name                         = "react-app"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"
  depends_on                   = [null_resource.docker_push]

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.react_app_identity.id]
  }

  registry {
    server   = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.react_app_identity.id
  }

  template {
    container {
      name   = "react"
      image  = "${azurerm_container_registry.acr.login_server}/react:latest"
      cpu    = 0.25
      memory = "0.5Gi"

      /*env {
        name  = "VITE_API_BASE_URL"
        value = "http://nodejs-app:3100"
      }

      env {
        name  = "VITE_APPLICATIONINSIGHTS_CONNECTION_STRING"
        value = azurerm_key_vault_secret.app_insights_connection_string.value
      }*/
    }
  }

  /*ingress {
    external_enabled = true  // Allow external access
    target_port      = 3000    // Assuming your React app uses port 3000
    traffic_weight {
      latest_revision = true
      percentage = 100
    }

  }*/
}
