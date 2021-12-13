resource "azurerm_app_service" "app-service-yield-frontend" {
  name                = "app-service-yield-frontend"
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = var.service_plan_yield_id

  site_config {
    linux_fx_version = "node|14-lts"
    app_command_line = "npm run start"
  }
}

