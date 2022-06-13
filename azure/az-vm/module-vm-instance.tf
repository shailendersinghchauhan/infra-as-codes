

resource "azurerm_network_interface" "main" {
  name = join("-", list(var.environment_name,var.product,var.project,var.service_name,var.component,var.azure_short_region,"nic"))
  location            = var.azure_region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = join("-", list(var.environment_name,var.product,var.project,var.service_name,var.component,var.azure_short_region,"nic-ipconfig"))
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "az_windows_vm_main" {
 count                 = 1
  name = join("-", list(var.environment_name,var.product,var.project,var.service_name,"${var.component}${count.index}",var.azure_short_region,"vm"))
 location              = var.azure_region
 resource_group_name   = var.resource_group_name
  size                = "B1ms"
  #size                = "Standard_F2"
  admin_username      = "Administrator"
  admin_password      = "Password@123"

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    name = join("-", list(var.environment_name,var.product,var.project,var.service_name,var.component,var.azure_short_region,"jumphost-vm"))
    owner = var.owner
    managed_by = var.managed_by
    created_by= var.created_by
  }
}

output "az_windows_vm_main" {
  value = azurerm_windows_virtual_machine.az_windows_vm_main.name
}