resource "azurerm_postgresql_flexible_server" "pg" {
  name                = "${var.clinic_name}-pg"
  location            = var.location
  resource_group_name = var.resource_group

  version                       = "16"
  administrator_login           = var.db_username
  administrator_password        = var.db_password
  storage_mb                    = 32768
  zone                          = "1"
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false

  sku_name = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "pgdb" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.pg.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

output "db_fqdn" {
  value = azurerm_postgresql_flexible_server.pg.fqdn
}

output "db_name" {
  value = azurerm_postgresql_flexible_server_database.pgdb.name
}

output "db_username" {
  value = azurerm_postgresql_flexible_server.pg.administrator_login
}
