resource "azurerm_user_assigned_identity" "nodejs_app_identity" {
  name                = "identity-formation-frct-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_user_assigned_identity" "react_app_identity" {
  name                = "identity-formation-frct-02"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
