terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

//recurso a ser criado no azure
//aula_rg é nome no terraform,   aula-rg é nome que será no azure
resource "azurerm_resource_group" "aula_rg" {
  name     = "aula-rg"
  location = "East US"
}