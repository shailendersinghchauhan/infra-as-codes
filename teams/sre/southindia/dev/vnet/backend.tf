terraform {
  required_version = "> 0.12.0"

  backend "azurerm" {
      # Configured from command line in terraform-init.sh to allow for vnet-level shared info
      # base_state_key is defined in VNET level
  }
}
