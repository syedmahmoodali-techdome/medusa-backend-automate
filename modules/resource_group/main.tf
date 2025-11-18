resource "azurerm_resource_group" "this" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}

output "name" {
  value = azurerm_resource_group.this.name
}
