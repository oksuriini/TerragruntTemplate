resource "azurerm_resource_group" "example" {
  name     = "rg-example-${var.project_name}-${var.environment}"
  location = "North Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "vn-example-${var.environment}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = var.address_space
}
