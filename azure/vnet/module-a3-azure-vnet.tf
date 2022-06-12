

# RG name example: dev-zb-servicea-0-si-rg

resource "azurerm_virtual_network" "main" {
  resource_group_name = azurerm_resource_group.resource_group.name
  name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.component,var.azure_short_region,"vnet"]))
  location = var.azure_region
  address_space = [var.vnet_cidr_block]

  # Add support for public DNS hostnames, so services like AFS work properly
  #enable_dns_hostnames = true

  tags = {
    name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.component,var.azure_short_region,"vnet"]))
    sub_product = var.sub_product
    owner = var.owner
    managed_by = var.managed_by
    created_by= var.created_by
  }
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}