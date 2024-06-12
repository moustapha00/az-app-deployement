resource "azurerm_container_registry" "acr" {
  name                = "acrformationfrct01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium" #"Basic"
  admin_enabled       = true       # optional
}


resource "null_resource" "docker_push" {
  depends_on = [azurerm_container_registry.acr]

  provisioner "local-exec" {
    command = <<-EOF
      # Login to ACR
      az acr login --name ${azurerm_container_registry.acr.name}

      # Tag and push the web app Docker image
      docker tag react:latest ${azurerm_container_registry.acr.login_server}/react:latest
      docker push ${azurerm_container_registry.acr.login_server}/react:latest

      # Tag and push the API Docker image
      docker tag nodejs:latest ${azurerm_container_registry.acr.login_server}/nodejs:latest
      docker push ${azurerm_container_registry.acr.login_server}/nodejs:latest
    EOF
  }
}
