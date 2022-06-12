


# RG name example: dev-zb-servicea-0-si-rg



resource "azurerm_resource_group" "resource_group" {
  name     = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"rg"]))
  location = var.azure_region

   tags = {
     name     = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"rg"]))
     sub_product = var.sub_product
     managed_by = var.managed_by
     created_by= var.created_by
  }
}

output resource_group {
  value = azurerm_resource_group.resource_group.name
}