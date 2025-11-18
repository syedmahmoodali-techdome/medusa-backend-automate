resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Basic"
  admin_enabled       = true
}

output "name" { value = azurerm_container_registry.acr.name }
output "login_server" { value = azurerm_container_registry.acr.login_server }
output "admin_username" { value = azurerm_container_registry.acr.admin_username }
# admin passwords are only available via azure cli in pipeline; we still expose empty placeholder
output "admin_password" { value = "" }
