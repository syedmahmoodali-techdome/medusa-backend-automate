variable "resource_group" { type = string }
variable "location" { type = string }
variable "service_plan_name" { type = string }
variable "app_service_name" { type = string }

variable "acr_login_server" { type = string }
variable "acr_admin_username" { type = string }
variable "acr_admin_password" { type = string }

variable "image_repo_name" { type = string }
variable "image_tag" { type = string }

variable "environment" { type = string }
variable "admin_email" { type = string }
variable "admin_password" { type = string }

variable "db_fqdn" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }

variable "branding_store_name" { type = string }

variable "tags" { type = map(string) }
