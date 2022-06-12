/*
Name: sre-vnet.tf
Purpose: Defination of modules and passing values to resources defined in application/ folder
Version:
S.no | version | Updated by | Updated on | Description
--------------------------------------------------------
0    | 0.1    | Shailender   | 3rd Dec 2020 | Created this module file to build SRE vNET

How it works?
 - We pass values from module to application/azure resources that we would like to build and we provide all ...
 - tuning parameters from here. So it is a central place where we pass all variable values to module through ...
 - terraform.tfvars file.
*/


provider "azurerm" {
  features {}
}

module "defaults" {
  source = "../defaults"
}

module "sre-vnet" {
#  source                   = "github.com/shailendersinghchauhan/infra-as-codes/azure/vnet?ref=develop"
  source                   = "../../../../../azure/vnet"

  environment_name         = var.environment_name
  product                  = var.product
  sub_product              = var.sub_product
  managed_by               = var.managed_by
  dev_owner                = var.dev_owner
  project                  = var.project
  service_name             = var.service_name
  component                = var.component
  azure_region             = var.azure_region
  azure_short_region       = var.azure_short_region
  owner                    = var.owner
  vnet_cidr_block          = var.vnet_cidr_block
  mgmt_cidr_block         = var.mgmt_cidr_block
  app_cidr_block         = var.app_cidr_block
  public_access_cidr_block = "0.0.0.0/0"


}

#Setup for keeping traffic internal using endpoint resource.


# set up DHCP options set on vNET in case available on Azure using assocition resource