terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group
module "rg" {
  source = "./modules/resource_group"
  location = var.location
  resource_group_name = var.resource_group
  tags = var.tags
}

# ACR
module "acr" {
  source = "./modules/acr"
  resource_group = module.rg.name
  location = var.location
  acr_name = var.acr_name
  tags = var.tags
}

# Postgres
module "postgres" {
  source = "./modules/postgres"
  clinic_name = var.clinic_name
  location = var.location
  resource_group = module.rg.name
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  tags = var.tags
}

# App Service & wiring
module "app" {
  source = "./modules/app_service"
  resource_group = module.rg.name
  location = var.location
  service_plan_name = "${var.clinic_name}-plan"
  app_service_name = var.app_service_name

  acr_login_server = module.acr.login_server
  acr_admin_username = module.acr.admin_username
  acr_admin_password = module.acr.admin_password

  image_repo_name = var.image_repo_name
  image_tag = var.image_tag

  environment = var.environment
  admin_email = var.admin_email
  admin_password = var.admin_password

  db_fqdn = module.postgres.db_fqdn
  db_username = module.postgres.db_username
  db_password = var.db_password

  branding_store_name = var.branding_store_name

  tags = var.tags
}
