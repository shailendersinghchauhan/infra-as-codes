# Created Mgmt rules for demo purpose and we can customize all required rules
resource "azurerm_network_security_rule" "mgmt_ssh_access_allow" {
  name                        = "mgmt_ssh_access_allow"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes       = var.corp_cidr_blocks
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.mgmt_nsg.name
}
resource "azurerm_network_security_rule" "mgmt_rdp_access_allow" {
  name                        = "mgmt_rdp_access_allow"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefixes       = var.corp_cidr_blocks
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.mgmt_nsg.name
}
resource "azurerm_network_security_rule" "mgmt_ntp_access_allow" {
  name                        = "mgmt_ntp_access_allow"
  priority                    = 103
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Udp"
  source_port_range           = "*"
  destination_port_range      = "123"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.mgmt_nsg.name
}
#NOTE: {shailender 5/1/2/2020 }
# We will use for-each loop instead of creating independent Azure resource
resource "azurerm_network_security_rule" "mgmt_ssh_access_deny" {
  name                        = "mgmt_ssh_access_deny"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.mgmt_nsg.name
}
