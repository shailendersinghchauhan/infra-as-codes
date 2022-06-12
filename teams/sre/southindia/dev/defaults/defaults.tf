variable azure_region {
  type        = string
  description = "Azure deployment region"
  default     = "southindia"
}

variable storage_account_name {
  type = string
  default = "devzb1serviceatfsasi"
}
variable blob_container_name {
  default = "projectaservicea-sre-si-tf"
}
variable "azure_subscription" {
  default = "283c6862-f3c8-4296-83d4-72e662338850"
}
variable base_state_key {
  default = "/southindia/vnet-dev/"
  #default = "283c6862-f3c8-4296-83d4-72e662338850/southindia/vnet-dev/"
}

variable vnet_state_key {
  default = "vnet/terraform.tfstate"
}
/*
output "vnet_state_key" {
  value = var.vnet_state_key
}
*/
output "vnet_full_state_key" {
  value = "${var.azure_subscription}${var.base_state_key}${var.vnet_state_key}"
}
#Only call for very first time so that you can reference it on second run as other wise it will report error on first
# terraform plan execution';[
data "terraform_remote_state" "CurrentVNET" {
  backend = "azurerm"

  config = {
    storage_account_name = var.storage_account_name
    container_name = var.blob_container_name
    key    = "${var.azure_subscription}${var.base_state_key}${var.vnet_state_key}"

  }
}
/*
output "resource_group_name" {
  value = data.terraform_remote_state.CurrentVNET.outputs.resource_group
}
output "vnet_name" {
  value = data.terraform_remote_state.CurrentVNET.outputs.vnet_name
}
output "mgmt_subnet_group" {
  value = data.terraform_remote_state.CurrentVNET.outputs.mgmt_subnet_group
}
*/
#NOTE: Shailender: On first execution like vpc creation or service creation comment out following block as it gives error that it can't found resource
#       attribute so after commenting it will work and once you gets .tfstate file then uncomment it so that it can read values from s3 bucket
/*
output "environment_name" {
  value = data.terraform_remote_state.CurrentVNET.outputs.environment_name
}
output "service_name" {
  value = data.terraform_remote_state.CurrentVNET.outputs.service_name
}
output "azure_region" {
  value = data.terraform_remote_state.CurrentVNET.outputs.azure_region
}
*/

/*
output "azure_subscription" {
  value = data.terraform_remote_state.CurrentVNET.outputs.azure_subscription
}
output "blob_container_name" {
  value = data.terraform_remote_state.CurrentVNET.outputs.blob_container_name
}
output "base_state_key" {
  value = data.terraform_remote_state.CurrentVNET.outputs.base_state_key
}
*/