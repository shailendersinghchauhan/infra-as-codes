
resource "azurerm_subnet" "mgmt" {
  name = join("-", tolist([var.environment_name, var.product, var.project, var.service_name, var.component, var.azure_short_region, "mgmt", "subnet"]))
  resource_group_name = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [var.mgmt_cidr_block]
# Tags are not allowed in Azure subnets
}
resource "azurerm_subnet" "app" {
  name = join("-", tolist([var.environment_name, var.product, var.project, var.service_name, var.component, var.azure_short_region, "app", "subnet"]))
  resource_group_name = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [var.app_cidr_block]
# Tags are not allowed in Azure subnets
}

# export subnet id's for further user
output "mgmt_subnet_group" {
  value = azurerm_subnet.mgmt.id
}
output "app_subnet_map" {
  value = azurerm_subnet.app.id
}

# Only to print on screen
output "vnet_subnet_map" {
  value = tomap({
      "app_subnet_group" = azurerm_subnet.app.id,
      "mgmt_subnet_group" = azurerm_subnet.mgmt.id }
    )
}


