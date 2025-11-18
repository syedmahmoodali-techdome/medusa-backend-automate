output "backend_url" {
  value = azurerm_linux_web_app.app.default_hostname
  description = "Medusa backend URL"
}

output "acr_name" {
  value = module.acr.name
}

output "acr_login_server" {
  value = module.acr.login_server
}

output "app_service_name" {
  value = module.app.app_service_name
}

output "resource_group_name" {
  value = module.rg.name
}

output "db_host" {
  value = module.postgres.db_fqdn
}

output "db_port" {
  value = 5432
}

output "db_name" {
  value = module.postgres.db_name
}

output "db_user" {
  value = module.postgres.db_username
}

output "db_password" {
  value = var.db_password
}
