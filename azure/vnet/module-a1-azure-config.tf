variable "environment_name" {}
variable "product" {}
variable "project" {}
variable "service_name" {}
variable "component" {}
variable azure_region {}
variable azure_short_region {}
variable dev_owner {}
variable managed_by {}
variable sub_product {}

variable vnet_cidr_block {}
variable mgmt_cidr_block {}
variable app_cidr_block {}

variable owner {}

variable allowed_subscriptionid {
  type        = string
  description = "Subscription id to use, to avoid accidental usage"
  default     = ""
}
variable created_by {
  type = string
  default = "Terraform"
}

variable corp_cidr_blocks {
  type        = list
  description = "Corpnet Source CIDR Blocks"
  default     = [ "10.0.0.0/8" ]
}

variable public_access_cidr_block {
  type        = string
  description = "Widest Possible Access CIDR Block"
  default     = "0.0.0.0/0"
}

# List of Data Center CIDR blocks
# Overriding the defaults value with an empty list will break this module.
variable dc_cidr_blocks {
  type        = list
  description = "Data Center CIDR Block List"
  default     = ["10.10.0.0/16"]
}

