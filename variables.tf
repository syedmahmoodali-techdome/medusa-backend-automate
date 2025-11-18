variable "clinic_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group" { type = string }

variable "app_service_name" { type = string }

variable "acr_name" { type = string }
variable "image_repo_name" { type = string }
variable "image_tag" { type = string }

variable "github_repo" { type = string }
variable "github_branch" { type = string }

variable "admin_email" { type = string }
variable "admin_password" { type = string }

variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }

variable "branding_store_name" { type = string }
variable "branding_region" { type = string }
