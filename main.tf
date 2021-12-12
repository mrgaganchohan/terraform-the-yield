terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "common_resources" {
  source = "./modules/common_resources"

}
module "frontend" {
  source = "./modules/frontend"
  rg_name = "${module.common_resources.name_of_rg}"
  service_plan_yield_id = "${module.common_resources.yield_service_plan_name}"
}

module "backend" {
  source = "./modules/backend"
  rg_name = "${module.common_resources.name_of_rg}"
  service_plan_yield_id = "${module.common_resources.yield_service_plan_name}"
}