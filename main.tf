terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Sumit_TEST-RG"
    storage_account_name = "sumitvatsstorage1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    subscription_id      = "8b10287d-12d6-41e3-b62c-33457c006e96"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8b10287d-12d6-41e3-b62c-33457c006e96"
}

resource "azurerm_resource_group" "testrg" {
  name     = "testrg1"
  location = "Central India"
}

resource "azurerm_storage_account" "testsa" {
  name                     = "storagevatssumit"
  resource_group_name      = azurerm_resource_group.testrg.name
  location                 = azurerm_resource_group.testrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "testsc" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.testsa.id
  container_access_type = "blob"
}

resource "azurerm_storage_container" "testsc1" {
  name                  = "tfstate1"
  storage_account_id    = azurerm_storage_account.testsa.id
  container_access_type = "private"
}
