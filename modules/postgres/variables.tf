variable "clinic_name" { type = string }
variable "location" { type = string }
variable "resource_group" { type = string }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }
variable "tags" { type = map(string) default = {} }
