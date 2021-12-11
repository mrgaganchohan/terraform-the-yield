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
}