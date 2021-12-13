# Create a resource group
resource "azurerm_resource_group" "rg-yield-dev" {
  name     = "rg-yield-app"
  location = var.location
}

resource "azurerm_app_service_plan" "plan-yield-app" {
  name                = "plan-yield-app"
  location            = var.location
  kind                = "Linux"
  reserved = true
  resource_group_name = azurerm_resource_group.rg-yield-dev.name

  sku {
    tier = "Standard"
    size = "S3"
  }
}
