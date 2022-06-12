variable environment_name {}
variable product {}
variable project {}
variable service_name {}
variable component {}
variable azure_region {}
variable azure_short_region {}

variable azure_subscription {}
variable storage_account_name {}
variable blob_container_name {}
variable base_state_key {}
variable statefile_suffix {}

variable dev_owner {
  type = string
  default = "Shailender Singh"
}
variable managed_by {
  type        = string
  description = "Resource group/project managed by."
  default     = "abc@gmail.com"
}
variable owner {
  type        = string
  description = "project owner, set this for specialized/dedicated VNETs"
  default     = "Shailender Singh"
}
variable sub_product {
  type = string
  default = "ZB1"
}
# Standard Default values across your company but it can be changed as per your requirements

variable "vnet_cidr_block" {
  type        = string
  description = "CIDR block for entire VNET"
  default     = "10.10.0.0/24"
}
variable "mgmt_cidr_block" {
  type        = string
  description = "Mgmt layer CIDR block"
  default     = "10.10.0.0/25"
}
variable "app_cidr_block" {
  type        = string
  description = "CIDR block for entire Application/Service"
  default     = "10.10.0.128/25"
}
variable "external_cidr_blocks" {
  type        = string
  description = "External-facing CIDR blocks for office and DCs"
  default = ""
}
variable "corp_cidr_blocks" {
  type        = list
  description = "Corpnet CIDR blocks"
  default     = [
    "10.10.0.0/27",
    "10.10.0.0/28"
  ]
}
variable "whitelist_cidr_blocks" {
  type        = string
  description = "External CIDR blocks for whitelisting SG rules"
  default     = ""
}

