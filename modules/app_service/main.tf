resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = "P1v2"
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${var.acr_login_server}/${var.image_repo_name}:${var.image_tag}"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "NODE_ENV" = var.environment

    "MEDUSA_ADMIN_EMAIL"    = var.admin_email
    "MEDUSA_ADMIN_PASSWORD" = var.admin_password

    "DATABASE_HOST"     = var.db_fqdn
    "DATABASE_PORT"     = "5432"
    "DATABASE_NAME"     = var.db_name
    "DATABASE_USERNAME" = var.db_username
    "DATABASE_PASSWORD" = var.db_password

    "BRANDING_STORE_NAME" = var.branding_store_name

    "DOCKER_REGISTRY_SERVER_URL"      = "https://${var.acr_login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = var.acr_admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = var.acr_admin_password
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

output "app_service_name" {
  value = var.app_service_name
}

output "default_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}
