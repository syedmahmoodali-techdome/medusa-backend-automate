resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.plan.id
  resource "azurerm_service_plan" "plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = azurerm_service_plan.plan.id

  # Required — must exist but DO NOT set linux_fx_version (Terraform manages this)
  site_config {}

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "NODE_ENV"                            = var.environment

    "MEDUSA_ADMIN_EMAIL"    = var.admin_email
    "MEDUSA_ADMIN_PASSWORD" = var.admin_password

    "DATABASE_HOST"     = var.db_fqdn
    "DATABASE_PORT"     = "5432"
    "DATABASE_NAME"     = var.db_name
    "DATABASE_USERNAME" = var.db_username
    "DATABASE_PASSWORD" = var.db_password

    "BRANDING_STORE_NAME" = var.branding_store_name
  }

  identity {
    type = "SystemAssigned"
  }
}

output "app_service_name" {
  value = var.app_service_name
}

output "default_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}


  # Do NOT configure container image here.
  # Terraform can no longer manage linux_fx_version when using the new provider.
  # The pipeline will configure the container with:
  #   az webapp config container set --docker-custom-image-name ...

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "NODE_ENV"                            = var.environment

    "MEDUSA_ADMIN_EMAIL"    = var.admin_email
    "MEDUSA_ADMIN_PASSWORD" = var.admin_password

    "DATABASE_HOST"     = var.db_fqdn
    "DATABASE_PORT"     = "5432"
    "DATABASE_NAME"     = var.db_name
    "DATABASE_USERNAME" = var.db_username
    "DATABASE_PASSWORD" = var.db_password

    "BRANDING_STORE_NAME" = var.branding_store_name

    # DO NOT SET THESE (Azure prohibits it)
    # "DOCKER_REGISTRY_SERVER_URL"      = ...
    # "DOCKER_REGISTRY_SERVER_USERNAME" = ...
    # "DOCKER_REGISTRY_SERVER_PASSWORD" = ...
  }

  identity {
    type = "SystemAssigned"
  }
}

output "app_service_name" {
  value = var.app_service_name
}

output "default_hostname" {
  value = azurerm_linux_web_app.app.default_hostname
}
