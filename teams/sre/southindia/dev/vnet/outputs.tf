output "resource_group" {
  value = module.sre-vnet.resource_group
}
output "vnet_name" {
  value = module.sre-vnet.vnet_name
}
output "mgmt_subnet_group" {
  value = module.sre-vnet.mgmt_subnet_group
}
output "app_subnet_group" {
  value = module.sre-vnet.app_subnet_map
}
output "vnet_subnet_map" {
  value = module.sre-vnet.vnet_subnet_map
}
output "mgmt_network_security_group" {
  value = module.sre-vnet.mgmt_network_security_group
}
output "app_network_security_group" {
  value = module.sre-vnet.app_network_security_group
}
output "web_network_security_group" {
  value = module.sre-vnet.web_network_security_group
}
output "vnet_network_security_group_map" {
  value = module.sre-vnet.vnet_network_security_group_map
}