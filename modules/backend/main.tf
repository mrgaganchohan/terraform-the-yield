resource "azurerm_app_service" "app-service-yield-servicebus-queue-sender" {
  name                = "app-service-yield-servicebus-queue-sender"
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = var.service_plan_yield_id

  site_config {
    linux_fx_version = "node|14-lts"
    app_command_line = "npm run start"

  }
}

resource "azurerm_app_service" "app-service-yield-servicebus-queue-consumer" {
  name                = "app-service-yield-servicebus-queue-consumer"
  location            = var.location
  resource_group_name = var.rg_name
  app_service_plan_id = var.service_plan_yield_id

  site_config {
    linux_fx_version = "node|14-lts"
    app_command_line = "npm run start"

  }
}
# creating service bus queue here
resource "azurerm_servicebus_namespace" "sb-yield-service-bus" {
  name                = "sb-yield-service-bus"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_servicebus_queue" "sbq-yield-service-bus-queue" {
  name                = "sbq-yield-service-bus-queue"
  resource_group_name = var.rg_name
  namespace_name      = azurerm_servicebus_namespace.sb-yield-service-bus.name

}

