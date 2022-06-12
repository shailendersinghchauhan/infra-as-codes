
resource "azurerm_network_security_group" "mgmt_nsg" {
  name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"mgmt-nsg"]))
  location      = var.azure_region
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"mgmt-nsg"]))
    managed_by = var.managed_by
    owner = var.owner
    created_by = var.created_by
    description = "Allow Mgmt traffic"
    layer = "mgmt"
  }
}

resource "azurerm_network_security_group" "app_nsg" {
  name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"app-nsg"]))
  location      = var.azure_region
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"app-nsg"]))
    managed_by = var.managed_by
    owner = var.owner
    created_by = var.created_by
    description = "Allow Application traffic"
    layer = "app"
  }
}

resource "azurerm_network_security_group" "web_nsg" {
  name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"web-nsg"]))
  location      = var.azure_region
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"web-nsg"]))
    managed_by = var.managed_by
    owner = var.owner
    created_by = var.created_by
    description = "Allow Web Application traffic"
    layer = "web"
  }
}

resource "azurerm_network_security_group" "public_nsg" {
  name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"public-nsg"]))
  location      = var.azure_region
  resource_group_name = azurerm_resource_group.resource_group.name

  tags = {
    name = join("-", tolist([var.environment_name,var.product,var.project,var.service_name,var.azure_short_region,"public-nsg"]))
    managed_by = var.managed_by
    owner = var.owner
    created_by = var.created_by
    description = "Allow Public traffic"
    layer = "public"
  }
}

output "mgmt_network_security_group" {
  value = azurerm_network_security_group.mgmt_nsg.name
}
output "app_network_security_group" {
  value = azurerm_network_security_group.app_nsg.name
}
output "web_network_security_group" {
  value = azurerm_network_security_group.web_nsg.name
}
output "public_network_security_group" {
  value = azurerm_network_security_group.public_nsg.name
}

output "vnet_network_security_group_map" {
  value = tomap({"mgmt_network_security_group" = azurerm_network_security_group.mgmt_nsg.name,
  "app_network_security_group" =azurerm_network_security_group.app_nsg.name ,
  "web_network_security_group" = azurerm_network_security_group.web_nsg.name ,
   "public_network_security_group" = azurerm_network_security_group.public_nsg.name })
}
