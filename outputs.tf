output "backend_url" {
  value = "https://${module.app.default_site_hostname}"
}

output "admin_email" {
  value = var.admin_email
}

output "admin_password" {
  value = var.admin_password
}

output "resource_group" {
  value = module.rg.name
}

output "environment" {
  value = var.environment
}

# dump useful values as well
output "acr_login_server" {
  value = module.acr.login_server
}
