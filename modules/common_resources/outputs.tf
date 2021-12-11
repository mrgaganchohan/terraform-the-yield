output "name_of_rg" {
  value       = azurerm_resource_group.rg-yield-dev.name
  description = "Name of the resource group"
}

output "yield_service_plan_name" {
    value = azurerm_app_service_plan.plan-yield-app.id
}