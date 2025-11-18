resource "random_password" "pg_password" {
  length  = 20
  special = true
  override_special = "!@"
  keepers = {
    # ensure regeneration only if input password empty
    provided = var.db_password != "" ? "provided" : ""
  }
}

locals {
  final_db_password = var.db_password != "" ? var.db_password : random_password.pg_password.result
}

resource "azurerm_postgresql_flexible_server" "pg" {
  name                   = "${var.clinic_name}-pg-${var.environment}"
  resource_group_name    = var.resource_group
  location               = var.location
  administrator_login    = var.db_username
  administrator_password = local.final_db_password
  sku_name               = "Standard_B1ms"
  version                = "14"
  storage_mb             = 32768
  backup_retention_days  = 7
  tags                   = var.tags
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.pg.fqdn
}

output "db_password" {
  value = local.final_db_password
}
