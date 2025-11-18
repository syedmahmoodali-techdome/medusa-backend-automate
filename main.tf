terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">=3.0" }
    random  = { source = "hashicorp/random" , version = ">=3.0" }
  }
  required_version = ">= 1.3"
}

provider "azurerm" {
  features {}
}

# Read JSON config (terraform tfvars.json will be written by pipeline from medusa-deploy-config.json)
# Variables come from variables.tf
module "rg" {
  source = "./modules/resource_group"
  resource_group = var.resource_group
  location       = var.location
  tags           = var.tags
}

module "acr" {
  source = "./modules/acr"
  acr_name        = var.acr_name
  resource_group  = module.rg.name
  location        = var.location
  tags            = var.tags
}

module "postgres" {
  source = "./modules/postgres"

  clinic_name    = var.clinic_name
  location       = var.location
  resource_group = module.rg.name

  db_name     = "${var.clinic_name}db"
  db_username = var.db_username
  db_password = var.db_password

  tags = var.tags
}


module "app" {
  source = "./modules/app_service"
  resource_group = module.rg.name
  location       = var.location
  service_plan_name = "${var.clinic_name}-plan-${var.environment}"
  app_service_name   = var.app_service_name
  acr_login_server   = module.acr.login_server
  acr_admin_username = module.acr.admin_username
  acr_admin_password = module.acr.admin_password
  image_repo_name    = var.image_repo_name
  image_tag          = var.image_tag
  environment        = var.environment
  admin_email        = var.admin_email
  admin_password     = var.admin_password
  db_fqdn            = module.postgres.fqdn
  db_username        = var.db_username
  db_password        = module.postgres.db_password
  branding_store_name = var.branding_store_name
  tags               = var.tags
}
