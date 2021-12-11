# Create a resource group
resource "azurerm_resource_group" "rg-yield-dev" {
  name     = "rg-yield-app"
  location = "Australia Southeast"
}

