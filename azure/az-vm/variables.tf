variable "environment_name" {}
variable "product" {}
variable "project" {}
variable "service_name" {}
variable "component" {}
variable azure_region {}
variable azure_short_region {}
variable "resource_group_name" {}
variable owner {}
variable "managed_by" {}
variable created_by {
  type = string
  default = "Terraform"
}
variable "subnet_id" {}